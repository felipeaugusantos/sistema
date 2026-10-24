unit untImportacaoClientesDaPromocao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxProgressBar, cxTextEdit,
  cxMaskEdit, cxButtonEdit, FilenameEditFocus, Data.DB, Datasnap.DBClient,
  UniClientDataSet, untTValidaExcel, untFuncoesSimples, cxButtons;

type
  TfrmImportacaoClientesDaPromocao = class(TfrmPai)
    lblPathDoArquivo: TLabel;
    edtPath: TFilenameEditFocus;
    pgbGeral: TcxProgressBar;
    btnGravar: TBitBtnLocked;
    cdsCliTmp: TUniClientDataSet;
    cdsCliTmpCODCLI: TStringField;
    cdsCliTmpNOMCLI: TStringField;
    btnHlpImp: TcxButton;
    frxHelp: TfrxReport;
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
  private

    const
      cQtdColunas = 2;

      cCODCLI = 'A';
      cNOMCLI = 'B';

      cDes_CODCLI = 'Código do Cliente';
      cDes_NOMCLI = 'Nome do Cliente';

  private
    objValidaExcel : TValidadorExcel;

    procedure pProcessaItens;
    procedure pInsereItensCDS(intLinha: integer);
    function  fTemTitulo: boolean;
    function  fConvetVazioToNull(texto: string): Variant;

  public
    stlClientesInexistentes : TStringList;
  end;

implementation

{$R *.dfm}

procedure TfrmImportacaoClientesDaPromocao.btnGravarClick(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtPath.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'Informe o caminho do arquivo para a importação!', ['&Ok']);
    Exit;
  End;

  If Not (FileExists(edtPath.Text)) Then
  Begin
    fMensagem('AVISO','Arquivo não encontrado : ' + edtPath.Text + ' !', ['&O K']);
    Exit;
  End;

  pgbGeral.Visible := True;
  objValidaExcel   := TValidadorExcel.Create(edtPath.text, cQtdColunas, cCODCLI, '', 0);

  Try
    pProcessaItens;
    ModalResult := mrOk;
  Finally
    FreeAndNil(objValidaExcel);
    pgbGeral.Visible := False;
  End;

end;

procedure TfrmImportacaoClientesDaPromocao.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

function TfrmImportacaoClientesDaPromocao.fConvetVazioToNull(texto: string): Variant;
begin
  If Texto = '' Then
    Result := null
  Else
    Result := texto;
end;

procedure TfrmImportacaoClientesDaPromocao.FormCreate(Sender: TObject);
begin

  inherited;

  cdsCliTmp.CreateDataSet;
  cdsCliTmp.EmptyDataSet;

  stlClientesInexistentes := TStringList.Create;
  stlClientesInexistentes.Clear;

end;

function TfrmImportacaoClientesDaPromocao.fTemTitulo: boolean;
  var
    intValDef: Integer;
begin
  If objValidaExcel.fGetValueCSV(0, cCODCLI) <> '' Then
    Result := not TryStrToInt(Trim(objValidaExcel.fGetValueCSV(0, cCODCLI)), intValDef)
  Else
    Result := False;
end;

procedure TfrmImportacaoClientesDaPromocao.pInsereItensCDS(intLinha: integer);
  var
    strCodCli : String;
    strNomCli : String;
    blnClienteExiste : Boolean;
begin

  Try

    If objValidaExcel.fGetValueCSV(intLinha, cCODCLI).IsEmpty Then
      Exit;

    strCodCli := fConvetVazioToNull(objValidaExcel.fGetValueCSV(intLinha, cCODCLI));
    strNomCli := fRetNomCliente(strCodCli);

    blnClienteExiste := Not strNomCli.IsEmpty;

    If Not blnClienteExiste Then
    Begin
      stlClientesInexistentes.Add(strCodCli);
      Exit;
    End;

    cdsCliTmp.Append;
    cdsCliTmpCODCLI.AsString := strCodCli;
    cdsCliTmpNOMCLI.AsString := strNomCli;
    cdsCliTmp.Post;

  Except
    on E: Exception do
      pMensagensErro(E.Message, '[TfrmImportacaoClientesDaPromocao.pInsereItensCDS]');
  End;

end;

procedure TfrmImportacaoClientesDaPromocao.pProcessaItens;
  var
    intValIni,
    intContador : Integer;
begin

  cdsCliTmp.EmptyDataSet;
  stlClientesInexistentes.Clear;

  pgbGeral.Properties.Max := objValidaExcel.ArquivoCSV.Count;
  pgbGeral.Position := 0;

  intValIni := IIf(fTemTitulo, 1 , 0);

  For intContador := intValIni To (objValidaExcel.ArquivoCSV.Count -1) Do
  Begin
    pnlInfo.Caption := 'Importando os itens... ' + IntToStr(intContador) + '/' + IntToStr(objValidaExcel.ArquivoCSV.Count);

    If intContador > objValidaExcel.ArquivoCSV.Count Then
      Continue;

    pInsereItensCDS(intContador);

    pgbGeral.Position := pgbGeral.Position + 1;
    Application.ProcessMessages;
  End;

end;

end.
