import pandas as pd 
import os 

def progress_bar(current, total, bar_length=20):
    fraction = current / total

    arrow = int(fraction * bar_length - 1) * '-' + '>'
    padding = int(bar_length - len(arrow)) * ' '

    ending = '\n' if current == total else '\r'

    print(f'Progress: [{arrow}{padding}] {int(fraction*100)}%', end=ending)
    
#-------------------------------
def evaluate(data, id_col , data_col):
    clean = pd.DataFrame()
    cnt_eval = 0 
    error_index = []
    for i in range(data.shape[0]):
        try:
            data_str = data[data_col][i]
            res = list(eval(data_str))
            res = pd.DataFrame(res)
            res["movie_id"] = data[id_col][i]
            clean = pd.concat([clean, res] , axis = 0 , ignore_index = True)
            progress_bar(i,data.shape[0])
        except:
            cnt_eval +=1
            error_index.append(i)
    if cnt_eval == 0 :
        print("done all data evaluated")
    else :
        print (f'can not evaluate {cnt_eval} raws')
    return error_index, clean

#------------------------------
def create_dir(direction):
    try:
        os.makedirs(direction)
    except FileExistsError:
        print("File Exist")