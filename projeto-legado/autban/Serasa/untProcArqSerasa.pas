unit untProcArqSerasa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  FilenameEditFocus, frxClass, DB, UniClientDataSet, frxDBSet, Uni,
  BitBtnLockedIncrem, frxExportCSVTestabilidade, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Datasnap.DBClient, cxTextEdit,
  cxMaskEdit, cxButtonEdit, cxProgressBar;

type
  TfrmProcArqSerasa = class(TfrmPai)
    Label1: TLabel;
    frxRelRetorno: TfrxReport;
    frxDBDatasetMaster: TfrxDBDataset;
    frxDBDatasetDetalhes: TfrxDBDataset;
    pnlTopo: TPanel;
    frxGen: TfrxUserDataSet;
    btnGerar: TBitBtnLocked;
    edtArqRetorno: TFilenameEditFocus;
    procedure btnGerarClick(Sender: TObject);
    procedure frxDBCabecalhoGetValue(const VarName: String;
      var Value: Variant);
    procedure frxGenGetValue(const VarName: String; var Value: Variant);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    dbDetalhes: TUniClientDataSet;
    dbMaster: TUniClientDataSet;
  public
    { Public declarations }
    function fProcessarArqRetorno(cxgProgresso: TcxProgressBar = nil): Boolean;
    function fConvertDataSemBarra(strData: String): String;
    function fNegritoResumo(strTexto: String): String;
    procedure pProcessaLinha(strLinha: String);
    function fConverDataSemBarra2(strData: String): String;
    function fConvertValor(strValor: String): String;
  end;

var
  frmProcArqSerasa: TfrmProcArqSerasa;

implementation

uses untFuncoesSimples, StrUtils,  untCfgRel, untFuncoes, untGravando;

{$R *.dfm}

function TfrmProcArqSerasa.fProcessarArqRetorno(cxgProgresso: TcxProgressBar): Boolean;
var
  mArquivo          : TextFile;
  strNomeArquivo    : String;

  strIndInf         : String;
  strNumero         : String;
  strLinha          : String;
  strMensagem       : String;
  strErros          : String;

  strNomImp         : String;
  strTipImp         : String;

  intAux            : Integer;
  intLinha          : Integer;
  intLinhas         : Integer;
begin
  Result := False;
  try
    strNomeArquivo := AnsiReplaceStr(edtArqRetorno.Text, '"', '');
    AssignFile(mArquivo, strNomeArquivo);
    Reset(mArquivo);

    dbMaster.Open;
    dbMaster.Insert;
    dbDetalhes.Open;

    strMensagem := '';
    strErros    := '';

    Readln(mArquivo, strLinha);
    Reset(mArquivo);

    If Copy(strLinha, 0, 2) <> '77' Then
    Begin
      fMensagem('', 'Não é um arquivo de retorno do serasa!', ['&OK']);
      Exit;
    End;

    intLinha  := 0;
    intLinhas := fContaLinhasArq(strNomeArquivo);

    {********************************}
    {* 77 - CABECALHO DO ARQUIVO    *}
    {* 88 - TEBELA DE ERROS         *}
    {* 85 - RESUMO DO ARQUIVO       *}
    {*****************************PH*}

    While (not Eof(mArquivo)) Do
    Begin

      Application.ProcessMessages;
      Readln(mArquivo, strLinha);

      pProgresso(fInc(intLinha), intLinhas -1, cxgProgresso);

      strIndInf := copy(strLinha, 0, 2);

      If strIndInf = '77' Then
      Begin
        If (Pos('REMESSA    TOTALMENTE    PROCESSADA', strLinha) <> 0) Then
        Begin
          fMensagem('', 'Todos os dados enviados foram aproveitados', ['&OK']);
          Exit;
        End
        Else If (Pos('TODA   REMESSA   DESPREZADA', strLinha) <> 0) Then
          fMensagem('', 'Todas as duplicatas estão inconsistentes. Verificar qual foi o erro, corrigir e reenviar o arquivo', ['&OK'])
        Else
          fMensagem('', 'Algumas duplicatas estão inconsistentes. Verificar qual foi o erro, corrigir e reenviar o arquivo', ['&OK']);
      End

      Else If strIndInf = '88' Then
      Begin
        strNumero := copy(strLinha, 3, 3);
        if (Pos(strNumero, strErros) = 0) Then
          strErros := strErros + copy(strLinha, 3, 67) + #13 + #10;
      End

      Else If strIndInf = '85' Then
      Begin
        If Copy(strLinha, 0, 21) = '85 CNPJ DA CONVENIADA' Then
          dbMaster.FieldByName('CNPJ').AsString := Copy(strLinha, 27, 16)
        Else If Copy(strLinha, 0, 23) = '85 DATA  INFORMACAO  DE' Then
          dbMaster.FieldByName('DTAINI').AsString := fConvertDataSemBarra(Copy(strLinha, 27, 8))
        Else If Copy(strLinha, 0, 23) = '85 DATA  INFORMACAO ATE' Then
          dbMaster.FieldByName('DTAFIM').AsString := fConvertDataSemBarra(Copy(strLinha, 27, 8));



