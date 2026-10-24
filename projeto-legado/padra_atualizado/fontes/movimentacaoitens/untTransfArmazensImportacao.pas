unit untTransfArmazensImportacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, cxTextEdit,
  cxMaskEdit, cxButtonEdit, FilenameEditFocus, Grids, ComObj, Data.DB,
  UniClientDataSet;

type
  EValida = class(Exception);

  TfrmTransfArmazensImportacao = class(TfrmPai)
    Label1: TLabel;
    edtPath: TFilenameEditFocus;
    pgbGeral: TProgressBar;
    btnGravar: TBitBtnLocked;
    btnHlpImp: TBitBtnLocked;
    frxHelp: TfrxReport;
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    stlArqCsv: TStringList;
    blnArqCsv: Boolean;
    Excel : Variant;
    FCdsItens: TUniClientDataSet;
    FstrNomSing: string;
    FstrNomPlur: string;

    function fTemTitulo: boolean;

    procedure pIniciaLeitura;
    procedure pFinalizaLeitura;
    procedure pConfirmaImportacao;

    procedure pInsereItensCDS(intLinha: integer);
    procedure pLerDados(intLinha: integer; var strCodIte, strDesIte, strLotOri, strLotDes: String; var fltIteQtd: Double);

    procedure pValidaDados(strCodIte, strLotOri, strLotDes: String);
    procedure pValidaLoteOrigem(strCodIte, strLotOri: String);
    procedure pValidaLoteDestino(strCodIte, strLotDes: String);
    procedure pValidaArquivo;

    function fUsaEnderecamentoAndLoteADefinir(strLotOri: String): Boolean;

    const cCodIte = 'A';
  public
    { Public declarations }
    property CdsItens: TUniClientDataSet read FCdsItens;
    property strNomSing: string read FstrNomSing write FstrNomSing;
    property strNomPlur: string read FstrNomPlur write FstrNomPlur;
  end;

implementation

{$R *.dfm}

uses
  StrUtils, untFuncoesSimples, untTransfArmazensImportacaoConfirma, untCadLote;

procedure TfrmTransfArmazensImportacao.btnGravarClick(Sender: TObject);
Var
  intValIni, intContador : Integer;
  dteInicio, dteFim: TDateTime;
begin
  inherited;
  try
    pValidaArquivo;
  except
    on E: EValida do
    begin
      fMensagem('AVISO', E.Message, ['&O K']);
      pSetFocus(edtPath);
      Exit;
    end;
  end;

  try
    btnHlpImp.Enabled     := False;
    btnGravar.Enabled     := False;
    btnSair.Enabled       := False;
    edtPath.Enabled       := False;

    Mouse.SettingChanged(10);

    pnlInfo.Caption       := 'Aguarde... Importando...';

    edtPath.Text := AnsiReplaceStr(edtPath.Text,'"','');

    Try
      blnArqCsv := Copy(edtPath.Text, Length(edtPath.Text)-2, 3) = 'csv';

      pIniciaLeitura;

      pgbGeral.Position := 0;

      FCdsItens.EmptyDataSet;

      dteInicio := fNow();

      If fTemTitulo Then
        intValIni := 2
      Else
        intValIni := 1;

      For intContador := intValIni To (pgbGeral.Max + 1) Do
      Begin
        If blnArqCsv Then
        Begin
          If intContador > stlArqCsv.Count Then
            Continue;
        End;

        pInsereItensCDS(intContador);
        pgbGeral.StepBy(1);

        dteFim := fNow();

        pnlInfo.Caption := 'Importando: ' + IntToStr(intContador) + ' de ' + IntToStr(pgbGeral.Max + 1)
        + ' - Tempo Rest.: '
        + IntToStr(Trunc((pgbGeral.Max-IntContador)/(intcontador / ((((dteFim - dteInicio) * 86400)) / 60))+1)) +' min. (' +IntToStr(Trunc((intcontador / ((((dteFim - dteInicio) * 86400)) / 60)))) +'/min)';

        pnlInfo.Refresh;
      End;

      pConfirmaImportacao;

      SetForegroundWindow(Handle);

      edtPath.Clear;
      btnHlpImp.Enabled     := True;
      btnGravar.Enabled     := True;
      btnSair.Enabled       := True;
      edtPath.Enabled       := True;
      pnlInfo.Caption       := '';
      pgbGeral.Position     := 0;
      pSetFocus(btnSair);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmTransfArmazensImportacao.btnGravarClick]');
        btnHlpImp.Enabled := True;
        btnGravar.Enabled := True;
        btnSair.Enabled   := True;
        edtPath.Enabled   := True;
        pnlInfo.Caption   := '';
        pgbGeral.Position := 0;
        pSetFocus(btnSair);
      End;
    End;
  Finally
    pFinalizaLeitura;

    btnSair.Enabled   := True;
    edtPath.Enabled   := True;
    btnHlpImp.Enabled := True;
    btnGravar.Enabled := True;
    pnlInfo.Caption := '';
  End
