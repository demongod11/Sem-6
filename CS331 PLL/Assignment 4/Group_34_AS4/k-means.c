#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <string.h>

void standard_scaler(double **X, int n_samples, int n_features) {
    double mean, variance, std_dev;
    int i, j;

    for (j = 0; j < n_features; j++) {
        mean = 0.0;
        variance = 0.0;
        for (i = 0; i < n_samples; i++) {
            mean += X[i][j];
        }
        mean /= n_samples;

        for (i = 0; i < n_samples; i++) {
            variance += pow(X[i][j] - mean, 2);
        }
        variance /= (n_samples - 1);

        std_dev = sqrt(variance);
        for (i = 0; i < n_samples; i++) {
            X[i][j] = (X[i][j] - mean) / std_dev;
        }
    }
}

int main() {
    int i, j, n, no_iter;
    double sum, min_dist, dist;
    FILE* fp = fopen("universe.txt", "r");
    char buf[1024];
    int cols=0,rows=0;
    char* tmp;

    fgets(buf,1024,fp);
    tmp = strtok(buf, "  ");
    while(tmp!=NULL){
        cols++;
        tmp=strtok(NULL,"  ");
    } 
    fseek(fp, 0, SEEK_SET);
    while(fgets(buf,1024,fp)){
        rows++;
    }
    fseek(fp, 0, SEEK_SET);
    cols--;
    double** data = (double**)malloc(rows * sizeof(double*));
    for(i = 0; i < rows; i++){
        data[i] = (double*)malloc(cols * sizeof(double));
    }
    i=0;j=0;
    while(fgets(buf, 1024, fp)){
        j=0;
        tmp = strtok(buf, "  ");
        while(tmp!=NULL){
            data[i][j] = atof(tmp);
            j++;
            tmp=strtok(NULL,"  ");
        }
        i++;
    }
    fclose(fp);

    FILE *fw ; 
    fw = fopen("universe_clusters.txt", "w");


    int K;
    printf("Enter the number of clusters:\n");
    scanf("%d", &K);
    printf("Enter the number of iterations:\n");
    scanf("%d", &no_iter);
    printf("\n");

    double** centers = (double**)malloc(K*sizeof(double*));
    double** prev_centers = (double**)malloc(K*sizeof(double*));
    for(i=0; i<K; i++){
        centers[i] = (double*)malloc(cols*sizeof(double));
        prev_centers[i] = (double*)malloc(cols*sizeof(double));
    }

    int* labels = (int*)malloc(rows*sizeof(int));
    int* counts = (int*)malloc(K*sizeof(int));

    srand(time(NULL));

    double** data_original = (double**)malloc(rows * sizeof(double*));
    for(i = 0; i < rows; i++){
        data_original[i] = (double*)malloc(cols * sizeof(double));
    }

    for(int i=0; i<rows; i++){
        for(int j=0; j<cols; j++){
            data_original[i][j] = data[i][j];
        }
    }

    standard_scaler(data, rows, cols);

    for(i=0; i<K; i++){
        int t1 = rand()%rows;
        for(int y=0; y<cols; y++){
            centers[i][y] = data[t1][y];
            prev_centers[i][y] = centers[i][y];
        }
    }

    for (int iter = 0; iter < no_iter; iter++) {
        for (i = 0; i < rows; i++) {
            min_dist = INFINITY;
            for (j = 0; j < K; j++) {
                dist=0;
                for(int k=0; k<cols; k++){
                    dist=dist+(data[i][k]-centers[j][k])*(data[i][k]-centers[j][k]);
                }
                dist=sqrt(dist);
                if (dist < min_dist){
                    min_dist = dist;
                    labels[i] = j;
                }
            }
        }

        for (j = 0; j < K; j++) {
            counts[j] = 0;
            for(i=0; i<cols; i++){
                centers[j][i]=0;
            }
            for (i = 0; i < rows; i++) {
                if (labels[i] == j) {
                    for(int k=0; k<cols; k++){
                        centers[j][k]+=(data[i][k]);
                    }
                    counts[j]++;
                }
            }
            if (counts[j] > 0) {
                for(int k=0; k<cols; k++){
                    centers[j][k] = centers[j][k]/counts[j];
                }
            }
        }
        int cntr=0;
        for(i=0; i<K; i++){
            for(j=0; j<cols; j++){
                if(prev_centers[i][j] == centers[i][j]){
                    cntr++;
                }
                prev_centers[i][j] = centers[i][j];
            }
        }
        if(cntr == K*cols){
            fprintf(fw, "K-means has converged after %d iterations\n\n", iter+1);
            printf("K-means has converged after %d iterations\n\n", iter+1);
            break;
        }
        if(iter == no_iter-1){
            fprintf(fw, "K-means has been executed for %d iterations\n\n", no_iter);
            printf("K-means has been executed for %d iterations\n\n", no_iter);
        }
    }

    fprintf(fw, "These are the final %d centroids (Scaled Version):\n", K);
    for(i=0; i<K; i++){
        for(j=0; j<cols; j++){
            fprintf(fw, "%lf ", centers[i][j]);
        }
        fprintf(fw, "\n");
    }
    fprintf(fw, "\n");
    fprintf(fw, "Final Predicted Clusters:\n");
    for (int i = 0; i < rows; i++) {
        for(int j=0; j<cols; j++){
            fprintf(fw, "%lf ", data_original[i][j]);
        }
        fprintf(fw, " ----->    Cluster %d\n", labels[i]+1);
    }
    fclose(fw);

    return 0;
}