//        If not (strLinha = '85COD  INCONSISTENCIA/DESCRICAO DA MENSAGEM                    QTDE') and
//           not (strLinha = '85---  ------------------------------------------------------- ----------') Then
//            strMensagem := strMensagem + fNegritoResumo((Copy(strLinha, 3, Length(strLinha)))) + #13 + #10;
      End

      Else If strIndInf = '01' Then
      Begin
        pProcessaLinha(strLinha);
      End

      Else If not TryStrToInt(strIndInf, intAux) Then
      Begin
        fMensagem('', 'O arquivo está corrompido!', ['&OK']);
        Exit;
      End;
    End;

    dbMaster.Post;

    pCarregaConfImpr(qryCfgRel, Self.Name);
    strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
    strTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
    fPreImpressao(qryCfgRel, strNomImp, strTipImp, False);

    frxDBDatasetMaster.DataSet  := dbMaster;
    frxDBDatasetDetalhes.DataSet:= dbDetalhes;
    frxRelRetorno.Script.Variables['NOMREL'] := 'RELATÓRIO DE RETORNO DO SERASA';
    frxRelRetorno.Script.Variables['PERIODO'] := Format('REFERENTE AO PERIODO DE %s ATÉ %s', [dbMaster.FieldByName('DTAINI').AsString, dbMaster.FieldByName('DTAFIM').AsString]); //'REFERENTE AO PERIODO DE 01/01/2008 ATÉ 31/12/2008';
    frxRelRetorno.Script.Variables['PARAM1'] := '';
    frxRelRetorno.Script.Variables['PARAM2'] := '';

//    frxRelRetorno.Variables.Variables['Resumo'] := Trim(strMensagem);
    frxRelRetorno.Variables.Variables['Erros'] := Trim(strErros);

    frxRelRetorno.PrintOptions.Printer := AnsiReplaceText(strNomImp, '\\' + fRetNomeRede + '\', '');

    pPreviewReport(Self.Name, 'Relatório de retorno do SERASA', frxRelRetorno);

    Result := True;
  finally
    CloseFile(mArquivo);
  end;
end;

procedure TfrmProcArqSerasa.btnGerarClick(Sender: TObject);
  Var
    frmProcessando: TfrmGravando;
begin
  inherited;
  If fEmptyStr(edtArqRetorno.Text) Then
    fMensagem(Application.Title, 'Informe o arquivo a ser processado!', ['OK'])
  Else
  Begin
    btnGerar.Enabled := False;
    btnSair.Enabled  := False;
    edtArqRetorno.Enabled := False;

    TfrmGravando.fExecuta(fProcessarArqRetorno, frmProcessando, 'Processando...');

    edtArqRetorno.Enabled := True;
    btnSair.Enabled  := True;
    btnGerar.Enabled := True;
  End;
end;


procedure TfrmProcArqSerasa.frxDBCabecalhoGetValue(const VarName: String;
  var Value: Variant);
begin
  inherited;
  If VarName = 'DTAINI' Then
  Begin
    Value := VS_Date;
  End;
end;

{****************************************}
{* Converte de ddmmyyyy para dd/mm/yyyy *}
{*************************************PH*}
function TfrmProcArqSerasa.fConvertDataSemBarra(strData: String): String;
begin
  Result := '';
  Result := Result + Copy(strData, 0, 2);
  Result := Result + '/';
  Result := Result + Copy(strData, 3, 2);
  Result := Result + '/';
  Result := Result + Copy(strData, 5, 4);
end;

function TfrmProcArqSerasa.fNegritoResumo(strTexto: String): String;
  Var
    intCont: Integer;
begin
  Result := '';
  Result := Result + '<B>';
  intCont := Pos(':', strTexto);
  Result := Result + Copy(strTexto, 0, intCont) + '</B>' + Copy(strTexto, intCont + 1, Length(strTexto));
end;

procedure TfrmProcArqSerasa.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtArqRetorno);
end;

