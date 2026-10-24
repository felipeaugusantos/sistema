unit untPenRecController;

interface

uses
  untPenRec, untPenRecDAO, System.SysUtils, UniClientDataSet;

Type
  TPenRecController = class
  private
    objDAO: TPenRecDAO;

  public
    constructor Create;
    destructor Destroy; override;
    function fGravar(strNumDoc, strEspDoc, strCodEmp, strCodCli, strCodIte,
      strStatus, strDocRec, strEspRec, strEmpRec: String; fltTotIte: Double;
      dteDtaEnt, dteHorEnt: TDateTime; fltQtdIte: Double): Boolean;
    function fExistePedido(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  end;

implementation

uses
  untFuncoesSimples;

{ TPenRecController }

constructor TPenRecController.Create;
begin
  objDAO := TPenRecDAO.Create;
end;

destructor TPenRecController.Destroy;
begin
  inherited;
  FreeAndNil(objDAO);
end;

function TPenRecController.fGravar(strNumDoc, strEspDoc, strCodEmp, strCodCli,
  strCodIte, strStatus, strDocRec, strEspRec, strEmpRec: String; fltTotIte: Double;
  dteDtaEnt, dteHorEnt: TDateTime; fltQtdIte: Double): Boolean;
  Var
    objModel: TPenRec;
begin
  Result := False;

  Try
    objModel := TPenRec.Create('', strNumDoc, strEspDoc, strCodEmp, strCodCli,
        strCodIte, strStatus, strDocRec, strEspRec, strEmpRec, fltTotIte, dteDtaEnt,
        dteHorEnt, fltQtdIte);
    Try
      If (Not objDAO.fGravar(objModel)) Then
        Exit;

      Result := True;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TPenRecController.fGravar]');
    End;
  Finally
    FreeAndNil(objModel);
  End;
end;

function TPenRecController.fExistePedido(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  Var
    objModel: TPenRec;
begin
  Try
    objModel := objDAO.fBuscaPorPedido(strNumDoc, strEspDoc, strCodEmp);
    Result := Assigned(objModel);
  Finally
    FreeAndNil(objModel);
  End;
end;

end.

