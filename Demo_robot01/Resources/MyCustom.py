from _ast import If
class   Custom_Validate:
    
    def checkDepartment(self, var_department, *var_list):
        
        for item in var_list:
            if (var_department == item):
                return True
    
    
    def checkInfo(self, var_name, var_account,**var_dict):  
              
        if (var_name.lower() == var_dict["name"]): 
            if (var_account.lower() == var_dict["account"]):
                return True
            else:
                return False
        else:
            return False
        
validate = Custom_Validate() 