end;

procedure TfrmTransfArmazensImportacao.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

procedure TfrmTransfArmazensImportacao.FormCreate(Sender: TObject);
begin
  inherited;
  edtPath.Dialog.Dialog.Filter := 'Arquivos Suportados|*.xls;*.xlsx;*.csv';


  FCdsItens := TUniClientDataSet.Create(Nil);
  FCdsItens.FieldDefs.Add('ITECOD', FtString, fTamCodIte);
  FCdsItens.FieldDefs.Add('DESITE', FtString, 70);
  FCdsItens.FieldDefs.Add('LOTORI', FtString, 20);
  FCdsItens.FieldDefs.Add('LOTDES', FtString, 20);
  FCdsItens.FieldDefs.Add('ITEQTD', FtFloat);
  FCdsItens.FieldDefs.Add('ERRO'  , FtString, 1000);
  FCdsItens.FieldDefs.Add('STATUS', FtString, 20);

  FCdsItens.CreateDataSet;
end;

procedure TfrmTransfArmazensImportacao.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FCdsItens);
end;

procedure TfrmTransfArmazensImportacao.FormShow(Sender: TObject);
begin
  inherited;
  Self.Caption := 'Importação Transferência entre ' + strNomPlur;
end;

function TfrmTransfArmazensImportacao.fTemTitulo: boolean;
var
  intValDef: Integer;
  strLinha: String;
  Splited: TArray<String>;
begin
  If Not blnArqCsv Then
  Begin
    If Trim(Excel.Range[cCodIte + IntToStr(1)].Value) <> '' Then
      Result := not TryStrToInt(Trim(Excel.Range[cCodIte + IntToStr(1)].Value), intValDef)
    Else
      Result := False;
  End
  Else
  begin
    strLinha := stlArqCsv[0];
    Splited := strLinha.Split([';']);
    if Splited[0] <> '' then
       Result := not TryStrToInt(Splited[0], intValDef)
    Else
      Result := False;
  end;
end;

function TfrmTransfArmazensImportacao.fUsaEnderecamentoAndLoteADefinir(
  strLotOri: String): Boolean;
begin
  Result := True;
  if not fUsaEnderecamento then
     Exit(False);

  if not (UpperCase(strLotOri) = 'A DEFINIR') then
    Exit(False);
end;

procedure TfrmTransfArmazensImportacao.pValidaArquivo;
begin
  if fEmptyStr(edtPath.Text) then
    raise EValida.Create('Informe o arquivo para importar!');

  If Not (FileExists(edtPath.Text)) Then
    raise EValida.Create('Arquivo não encontrado : ' + edtPath.Text + ' !');
end;

procedure TfrmTransfArmazensImportacao.pValidaDados(strCodIte, strLotOri, strLotDes: String);
begin
  if fEmptyStr(fCampoTabela('ITE_CODITE', 'CADITE', ['ITE_CODITE'], [strCodIte], False)) then
    raise EValida.Create('Produto de código "' + strCodIte + '" não encontrado!');

  pValidaLoteOrigem(strCodIte, strLotOri);
  pValidaLoteDestino(strCodIte, strLotDes);

  If SameText(strLotOri, strLotDes) Then
    raise EValida.Create( strNomSing + ' origem deve ser diferente do ' + strNomSing + ' destino!');
end;

procedure TfrmTransfArmazensImportacao.pValidaLoteDestino(strCodIte,
  strLotDes: String);
begin
  If SameText('A DEFINIR', strLotDes) Then
    raise EValida.Create('O ' + strNomSing + ' A DEFINIR não pode ser utilizado como destino!');

  If Not fNumLotAtivo(strCodIte, strLotDes, VS_strCodEmp) Then
    raise EValida.Create('Não é permitido movimentação de estoque para ' + strNomPlur + ' inativos');

  if fEmptyStr(fCampoTabela('AUTOINCREM', 'CADLOT', ['LOT_CODITE', 'LOT_CODEMP', 'LOT_NUMLOT'], [strCodIte, VS_strCodEmp, strLotDes], False)) then
    raise EValida.Create(strNomSing + ' de destino não encontrado!');
end;

procedure TfrmTransfArmazensImportacao.pValidaLoteOrigem(strCodIte, strLotOri: String);
begin
  If fUsaEnderecamentoAndLoteADefinir(strLotOri) Then
    raise EValida.Create('Não é permitido transferir apartir do ' + strNomSing + ' "A Definir" quando utiliza o Endereçamento de Produtos!');

  If Not fNumLotAtivo(strCodIte, strLotOri, VS_strCodEmp) Then
    raise EValida.Create('Não é permitido movimentação de estoque para ' + strNomPlur + ' inativos');

  if fEmptyStr(fCampoTabela('AUTOINCREM', 'CADLOT', ['LOT_CODITE', 'LOT_CODEMP', 'LOT_NUMLOT'], [strCodIte, VS_strCodEmp, strLotOri], False)) then
    raise EValida.Create(strNomSing + ' de origem não encontrado!');
