unit untProcessadorGravandoExecucaoAdvanceTintoSystemCores;

interface

uses  ADODB, Classes, DB, SysUtils, Variants, Uni, untIGravando,
      untAbstractAdoProcessadorGravandoExecucaoArquivos,
      untIProcessadorGravandoExecucaoArquivosInsert, ComObj;

type
  TProcessadorGravandoExecucaoAdvanceTintoSystemCores = class (TAbstractAdoProcessadorGravandoExecucaoArquivos,
    IProcessadorGravandoExecucaoArquivosInsert)
  protected
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
    function GetAdoQuery(var strNomeArquivo: string): TADOQuery;  override;
  public
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings); override;
    procedure GetArquivosProcessar(const stlArquivos: TStrings); override;
    function GetSqlDestino(): string; override;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: TDataSet): Boolean; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet); override;
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
      const qryOrigem, qryDestino: TDataSet); override;
    function fGetNomeGravacao(): string; override;
    procedure LimparTabelas; override;
    class function GravarNovaFormula(const qryCadNfm: TDataSet): Boolean;
    class procedure DeletarNovaFormula(const strCodNfm: string);
    procedure ArquivoFormulaPadrao(const gravando: IGravando; const strNomeArquivo: string); override;
  end;

implementation

uses
  untDDLFactory, UniClientDataSet, untClientDataSetFactory,
  untIDefinicaoTxt, untGenericDefinicaoTxt,
  untGenericDefinicaoTxtCampo, untDefinicaoTxtCharacterSet, untIDefinicaoTxtCampo,
  untDefinicaoTxtCampoTipo, untFuncTinta, untADOTxtFactory,
  untFuncoesSimples;


{ TProcessadorGravandoExecucaoAdvanceTintoSystemCores }

procedure TProcessadorGravandoExecucaoAdvanceTintoSystemCores.ArquivoFormulaPadrao(
  const gravando: IGravando; const strNomeArquivo: string);
var
  Excel: Variant;
begin
  Try
    Excel := CreateOleObject('Excel.Application');
    Excel.Visible := False;
    Excel.WorkBooks.Add(strNomeArquivo);

    If Trim(Excel.Cells.Item[1,65].Text) = 'GR_Corante1' Then
    Begin
      fMensagem('INFORMAÇÃO', 'A planilha de integração não está no formato esperado !' + #13#10 +
                              'O formato esperado é em ( ML ), favor informar a planilha correta.' , ['&Ok']);
      gravando.cancelar;
    End;
  Finally
    Excel.WorkBooks.Close;
  End;
end;

class procedure TProcessadorGravandoExecucaoAdvanceTintoSystemCores.DeletarNovaFormula(const strCodNfm: string);
begin
  fExecutaSQL('DELETE FROM ADT_CADADT WHERE ADT_CODNFM = ' + QuotedStr(strCodNfm));
end;

function TProcessadorGravandoExecucaoAdvanceTintoSystemCores.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Cores';
end;

function TProcessadorGravandoExecucaoAdvanceTintoSystemCores.GetAdoQuery(var strNomeArquivo: string): TADOQuery;
var
  definicao: IDefinicaoTxt;
