unit untForTagController;

interface

uses Uni, UniClientDataSet, SysUtils, Classes;

type
  TForTagController = class
    public
      function fGravar(cdsForTag: TUniClientDataSet; strCodEmp: String): Boolean;
      function fFornecedorTigreConfigurado(strCodEmp: String): Boolean;
      procedure pCarregarCDS(Var cdsForTag: TUniClientDataSet; strCodEmp: String);
  end;

implementation

uses untForTagModel, untForTagDAO;

function TForTagController.fGravar(cdsForTag: TUniClientDataSet; strCodEmp: String): Boolean;
  Var
    objForTagDAO: TForTagDAO;
    objForTag: TForTagModel;
    objColForTag: TColForTagModel;
begin
  objForTagDAO := TForTagDAO.Create;
  objColForTag := TColForTagModel.Create;

  Try
    objForTagDAO.pDeletar('FTG_CODEMP = ' + QuotedStr(strCodEmp));

    If (cdsForTag.RecordCount = 0) Then
      Exit(True);

    cdsForTag.First;
    While (Not cdsForTag.Eof) Do
    Begin
      objForTag := objColForTag.fAdiciona();
      objForTag.strCodFor := cdsForTag.FieldByName('CODFOR').AsString;
      objForTag.strCodEmp := strCodEmp;

      cdsForTag.Next;
    End;

    Result := objForTagDAO.fInserirColecao(objColForTag);
  Finally
    FreeAndNil(objForTagDAO);
    FreeAndNil(objColForTag);
  End;
end;

procedure TForTagController.pCarregarCDS(Var cdsForTag: TUniClientDataSet; strCodEmp: String);
  Var
    objForTagDAO: TForTagDAO;
begin
  objForTagDAO := TForTagDAO.Create;

  Try
    objForTagDAO.pCarregarCDS(cdsForTag, 'FTG_CODEMP = ' + QuotedStr(strCodEmp));
  Finally
    FreeAndNil(objForTagDAO);
  End;
end;

function TForTagController.fFornecedorTigreConfigurado(strCodEmp: String): Boolean;
  Var
    objForTagDAO: TForTagDAO;
begin
  objForTagDAO := TForTagDAO.Create;

  Try
    Result := objForTagDAO.fExisteRegistro('FTG_CODEMP = ' + QuotedStr(strCodEmp));
  Finally
    FreeAndNil(objForTagDAO);
  End;
end;

end.
