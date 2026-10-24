unit untProcArqSPC;

interface
{$WARN UNIT_PLATFORM OFF}

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, StrUtils,
  cxTextEdit, cxMaskEdit, cxButtonEdit, FilenameEditFocus,
  UniClientDataSet, Uni, untFuncoesSimples, untCfgRel, untConstantes, frxDBSet, DB,
  Vcl.FileCtrl, DirectoryEditFocus, Datasnap.DBClient, untFuncoes, cxProgressBar, 
  untFrameDirectoryEditFocus;

type
  TfrmProcArqSPC = class(TfrmPai)
    pnlTopo: TPanel;
    Label1: TLabel;
    btnGerar: TBitBtnLocked;
    frxGen: TfrxUserDataSet;
    frxRelRetorno: TfrxReport;
    frxDBDatasetDetalhes: TfrxDBDataset;
    frxDBDatasetNEncontrados: TfrxDBDataset;
    Panel1: TPanel;
    lstArquivo: TFileListBox;
    fraArqRetorno: TfraDirectoryEditFocus;
    cdsDetalhes: TUniClientDataSet;
    cdsNEncontrados: TUniClientDataSet;
    cdsDetalhesNUMDUP: TStringField;
    cdsDetalhesCODEMP: TStringField;
    cdsDetalhesCLIENTE: TStringField;
    cdsDetalhesDTASPC: TDateField;
    cdsDetalhesDTCSPC: TDateField;
    cdsDetalhesDTAVEN: TDateTimeField;
    cdsDetalhesVALOR: TFloatField;
    cdsDetalhesSTATUS: TStringField;
    cdsNEncontradosNUMDUP: TStringField;
    cdsNEncontradosCODEMP: TStringField;
    cdsNEncontradosCLIENTE: TStringField;
    cdsNEncontradosDTAVEN: TDateTimeField;
    cdsNEncontradosVALOR: TFloatField;
    cdsDetalhesMOTIVO: TStringField;
    procedure FormActivate(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    function fConverDataSemBarra(strData: String): String;
    function fRenomeiaArquivo(strNomArq: String): Boolean;
    procedure FormShow(Sender: TObject);
    procedure fraArqRetornoFocusChanged(Sender: TObject);
    procedure lstArquivoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure fraArqRetornoedtDirectoryEnter(Sender: TObject);
    procedure fraArqRetornoedtDirectoryExit(Sender: TObject);
  private
    { Private declarations}
    strDataArq: String;
    procedure pBuscaClienteNaDuplicata(strNumDup, strParcel, strEspDoc, strCodEmp: String; var strCodCli: String);
    function fProcessarArqRetorno(cxgProgresso: TcxProgressBar = nil): Boolean;
    function fRetornaCodEvento(strCodOco, strCodBco: String): String;
  public
    { Public declarations }
    procedure pProcessaLinha(strLinha: String);
  end;

var
  frmProcArqSPC: TfrmProcArqSPC;

implementation

{$R *.dfm}

uses SysUtils, untGravando;

procedure TfrmProcArqSPC.btnGerarClick(Sender: TObject);
  Var
    frmProcessando: TfrmGravando;
begin
  if fEmptyStr(fraArqRetorno.edtDirectory.text) then
  begin
    fMensagem('ATENÇÃO!', 'Você deve configurar o campo: Path para Arquivos de Retorno na aba Configurar, ou selecionar um diretório válido!', ['&O K ']);
    pSetFocus(fraArqRetorno);
    Exit;
  end
  else
  begin
    fraArqRetorno.edtDirectory.text := fVerBarraFinal(fraArqRetorno.edtDirectory.text);
    If Not DirectoryExists(fraArqRetorno.edtDirectory.text) Then
    Begin
      fMensagem('Path:', 'Diretório inválido para confirmação.', ['&O K'], 1, True);
      pSetFocus(fraArqRetorno);
      Exit;
    End;

    If lstArquivo.SelCount <= 0 Then
    Begin
      fMensagem('ATENÇÃO','Selecione o arquivo que deseja processar!',['&OK']);
      exit;
    End
    Else
    Begin
      TfrmGravando.fExecuta(fProcessarArqRetorno, frmProcessando, 'Processando...');

      btnSair.Click;
    end;
  end;
end;

{****************************************}
{* Converte de yyyymmdd para dd/mm/yyyy *}
{*************************************MO*}
procedure TfrmProcArqSPC.fraArqRetornoFocusChanged(Sender: TObject);
begin
  inherited;
  If SysUtils.DirectoryExists(fraArqRetorno.edtDirectory.text) Then
  Begin
    lstArquivo.ApplyFilePath(fraArqRetorno.edtDirectory.text);
  End;
end;

function TfrmProcArqSPC.fConverDataSemBarra(strData: String): String;
begin
  Result := '';
  Result := Result + Copy(strData, 7, 2);
  Result := Result + '/';
  Result := Result + Copy(strData, 5, 2);
  Result := Result + '/';
  Result := Result + Copy(strData, 0, 4);
end;

function TfrmProcArqSPC.fProcessarArqRetorno(cxgProgresso: TcxProgressBar): Boolean;
var
  mArquivo    : TextFile;
  intContador : Integer;
  strIndInf   : String;
  strLinha    : String;
  strNomArq   : String;
  intAux      : Integer;
  intLinha    : Integer;
  intLinhas   : Integer;
begin
  Result := False;

  cdsDetalhes.Open;
  cdsNEncontrados.Open;

  For intContador := 0 To lstArquivo.Count-1 Do
  Begin
    If lstArquivo.Selected[intContador] Then
    Begin
      strNomArq := lstArquivo.Items.Strings[intContador];
      AssignFile(mArquivo, fraArqRetorno.edtDirectory.text + '\' + lstArquivo.Items.Strings[intContador]);
      Reset(mArquivo);
      Readln(mArquivo, strLinha);

      If (Copy(strLinha, 03, 7) <> 'RETORNO') and (Copy(strLinha, 318, 5) <> 'SPC') Then
      Begin
        fMensagem('', 'Não é um arquivo de retorno do SPC!', ['&OK']);
        Exit;
      End
      else
      begin
        //pegar a data do movimento do arquivo
        strDataArq := Copy(strLinha, 39, 8);
        strDataArq := fConverDataSemBarra(strDataArq);
      end;

      intLinha  := 0;
      intLinhas := fContaLinhasArq(fraArqRetorno.edtDirectory.text + '\' + lstArquivo.Items.Strings[intContador]);

      While (not Eof(mArquivo)) Do
      Begin

        Application.ProcessMessages;
        Readln(mArquivo, strLinha);

        pProgresso(fInc(intLinha), intLinhas -1, cxgProgresso);

        strIndInf := copy(strLinha, 0, 2);

        If strIndInf = '02' Then
        Begin
          pProcessaLinha(strLinha);
        End

        Else If not TryStrToInt(strIndInf, intAux) Then
        Begin
          fMensagem('', 'O arquivo está corrompido!', ['&OK']);
          Exit;
        End;
      End;

      frxRelRetorno.Script.Variables['NOMREL']  := 'RELATÓRIO DE RETORNO DO SPC - BRASIL';
      frxRelRetorno.Script.Variables['PERIODO'] := 'REFERENTE A CONFIRMAÇÃO DE '+ strDataArq;
      frxRelRetorno.Script.Variables['PARAM1']  := '';
      frxRelRetorno.Script.Variables['PARAM2']  := '';
      pPreviewReport(Self.Name, 'Relatório de retorno do SPC - BRASIL', frxRelRetorno);
      CloseFile(mArquivo);

      strNomArq := fraArqRetorno.edtDirectory.text + '\' + strNomArq;

      If Not fRenomeiaArquivo(strNomArq) Then
      Begin
        Exit;
      End;

      fMensagem('','Arquivo de confirmação importado com sucesso!',['&OK']);

      Result := True;
    end;
  end;
end;

function TfrmProcArqSPC.fRenomeiaArquivo(strNomArq: String): Boolean;
  Var
    strNomArqNovo: String;
    intNumOld    : Integer;

Begin
  intNumOld := 1;

  Repeat

    Result := True;

    If intNumOld = 1 Then
      strNomArqNovo := ChangeFileExt(strNomArq,'.old')
    Else
      strNomArqNovo := ChangeFileExt(strNomArq,'.old' + IntToStr(intNumOld));

    Inc(intNumOld);
  Until Not FileExists(strNomArqNovo);

  If Not RenameFile(strNomArq,strNomArqNovo) Then
  Begin
    fMensagem('','Não foi possível Renomear do arquivo!',['&Ok']);
    Result := False;
  End;

End;

procedure TfrmProcArqSPC.FormActivate(Sender: TObject);
begin
  inherited;
  With cdsDetalhes Do
  Begin
    CreateDataSet;
    Open;
    EmptyDataSet;
  End;

  With cdsNEncontrados Do
  Begin
    CreateDataSet;
    Open;
    EmptyDataSet;
  End;
  pSetFocus(fraArqRetorno);
end;

procedure TfrmProcArqSPC.FormShow(Sender: TObject);
begin
  inherited;
  fraArqRetorno.edtDirectory.text := fGetBancoConfig(0, 'CONFIGSPC', 'PATHRET', '');

  If SysUtils.DirectoryExists(fraArqRetorno.edtDirectory.text) Then
  Begin
    lstArquivo.ApplyFilePath(fraArqRetorno.edtDirectory.text);
  End;
end;

procedure TfrmProcArqSPC.lstArquivoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
    btnSair.Click;

  If (Key = VK_RETURN) Then
    btnGerar.Click;
end;

procedure TfrmProcArqSPC.pBuscaClienteNaDuplicata(strNumDup, strParcel,
  strEspDoc, strCodEmp: String; var strCodCli: String);
var
  qryDup: TUniquery;
  strSQL: String;
begin
  qryDup := fCriaQuery;

  strCodCli := '';

  strSQL := '';
  strSQL := strSQL + 'SELECT CTR_CODCLI FROM CADREC ';
  strSQL := strSQL + ' WHERE CTR_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '       CTR_PARCEL = :PARCEL AND ';
  strSQL := strSQL + '       CTR_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '       CTR_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '       CTR_SEQBAI = 0       AND ';
  strSQL := strSQL + '       CTR_DTASPC IS NOT NULL   ';

  qryDup.SQL.Add(strSQL);
  qryDup.ParamByName('NUMDUP').AsString := strNumDup;
  qryDup.ParamByName('PARCEL').AsString := strParcel;
  qryDup.ParamByName('ESPDOC').AsString := strEspDoc;
  qryDup.ParamByName('CODEMP').AsString := strCodEmp;
  qryDup.Open;

  If Not qryDup.IsEmpty Then
    strCodCli := qryDup.FieldByName('CTR_CODCLI').AsString;

  FreeAndNil(qryDup);
end;

procedure TfrmProcArqSPC.pProcessaLinha(strLinha: String);
  Var
    qryGen, qryAux: TUniQuery;
    strSQL: String;
    strNomCli: String;
    strNumCtr: String;
    strNumDup: String;
    strParcel: String;
    strEspDoc: String;
    strCodEmp: String;
    strCodCli: String;
    strValor : String;
    strDtaVen: String;
    strCodOco: String;
    strCodEve: String;
    intCont: Integer;
begin
  qryGen := fCriaQuery;
  qryAux := fCriaQuery;

  strNumCtr := Copy(strLinha,50,25);

  If (Length(Trim(strNumCtr)) = 20) then
  Begin
    strNumDup := fStrZero(Copy(strNumCtr,001,12),12);
    strParcel := Trim(Copy(strNumCtr,013,03));
    strEspDoc := Copy(strNumCtr,016,02);
    strCodEmp := fStrZero(Copy(strNumCtr,018,03),3);
    strCodCli := '';
  End
  Else
  If Length(Trim(strNumCtr)) = 25 Then //duplicata com 12 digitos
  Begin
    strNumDup := fStrZero(Copy(strNumCtr,001,12),12);
    strParcel := Copy(strNumCtr,013,01);
    strEspDoc := TEspecieParaArquivoRemessa.New.fRetornaEspecieDoIndice(Copy(strNumCtr,014,01));
    strCodEmp := fStrZero(Copy(strNumCtr,015,03),3);
    strCodCli := fStrZero(Copy(strNumCtr,018,08),8);
  End;

  If fEmptyStr(strCodCli) Then
    pBuscaClienteNaDuplicata(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli);

  strDtaVen := Copy(strLinha,021,08);
  If Not fEmptyStr(strDtaVen) And (strDtaVen <> '00000000') Then
  Begin
    System.Insert('/', strDtaVen, 3);
    System.Insert('/', strDtaVen, 6);
  End;

  strValor  := Copy(strLinha,037,13);
  strCodOco := Copy(strLinha,090,03);

  strCodEve := fRetornaCodEvento(RightStr(strCodOco,2), 'SPC');

  strSQL := '';
  strSQL := strSQL + 'SELECT CLI_NOMCLI ';
  strSQL := strSQL + 'FROM CADCLI ';
  strSQL := strSQL + 'WHERE CLI_CODCLI = :CODCLI ';

  with qryGen do
  begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString := strCodCli;
    Open;
  end;

  If qryGen.IsEmpty Then
    strNomCli := 'CLIENTE NÃO CADASTRADO'
  Else
    strNomCli := qryGen.FieldByName('CLI_NOMCLI').AsString;

  strSQL := '';
  strSQL := strSQL + 'SELECT CTR_DTASPC, CTR_STSSPC FROM CADREC ';
  strSQL := strSQL + ' WHERE CTR_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '       CTR_PARCEL = :PARCEL AND ';
  strSQL := strSQL + '       CTR_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '       CTR_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '       CTR_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '       CTR_DTASPC IS NOT NULL ';

  with qryAux do
  begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDUP').AsString   := strNumDup;
    ParamByName('PARCEL').AsString   := strParcel;
    ParamByName('ESPDOC').AsString   := strEspDoc;
    ParamByName('CODEMP').AsString   := strCodEmp;
    ParamByName('CODCLI').AsString   := strCodCli;
    Open;
  end;

  if Not qryAux.IsEmpty Then
  begin
    strSQL := '';
    strSQL := strSQL + ' UPDATE CADREC SET ';
    strSQL := strSQL + '       CTR_DTCSPC = :DTACON ';

    If not fEmptyStr(strCodEve) then
      strSQL := strSQL + '   , CTR_CODEVE = :CODEVE ';

    strSQL := strSQL + ' WHERE CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '       CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '       CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '       CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '       CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '       CTR_DTASPC IS NOT NULL ';

    with qryGen do
    begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTACON').AsDate   := strToDateTime(strDataArq);
      ParamByName('NUMDUP').AsString := strNumDup;
      ParamByName('PARCEL').AsString := strParcel;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;

      If not fEmptyStr(strCodEve) then
        ParamByName('CODEVE').AsString := strCodEve;

      ExecSQL;
    end;

    cdsDetalhes.Insert;

    cdsDetalhes.FieldByName('NUMDUP').AsString   := strNumDup + strParcel + strEspDoc;
    cdsDetalhes.FieldByName('CODEMP').AsString   := strCodEmp;
    cdsDetalhes.FieldByName('CLIENTE').AsString  := strCodCli + '-' + strNomCli;
    cdsDetalhes.FieldByName('DTASPC').AsDateTime := qryAux.FieldByName('CTR_DTASPC').AsDateTime;
    cdsDetalhes.FieldByName('DTCSPC').AsDateTime := strToDateTime(strDataArq);
    cdsDetalhes.FieldByName('VALOR').AsFloat     := fStrToFloat(strValor)/100 ;
    cdsDetalhes.FieldByName('DTAVEN').AsDateTime := strToDateTime(strDtaVen);

    IF qryAux.FieldByName('CTR_STSSPC').AsString = 'I' then
      cdsDetalhes.FieldByName('STATUS').AsString   := 'Inclusão'
    else
      cdsDetalhes.FieldByName('STATUS').AsString   := 'Exclusão';

    if qryAux.FieldByName('CTR_STSSPC').AsString = 'E' THEN
    BEGIN
      For intCont := Low(ARR_OCORRENCIA_SPCBRASIL) To High(ARR_OCORRENCIA_SPCBRASIL) Do
      begin
        if (ARR_OCORRENCIA_SPCBRASIL[intCont][0] = strCodOco) then
        begin
          cdsDetalhes.FieldByName('MOTIVO').AsString := ARR_OCORRENCIA_SPCBRASIL[intCont][1];
        end;
      end;
    END
    else
    if qryAux.FieldByName('CTR_STSSPC').AsString = 'I' THEN
    begin
      cdsDetalhes.FieldByName('MOTIVO').AsString := '045 - Inclusão';
    end;

    cdsDetalhes.Post;
  end
  else
  begin
    cdsNEncontrados.Insert;
    cdsNEncontrados.FieldByName('NUMDUP').AsString   := strNumDup + strParcel + '-' + strEspDoc;
    cdsNEncontrados.FieldByName('CODEMP').AsString   := strCodEmp;
    cdsNEncontrados.FieldByName('CLIENTE').AsString  := strCodCli + '-' + strNomCli;
    cdsNEncontrados.FieldByName('VALOR').AsFloat     := fStrToFloat(strValor)/100;
    cdsNEncontrados.FieldByName('DTAVEN').AsDateTime := strToDateTime(strDtaVen);
    cdsNEncontrados.Post;
  end;

  FreeAndNil(qryGen);
  FreeAndNil(qryAux);
end;

function TfrmProcArqSPC.fRetornaCodEvento(strCodOco, strCodBco: String): String;
VAR
  qryCons: TUniquery;
begin
  qryCons := fCriaQuery;

  With qryCons Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT RET_CODEVE FROM OCORET WHERE RET_CODOCO = :CODOCO AND RET_CODBCO = :CODBCO AND RET_CODEMP = :CODEMP ');
    ParamByName('CODOCO').AsString := strCodOco;
    ParamByName('CODBCO').AsString := strCodBco;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;

    Result := FieldByName('RET_CODEVE').AsString;
  End;

  FreeAndNil(qryCons);
end;

procedure TfrmProcArqSPC.fraArqRetornoedtDirectoryExit(Sender: TObject);
begin
  //#Asimov#
  fraArqRetornoFocusChanged(Sender);
end;

procedure TfrmProcArqSPC.fraArqRetornoedtDirectoryEnter(Sender: TObject);
begin
  //#Asimov#
  fraArqRetornoFocusChanged(Sender);
end;

end.