end;

procedure TfrmTransfArmazensImportacao.pConfirmaImportacao;
var
  frmTransfArmazensImportacaoConfirma: TfrmTransfArmazensImportacaoConfirma;
begin
  If not FCdsItens.IsEmpty Then
  Begin
    FCdsItens.First;
    pCriarFormularios(TfrmTransfArmazensImportacaoConfirma, frmTransfArmazensImportacaoConfirma);
    Try
      frmTransfArmazensImportacaoConfirma.strNomSing := strNomSing;
      frmTransfArmazensImportacaoConfirma.strNomPlur := strNomPlur;
      if frmTransfArmazensImportacaoConfirma.Confirmar(FCdsItens) then
        ModalResult := MrOk;
    Finally
      FreeAndNil(frmTransfArmazensImportacaoConfirma);
    End;
  End;
end;

procedure TfrmTransfArmazensImportacao.pFinalizaLeitura;
begin
  If Not blnArqCsv Then
  Begin
    Excel.WorkBooks.Close;
    Excel.Quit;
  End
  Else
    FreeAndNil(stlArqCsv);
end;

procedure TfrmTransfArmazensImportacao.pIniciaLeitura;
begin
  If Not blnArqCsv Then
  Begin
    {**************************************}
    {* ABRE EXCEL E ARQUIVO XLS           *}
    {***********************************LU*}
    Excel := CreateOleObject('Excel.Application');
    Excel.Visible       := False;
    Excel.DisplayAlerts := False;
    Excel.WorkBooks.Open(Filename := edtPath.Text);

    {****************************************}
    {* VAI PARA A ULTIMA CELULA COM DADOS   *}
    {* PARA PEGAR A QUANTIDADE DE REGISTROS *}
    {*************************************LU*}

    {xlCellTypeLastCell. A última célula no intervalo usado}
    Excel.Selection.SpecialCells(11).Select;

    pgbGeral.Max := Excel.ActiveCell.Row -1;
  End
  Else
  Begin
    stlArqCsv := TStringList.Create;
    stlArqCsv.LoadFromFile(edtPath.Text);
    pgbGeral.Max := stlArqCsv.Count;
  End;
end;

procedure TfrmTransfArmazensImportacao.pInsereItensCDS(intLinha: integer);
var
  strCodIte, strDesIte, strLotOri, strLotDes: String;
  fltIteQtd: Double;
begin

  pLerDados(intLinha, strCodIte, strDesIte, strLotOri, strLotDes, fltIteQtd);
  if fltIteQtd = 0 then
    Exit;

  FCdsItens.Append;
  FCdsItens.FieldByName('ITECOD').AsString := strCodIte;
  FCdsItens.FieldByName('DESITE').AsString := strDesIte;
  FCdsItens.FieldByName('LOTORI').AsString := strLotOri;
  FCdsItens.FieldByName('LOTDES').AsString := strLotDes;
  FCdsItens.FieldByName('ITEQTD').AsFloat  := fltIteQtd;
  FCdsItens.FieldByName('STATUS').AsString := 'Sucesso';

  try
    pValidaDados(strCodIte, strLotOri, strLotDes)
  except
    on E: EValida do
    begin
      FCdsItens.FieldByName('STATUS').AsString := 'Erro';
      FCdsItens.FieldByName('ERRO').AsString   := E.Message;
    end;
  end;

  FCdsItens.Post;
end;

procedure TfrmTransfArmazensImportacao.pLerDados(intLinha: integer; var strCodIte, strDesIte, strLotOri, strLotDes: String; var fltIteQtd: Double);
var
  strLinha: String;
  Splited: TArray<String>;
begin
  If Not blnArqCsv Then
  Begin
    strCodIte := Trim(Excel.Range[cCodIte + IntToStr(intLinha)].Value);
    strDesIte := Trim(Excel.Range['B' + IntToStr(intLinha)].Value);
    strLotOri := Trim(Excel.Range['I' + IntToStr(intLinha)].Value);
    strLotDes := Trim(Excel.Range['C' + IntToStr(intLinha)].Value);
    fltIteQtd := StrToFloatDef(Trim(Excel.Range['K' + IntToStr(intLinha)].Value), 0);
  End
  Else
  Begin
    If intLinha > stlArqCsv.Count Then
      Exit;

    strLinha := stlArqCsv[intLinha-1];
    Splited := strLinha.Split([';']);

    strCodIte := Splited[0];
    strDesIte := Splited[1];
    strLotOri := Splited[8];
    strLotDes := Splited[2];
    fltIteQtd := StrToFloatDef(Splited[10], 0);
  End;

  If (Not fEmptyStr(strCodIte)) And (Length(strCodIte) < fTamCodIte) Then
    strCodIte := fPadL(strCodIte, fTamCodIte, '0');
end;

end.
