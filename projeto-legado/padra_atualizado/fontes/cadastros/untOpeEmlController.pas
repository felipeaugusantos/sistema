unit untOpeEmlController;

interface

uses
  untOpeEml, untOpeEmlDAO, System.SysUtils, Uni, UniClientDataSet, System.StrUtils, Classes;

Type
  TOpeEmlController = class
  private
    objDAO: TOpeEmlDAO;

    function fPreparaDados(cdsDados: TUniClientDataSet): Boolean;
    function fMontaObj(cdsDados: TUniClientDataSet; strCodEmp: String): TOpeEml;
  public
    function fGravarColecao(cdsDados: TUniClientDataSet): Boolean;
    function fBuscaPorEmpresa(strCodOpe, strCodEmp: String): TOpeEml;
    procedure pCarregaLista(strCodOpe: String; Var cdsDados: TUniClientDataSet);
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  untFuncoesSimples;

{ TOpeEmlController }

constructor TOpeEmlController.Create;
begin
  objDAO := TOpeEmlDAO.Create;
end;

destructor TOpeEmlController.Destroy;
begin
  inherited;
  FreeAndNil(objDAO);
end;

function TOpeEmlController.fBuscaPorEmpresa(strCodOpe, strCodEmp: String): TOpeEml;
begin
  Result := objDAO.fBuscaPorOperadorEmpresa(strCodOpe, strCodEmp);
end;

function TOpeEmlController.fGravarColecao(cdsDados: TUniClientDataSet): Boolean;
  Var
    stlEmpresas: TStringList;
    intIndex: Integer;
begin
  Result := False;
  stlEmpresas := TStringList.Create;

  Try
    If (Not fPreparaDados(cdsDados)) Then
      Exit;

    cdsDados.First;

    While (Not cdsDados.Eof) Do
    Begin
      stlEmpresas.Delimiter := '_';
      stlEmpresas.DelimitedText := cdsDados.FieldByName('EML_EMAEMP').AsString;

      For intIndex := 0 To Pred(stlEmpresas.Count) Do
      Begin
        objDAO.fGravar(fMontaObj(cdsDados, stlEmpresas[intIndex]));
      End;

      cdsDados.Next;
    End;

    Result := True;
  Finally
    FreeAndNil(stlEmpresas);
  End;
end;

function TOpeEmlController.fPreparaDados(cdsDados: TUniClientDataSet): Boolean;
begin
  cdsDados.First;
  Result := objDAO.fDeletar(cdsDados.FieldByName('EML_CODOPE').AsString);
end;

function TOpeEmlController.fMontaObj(cdsDados: TUniClientDataSet; strCodEmp: String): TOpeEml;
begin
  Result := TOpeEml.Create(cdsDados.FieldByName('EML_CODOPE').AsString,
                           strCodEmp,
                           cdsDados.FieldByName('EML_E_NOME').AsString,
                           cdsDados.FieldByName('EML_CODPRV').AsString,
                           cdsDados.FieldByName('EML_E_MAIL').AsString,
                           cdsDados.FieldByName('EML_EMALOG').AsString,
                           cdsDados.FieldByName('EML_PRVSEN').AsString,
                           cdsDados.FieldByName('EML_EMAAUT').AsString,
                           cdsDados.FieldByName('EML_IMAGEM').AsString,
                           cdsDados.FieldByName('EML_TEXTO_').AsString,
                           cdsDados.FieldByName('EML_IMGB64').AsString);
end;

procedure TOpeEmlController.pCarregaLista(strCodOpe: String; Var cdsDados: TUniClientDataSet);
  Var
    qryDados: TUniQuery;
begin
  qryDados := objDAO.fBuscaPorOperador(strCodOpe);
  cdsDados.EmptyDataSet;

  While (Not qryDados.Eof) Do
  Begin
    cdsDados.Append;

    cdsDados.FieldByName('EML_EMAEMP').AsString := StringReplace(qryDados.FieldByName('EML_EMAEMP').AsString, ',', '_', [rfReplaceAll, rfIgnoreCase]);
    cdsDados.FieldByName('EML_E_NOME').AsString := qryDados.FieldByName('EML_E_NOME').AsString;
    cdsDados.FieldByName('EML_CODPRV').AsString := qryDados.FieldByName('EML_CODPRV').AsString;
    cdsDados.FieldByName('EML_NOMPRV').AsString := qryDados.FieldByName('EML_NOMPRV').AsString;
    cdsDados.FieldByName('EML_E_MAIL').AsString := qryDados.FieldByName('EML_E_MAIL').AsString;
    cdsDados.FieldByName('EML_EMALOG').AsString := qryDados.FieldByName('EML_EMALOG').AsString;
    cdsDados.FieldByName('EML_PRVSEN').AsString := qryDados.FieldByName('EML_PRVSEN').AsString;
    cdsDados.FieldByName('EML_EMAAUT').AsString := IIF(qryDados.FieldByName('EML_EMAAUT').AsString = 'S', 'Sim', 'Não');
    cdsDados.FieldByName('EML_TEXTO_').AsString := qryDados.FieldByName('EML_TEXTO_').AsString;
    cdsDados.FieldByName('EML_IMGB64').AsString := qryDados.FieldByName('EML_IMGB64').AsString;

    cdsDados.Post;

    qryDados.Next;
  End;
end;

end.