procedure TfrmProcArqSerasa.FormCreate(Sender: TObject);
begin
  inherited;

  dbMaster := TUniClientDataSet.Create(Self);
  dbMaster.DisableControls;
  dbMaster.FetchOnDemand := False;

  With dbMaster.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CNPJ';
    DataType := ftString;
    Size := 20;
  End;

  With dbMaster.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DTAINI';
    DataType := ftString;
    Size := 20;
  End;

  With dbMaster.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DTAFIM';
    DataType := ftString;
    Size := 20;
  End;

  dbMaster.CreateDataSet;

  dbDetalhes := TUniClientDataSet.Create(Self);
  dbDetalhes.DisableControls;
  dbDetalhes.FetchOnDemand := False;

  With dbDetalhes.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DUPESP';
    DataType := ftString;
    Size := 20;
  End;

  With dbDetalhes.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODNOMCLI';
    DataType := ftString;
    Size := 100;
  End;

  With dbDetalhes.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODERR';
    DataType := ftString;
    Size := 20;
  End;

  dbDetalhes.CreateDataSet;

end;

{**********************************}
{* PROCESSA AS LINHAS DO ARQUIVO  *}
{* E INSERE EM UMA TABELA VIRTUAL *}
{*******************************PH*}
procedure TfrmProcArqSerasa.pProcessaLinha(strLinha: String);
  Var
    qryGen: TUniQuery;
    strSQL: String;
    strNomCli: String;
begin
  qryGen := fCriaQuery;
  qryGen.Close;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '	CLI_NOMCLI ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '	CADCLI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '	CLI_CODCLI = :CODCLI ';

  qryGen.SQL.Text := strSQL;

  If Length(Trim(Copy(strLinha,68,32))) = 26 Then
    qryGen.ParamByName('CODCLI').AsString := Copy(strLinha, 86, 8)
  Else
    qryGen.ParamByName('CODCLI').AsString := Copy(strLinha, 78, 8);

  qryGen.Open;

  If qryGen.IsEmpty Then
    strNomCli := 'CLIENTE NÃO CADASTRADO'
  Else
    strNomCli := qryGen.FieldByName('CLI_NOMCLI').AsString;

  dbDetalhes.Insert;

  If Length(Trim(Copy(strLinha,68,32))) = 26 Then
  Begin
    dbDetalhes.FieldByName('DUPESP').AsString    := Trim(Copy(strLinha, 68, 13)) + ' - ' + Copy(strLinha, 81, 2);
    dbDetalhes.FieldByName('CODNOMCLI').AsString := Copy(strLinha, 86, 8) + ' - ' + strNomCli;
  End
  Else
  Begin
    dbDetalhes.FieldByName('DUPESP').AsString    := Trim(Copy(strLinha, 19, 10)) + ' - ' + Copy(strLinha, 73, 2);
    dbDetalhes.FieldByName('CODNOMCLI').AsString := Copy(strLinha, 78, 8) + ' - ' + strNomCli;
  End;

  dbDetalhes.FieldByName('CODERR').AsString    := Copy(strLinha, 101, 3);
  dbDetalhes.Post;

  FreeAndNil(qryGen);
end;


{****************************************}
{* Converte de yyyymmdd para dd/mm/yyyy *}
{*************************************PH*}
function TfrmProcArqSerasa.fConverDataSemBarra2(strData: String): String;
begin
  Result := '';
  Result := Result + Copy(strData, 7, 2);
  Result := Result + '/';
  Result := Result + Copy(strData, 5, 2);
  Result := Result + '/';
  Result := Result + Copy(strData, 0, 4);
end;
{********************************}
{* CONVERTE O VALOR FORNECIDO   *}
{* NO ARQUIVO PARA UMVALOR REAL *}
{* COM 2 CASAS DECIMAIS         *}
{*****************************PH*}
function TfrmProcArqSerasa.fConvertValor(strValor: String): String;
  Var
    fltValor: Double;
begin
  fltValor := fStrToFloat(strValor) / 100;
  Result := FloatToStr(fltValor);
end;

procedure TfrmProcArqSerasa.frxGenGetValue(const VarName: String;
  var Value: Variant);
begin
  inherited;

  If VarName = 'EMP_NOMEMP' Then
    Value := fRetNomeEmpresa(VS_strCodEmp) + #10

  Else If VarName = 'REL_NOMREL' Then
    Value := Self.Name + #10;
end;

end.