begin
  definicao := TGenericDefinicaoTxt.Create(strNomeArquivo, True, ';', dtcsDefault, '.', '.',
    TArrayIDefinicaoTxtCampoFactory.GetArrayIDefinicaoTxtCampo([
      TGenericDefinicaoTxtCampo.Create('IdFormula', dtctText),
      TGenericDefinicaoTxtCampo.Create('Codigo da Cor', dtctText),
      TGenericDefinicaoTxtCampo.Create('Codigo Tecnico', dtctText),
      TGenericDefinicaoTxtCampo.Create('Produto', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdProduto', dtctText),
      TGenericDefinicaoTxtCampo.Create('Base', dtctText),
      TGenericDefinicaoTxtCampo.Create('Cod Base', dtctText),
      TGenericDefinicaoTxtCampo.Create('Id_Base', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdProdBas', dtctText),
      TGenericDefinicaoTxtCampo.Create('Embalagem', dtctText),
      TGenericDefinicaoTxtCampo.Create('Conteudo', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('IdEmb', dtctText),
      TGenericDefinicaoTxtCampo.Create('Preco Base', dtctCurrency),
      TGenericDefinicaoTxtCampo.Create('IdCoran1', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran2', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran3', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran4', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran5', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran6', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran7', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran8', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran9', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran10', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran11', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran12', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran13', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran14', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran15', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran16', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCoran17', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran1', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran2', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran3', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran4', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran5', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran6', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran7', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran8', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran9', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran10', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran11', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran12', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran13', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran14', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran15', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran16', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCoran17', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante1', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante2', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante3', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante4', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante5', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante6', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante7', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante8', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante9', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante10', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante11', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante12', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante13', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante14', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante15', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante16', dtctText),
      TGenericDefinicaoTxtCampo.Create('Desc_Corante17', dtctText),
      TGenericDefinicaoTxtCampo.Create('ML_Corante1', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante2', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante3', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante4', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante5', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante6', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante7', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante8', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante9', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante10', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante11', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante12', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante13', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante14', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante15', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante16', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_Corante17', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('ML_TotalCor', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Preco_Cor', dtctCurrency),
      TGenericDefinicaoTxtCampo.Create('Catalisador', dtctText),
      TGenericDefinicaoTxtCampo.Create('CodCatalis', dtctText),
      TGenericDefinicaoTxtCampo.Create('IdCatalis', dtctText),
      TGenericDefinicaoTxtCampo.Create('Volume Catal', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Preco Catal', dtctCurrency),
      TGenericDefinicaoTxtCampo.Create('Volume Final', dtctDouble),
      TGenericDefinicaoTxtCampo.Create('Preco', dtctCurrency),
      TGenericDefinicaoTxtCampo.Create('Data', dtctDate)
    ]));

  TADOTxtFactory.Registrar(definicao);
  strNomeArquivo := definicao.NomeArquivo;
  Result := TADOTxtFactory.GetTxt12Query(ExtractFileDir(strNomeArquivo));
end;

procedure TProcessadorGravandoExecucaoAdvanceTintoSystemCores.GetArquivosProcessar(const stlArquivos: TStrings);
begin
  stlArquivos.Text := fGetConfTinta('ADT').fGet('PATADV') +  '\Integracao.csv';
end;

function TProcessadorGravandoExecucaoAdvanceTintoSystemCores.GetSqlDestino: string;
begin
  Result := TDDLFactory.GetInsert('ADT_CADADT');
end;

function TProcessadorGravandoExecucaoAdvanceTintoSystemCores.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result :=
    ' SELECT                                ' +
    '   I.*                                 ' +
    ' FROM                                  ' +
    '   INTEGRACAO#CSV AS I                 ' +
{    '   INNER JOIN                          ' +
    '     (SELECT                           ' +
    '       IDFORMULA                       ' +
    '       , MAX(CONTEUDO) AS MAX_CONTEUDO ' +
    '     FROM                              ' +
    '       INTEGRACAO#CSV                  ' +
    '     GROUP BY IDFORMULA) AS C          ' +
    '     ON I.IDFORMULA = C.IDFORMULA      ' +
    '     AND I.CONTEUDO = C.MAX_CONTEUDO   ' +}
    ' ORDER BY I.IDFORMULA                  ';
end;

procedure TProcessadorGravandoExecucaoAdvanceTintoSystemCores.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'ADT_CADADT';
end;

class function TProcessadorGravandoExecucaoAdvanceTintoSystemCores.GravarNovaFormula(const qryCadNfm: TDataSet): Boolean;
var
  qryGen: TUniQuery;
  intCont: Integer;
  qryCadCol: TUniQuery;
  cdsCadCol: TUniClientDataSet;
  fltQuantidadeML: Double;
  qryCadBas: TUniQuery;
  cdsCadBas: TUniClientDataSet;
  qryCadCat: TUniQuery;
  cdsCadCat: TUniClientDataSet;
begin
  qryGen := nil;
  qryCadCol := nil;
  qryCadBas := nil;
  Result := False;
  Try
    Try
      qryGen := fCriaQuery();
      qryCadBas := fCriaQuery();
      qryCadBas.SQL.Text :=
        ' SELECT                     ' +
        '   B1.*                                ' +
        ' FROM                                  ' +
        '   ADT_CADBAS B1                       ' +
{        '   INNER JOIN                          ' +
        '     (SELECT                           ' +
        '       BAS_CODBAS                      ' +
        '       , MAX(BAS_CONTEU) BAS_CONTEU    ' +
        '     FROM                              ' +
        '       ADT_CADBAS                      ' +
        '     GROUP BY BAS_CODBAS) B2           ' +
        '     ON B1.BAS_CODBAS = B2.BAS_CODBAS  ' +
        '     AND B1.BAS_CONTEU = B2.BAS_CONTEU ' +}
        ' WHERE B1.BAS_CODBAS = :CODBAS         ' +
        '   AND B1.BAS_PRODUT = :PRODUT         ';
      qryCadBas.ParamByName('CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
      qryCadBas.ParamByName('PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
      cdsCadBas := TClientDataSetFactory.GetClientDataSet(qryCadBas);

      qryCadCol := fCriaQuery();
      qryCadCol.SQL.Text := 'SELECT * FROM ADT_CADCOL';
      cdsCadCol := TClientDataSetFactory.GetClientDataSet(qryCadCol);

      qryCadCat := fCriaQuery();
      qryCadCat.SQL.Text := 'SELECT * FROM ADT_CADBAS WHERE BAS_DESCRI LIKE "%PARTE B%"';
      cdsCadCat := TClientDataSetFactory.GetClientDataSet(qryCadCat);

      DeletarNovaFormula(qryCadNfm.FieldByName('NFM_CODNFM').AsString);

      while not cdsCadBas.Eof do
      begin
        qryGen.SQL.Clear;
        qryGen.Params.Clear;
        qryGen.SQL.Text := TDDLFactory.GetInsert('ADT_CADADT');

        qryGen.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('ADT_CADADT', VS_strCodEmp);
        qryGen.ParamByName('ADT_CODEMP').AsString := VS_strCodEmp;
        qryGen.ParamByName('ADT_IDFORM').AsString := qryCadNfm.FieldByName('NFM_IDFORM').AsString;
        qryGen.ParamByName('ADT_CODCOR').AsString := qryCadNfm.FieldByName('NFM_CODCOR').AsString;
        qryGen.ParamByName('ADT_CODTEC').AsString := qryCadNfm.FieldByName('NFM_CODTEC').AsString;
        qryGen.ParamByName('ADT_PRODUT').AsString := qryCadNfm.FieldByName('NFM_PRODUT').AsString;
        qryGen.ParamByName('ADT_CODBAS').AsString := qryCadNfm.FieldByName('NFM_CODBAS').AsString;
        qryGen.ParamByName('ADT_CODEMB').AsString := cdsCadBas.FieldByName('BAS_CODEMB').AsString;
        qryGen.ParamByName('ADT_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDateTime;

        fltQuantidadeML := 0;
        for intCont := 1 to 20 do
        begin
          if fEmptyStr(qryCadNfm.FieldByName('NFM_CODC' + fStrZero(intCont, 2)).AsString) then
            Continue;

          if not cdsCadCol.Locate('COL_CODCOL', qryCadNfm.FieldByName('NFM_CODC' + fStrZero(intCont, 2)).AsString, []) then
            raise Exception.CreateFmt('O colorante %s não está cadastrado!', [qryCadNfm.FieldByName('NFM_CODC' + fStrZero(intCont, 2)).AsString]);

          qryGen.ParamByName('ADT_CODC' + fStrZero(intCont, 2)).AsString := qryCadNfm.FieldByName('NFM_CODC' + fStrZero(intCont, 2)).AsString;
          qryGen.ParamByName('ADT_QTDC' + fStrZero(intCont, 2)).AsFloat := (cdsCadBas.FieldByName('BAS_CONTEU').AsFloat / qryCadNfm.FieldByName('NFM_QTDBAS').AsFloat) *
            qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2)).AsFloat / cdsCadCol.FieldByName('COL_PESESP').AsFloat;

          fltQuantidadeML := fltQuantidadeML + qryGen.ParamByName('ADT_QTDC' + fStrZero(intCont, 2)).AsFloat;
        end;

        qryGen.ParamByName('ADT_QTDBAS').AsFloat := cdsCadBas.FieldByName('BAS_CONTEU').AsFloat;
        qryGen.ParamByName('ADT_QTD_ML').AsFloat := fltQuantidadeML;

        if not fEmptyStr(qryCadNfm.FieldByName('NFM_CODCAT').AsString) then
        begin
//          if not cdsCadCol.Locate('COL_CODCOL', qryCadNfm.FieldByName('NFM_CODCAT').AsString, []) then
//            raise Exception.CreateFmt('O caralisador %s não está cadastrado!', [qryCadNfm.FieldByName('NFM_CODCAT').AsString]);

          if not cdsCadCat.Locate('BAS_CODBAS;BAS_CODEMB', VarArrayOf([qryCadNfm.FieldByName('NFM_CODCAT').AsString,qryCadNfm.FieldByName('NFM_CODEMB').AsString]), []) then
            raise Exception.CreateFmt('O catalisador %s não está cadastrado!', [qryCadNfm.FieldByName('NFM_CODCAT').AsString]);

          qryGen.ParamByName('ADT_CODCAT').AsString := qryCadNfm.FieldByName('NFM_CODCAT').AsString;
          qryGen.ParamByName('ADT_QTDCAT').AsFloat := (cdsCadBas.FieldByName('BAS_CONTEU').AsFloat / qryCadNfm.FieldByName('NFM_QTDBAS').AsFloat) *
            qryCadNfm.FieldByName('NFM_QTDCAT').AsFloat / cdsCadCat.FieldByName('BAS_PESESP').AsFloat; //cdsCadCol.FieldByName('COL_PESESP').AsFloat;
        end;


        qryGen.ParamByName('ADT_QTDFIN').AsFloat := qryGen.ParamByName('ADT_QTDBAS').AsFloat +
                                                    qryGen.ParamByName('ADT_QTD_ML').AsFloat +
                                                    qryGen.ParamByName('ADT_QTDCAT').AsFloat;

        qryGen.ParamByName('ADT_CODNFM').AsString := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
        qryGen.ParamByName('ADT_MD5KEY').AsString := GetMD5(qryGen.ParamByName('ADT_IDFORM').AsString +
                                                    qryGen.ParamByName('ADT_CODCOR').AsString +
                                                    qryGen.ParamByName('ADT_CODTEC').AsString +
                                                    qryGen.ParamByName('ADT_PRODUT').AsString +
                                                    qryGen.ParamByName('ADT_CODBAS').AsString +
                                                    qryGen.ParamByName('ADT_CODEMB').AsString +
                                                    qryGen.ParamByName('ADT_CODCAT').AsString);
        qryGen.ExecSQL;
        cdsCadBas.Next;
      end;



      Result := True;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
    if Assigned(qryCadCol) then FreeAndNil(qryCadCol);
    if Assigned(qryCadBas) then FreeAndNil(qryCadBas);
    if Assigned(qryCadCat) then FreeAndNil(qryCadCat);
  End;
end;

procedure TProcessadorGravandoExecucaoAdvanceTintoSystemCores.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
var
  qryGrava: TUniQuery;
  intCont: Integer;
  intForm: Integer;
begin
  qryGrava := TUniQuery(qryDestino);
  qryGrava.SQL.Clear;
  qryGrava.Params.Clear;
  qryGrava.SQL.Text := GetSqlDestino;

  qryGrava.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('ADT_CADADT', VS_strCodEmp);
  qryGrava.ParamByName('ADT_CODEMP').AsString := VS_strCodEmp;
  qryGrava.ParamByName('ADT_IDFORM').AsString := fStrZero(LimpaTexto(qryOrigem.FieldByName('IdFormula').AsString), 4);
  qryGrava.ParamByName('ADT_CODCOR').AsString := LimpaTexto(qryOrigem.FieldByName('Codigo da Cor').AsString);
  qryGrava.ParamByName('ADT_CODTEC').AsString := LimpaTexto(qryOrigem.FieldByName('Codigo Tecnico').AsString);
  qryGrava.ParamByName('ADT_PRODUT').AsString := LimpaTexto(qryOrigem.FieldByName('Produto').AsString);
  qryGrava.ParamByName('ADT_CODBAS').AsString := LimpaTexto(qryOrigem.FieldByName('Cod Base').AsString);
  qryGrava.ParamByName('ADT_CODEMB').AsString := fStrZero(LimpaTexto(qryOrigem.FieldByName('IdEmb').AsString), 3);

  intForm := 1;
  for intCont := 1 to 17 do
  begin
    if qryOrigem.FieldByName('ML_Corante' + IntToStr(intCont)).AsFloat > 0 then
    begin
      qryGrava.ParamByName('ADT_CODC' + fStrZero(intForm, 2)).AsString := qryOrigem.FieldByName('CodCoran' + IntToStr(intCont)).AsString;
      qryGrava.ParamByName('ADT_QTDC' + fStrZero(intForm, 2)).AsFloat := qryOrigem.FieldByName('ML_Corante' + IntToStr(intCont)).AsFloat;
      Inc(intForm);
    end;
  end;

  qryGrava.ParamByName('ADT_CODCAT').AsString := LimpaTexto(qryOrigem.FieldByName('CodCatalis').AsString);
  qryGrava.ParamByName('ADT_QTDBAS').AsFloat := qryOrigem.FieldByName('Conteudo').AsFloat;
  qryGrava.ParamByName('ADT_QTD_ML').AsFloat := qryOrigem.FieldByName('ML_TotalCor').AsFloat;
  qryGrava.ParamByName('ADT_QTDCAT').AsFloat := qryOrigem.FieldByName('Volume Catal').AsFloat;
  qryGrava.ParamByName('ADT_QTDFIN').AsFloat := qryOrigem.FieldByName('Volume Final').AsFloat;

  qryGrava.ParamByName('ADT_MD5KEY').AsString := GetMD5(qryGrava.ParamByName('ADT_IDFORM').AsString +
                                                  qryGrava.ParamByName('ADT_CODCOR').AsString +
                                                  qryGrava.ParamByName('ADT_CODTEC').AsString +
                                                  qryGrava.ParamByName('ADT_PRODUT').AsString +
                                                  qryGrava.ParamByName('ADT_CODBAS').AsString +
                                                  qryGrava.ParamByName('ADT_CODEMB').AsString +
                                                  qryGrava.ParamByName('ADT_CODCAT').AsString);
  qryGrava.ExecSQL;
end;

function TProcessadorGravandoExecucaoAdvanceTintoSystemCores.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := False;
end;

procedure TProcessadorGravandoExecucaoAdvanceTintoSystemCores.LimparTabelas;
begin
  TruncateTable('ADT_CADADT');
end;

procedure TProcessadorGravandoExecucaoAdvanceTintoSystemCores.RegistrarImpossivelGravarRegistro(const E: Exception;
  const gravando: IGravando; const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possível cadastrar a cor [%s - %s - %s - %s - %s - %s - %s][%s: %s]',
    [fStrZero(LimpaTexto(qryOrigem.FieldByName('IdFormula').AsString), 4),
     LimpaTexto(qryOrigem.FieldByName('Codigo da Cor').AsString),
     LimpaTexto(qryOrigem.FieldByName('Codigo Tecnico').AsString),
     LimpaTexto(qryOrigem.FieldByName('Produto').AsString),
     LimpaTexto(qryOrigem.FieldByName('Cod Base').AsString),
     fStrZero(LimpaTexto(qryOrigem.FieldByName('IdEmb').AsString), 3),
     LimpaTexto(qryOrigem.FieldByName('CodCatalis').AsString),
    E.ClassName, E.Message]);
end;

end.
