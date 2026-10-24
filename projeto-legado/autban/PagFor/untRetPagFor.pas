unit untRetPagFor;

interface
{$WARN UNIT_PLATFORM OFF}

uses
  Winapi.Windows, Winapi.Messages, SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.FileCtrl, cxTextEdit,
  cxMaskEdit, cxButtonEdit, DirectoryEditFocus, Data.DB, Datasnap.DBClient,
  UniClientDataSet, frxDBSet, untTPagFor, untFuncoes, untFuncoesSimples, 
  untFrameDirectoryEditFocus, untPagForAPIRetPagForFrame, cxProgressBar,
  System.DateUtils;

type
  TfrmRetPagFor = class(TfrmPai)
    pnlPath: TPanel;
    lblPathArquivosRet: TLabel;
    lblCaminhoMsg: TLabel;
    pnlTopo: TPanel;
    fraPathRetornoBco: TfraDirectoryEditFocus;
    pnlArquivos: TPanel;
    lstArquivo: TFileListBox;
    btnGravar: TBitBtnLocked;
    Panel1: TPanel;
    flbArquiv: TFileListBox;
    frxReportJ: TfrxReport;
    frxReportM: TfrxReport;
    frxDBNaoGra: TfrxDBDataset;
    cdsNaoGra: TUniClientDataSet;
    cdsNaoGraNOSNUM: TStringField;
    cdsNaoGraDTAVEN: TDateField;
    cdsNaoGraDTAPAG: TDateField;
    cdsNaoGraVALDUP: TFloatField;
    cdsNaoGraVALPAG: TFloatField;
    cdsNaoGraCODCLI: TStringField;
    cdsNaoGraCODEMP: TStringField;
    cdsNaoGraESPDOC: TStringField;
    cdsNaoGraNUMDUP: TStringField;
    frxInconsistenciaRetorno: TfrxReport;
    cdsNaoGraMOTIVO: TStringField;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure fraPathRetornoBcoFocusChanged(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure fraPathRetornoBcoedtDirectoryEnter(Sender: TObject);
    procedure fraPathRetornoBcoedtDirectoryExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure mnuConfigurarRelClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    FImportacaoAPI: Boolean;

    FObjetoImportacao: TObject;

    fraImportacaoAPI: TfraPagForAPIRetPagForFrame;

    function fValidaArquivos : Boolean;
    function fValidaDiretorio: Boolean;
    procedure pHabilitaSelecao(blnHabilita : boolean);
    function RetornaRelatorio : TfrxReport;
    { Private declarations }
  public
    strCodBco,
    strNomBco,
    strConfig: String;

    property ImportacaoAPI: Boolean read FImportacaoAPI write FImportacaoAPI;
    { Public declarations }
  end;

var
  frmRetPagFor: TfrmRetPagFor;

implementation
Uses untTPagForBancoDoBrasilAPI;
{$R *.dfm}

procedure TfrmRetPagFor.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  inherited;
//
end;

procedure TfrmRetPagFor.btnGravarClick(Sender: TObject);
  Var
    objPagFor: TPagFor;
    lstArquiv: TStringList;
    intCont  : Integer;

    LPagForAPI: TObject;
begin
  inherited;

  If FImportacaoAPI Then
  Begin
    If Not fraImportacaoAPI.ValidarDados Then
      Exit;

    LPagForAPI := TObject.Create;
    Try
      Case StrToInt(strCodBco) Of
        1: Begin
             TPagForBancoDoBrasilAPI(FObjetoImportacao).PagForObjeto.frxReportJ := RetornaRelatorio;
             TPagForBancoDoBrasilAPI(FObjetoImportacao).PagForObjeto.frxReportM := frxReportM;
             TPagForBancoDoBrasilAPI(FObjetoImportacao).ImportarPagamentos(fraImportacaoAPI.edtDataInicial.Date,
                                                                           fraImportacaoAPI.edtDataFinal.Date,
                                                                           cdsNaoGra);
           End;
      End;

      Exit;
    Finally
      FreeAndNil(LPagForAPI);
    End;
  End;

  If Not SysUtils.DirectoryExists(fraPathRetornoBco.edtDirectory.text) Then
  Begin
    fMensagem('ATENÇÃO','Caminho não existe!',['&OK']);
    pSetFocus(fraPathRetornoBco);
    Exit;
  End;

  If Not fValidaArquivos Then
  Begin
    fMensagem('ATENÇÃO','Os arquivos selecionados não estão no caminho indicado. Favor verificar!',['&OK']);
    Exit;
  End;

  If flbArquiv.SelCount <= 0 Then
  Begin
    fMensagem('ATENÇÃO','Selecione o arquivo que deseja importar!',['&OK']);
  End
  Else
  Begin
    If fMensagem('ATENÇÃO','Confirma a Importação do Arquivo de Retorno?',['&Sim', '&Não']) = 1 Then
    Begin
      Try
        lstArquiv := TStringList.Create;
        For intCont := 0 To flbArquiv.Count - 1 Do
          if flbArquiv.Selected[intCont] then
            lstArquiv.Add(fraPathRetornoBco.edtDirectory.text + '\' + flbArquiv.Items.Strings[intCont]);

        objPagFor := TPagFor.Create;
        objPagFor.frxReportJ := RetornaRelatorio;
        objPagFor.frxReportM := frxReportM;
        objPagFor.fImportaPagFor(lstArquiv, strCodBco, strNomBco, cdsNaoGra,strConfig);
      Finally
        FreeAndNil(objPagFor);
        FreeAndNil(lstArquiv);
      End;
    End;
    Self.Close;
  End;
end;

procedure TfrmRetPagFor.fraPathRetornoBcoFocusChanged(Sender: TObject);
begin
  inherited;
  pHabilitaSelecao(fValidaDiretorio);
end;

procedure TfrmRetPagFor.btnSairClick(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmRetPagFor.FormActivate(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmRetPagFor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  If FImportacaoAPI Then
    FreeAndNil(FObjetoImportacao);
end;

procedure TfrmRetPagFor.FormCreate(Sender: TObject);
begin
  inherited;
  FImportacaoAPI := False;

  fraImportacaoAPI := TfraPagForAPIRetPagForFrame.Create(Self);
  fraImportacaoAPI.Parent := Self;
  fraImportacaoAPI.Visible := False;

  fraImportacaoAPI.Left := 0;
  fraImportacaoAPI.Top := 0;
end;

procedure TfrmRetPagFor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
    btnSair.Click;

  If (Key = VK_RETURN) Then
  Begin
    If Not FImportacaoAPI Then
      btnGravar.Click
    Else
      Key := VK_TAB;
  End;
end;

procedure TfrmRetPagFor.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
//
end;

procedure TfrmRetPagFor.FormPaint(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmRetPagFor.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  inherited;
//
end;

procedure TfrmRetPagFor.FormShow(Sender: TObject);
begin
  inherited;
  pnlPath.Visible := Not FImportacaoAPI;
  pnlArquivos.Visible := Not FImportacaoAPI;

  fraImportacaoAPI.Visible := FImportacaoAPI;

  If Not FImportacaoAPI Then
  Begin
    fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, strConfig, 'PATHRET', '');
    pHabilitaSelecao(fValidaDiretorio);

    Self.Height := 340;
    Self.Width := 495;
  End
  Else
  Begin
    Self.Height := 252;
    Self.Width := 437;

    fraImportacaoAPI.edtDataInicial.Date := IncDay(VS_Date, -5);
    fraImportacaoAPI.edtDataFinal.Date := VS_Date;

    Case StrToInt(strCodBco) Of
      1: Begin
           FObjetoImportacao := TPagFor.RetornaObjetoAPI('001', strConfig + '-' + VS_strCodEmp);
           fraImportacaoAPI.CarregarDadosCarteira(TPagForBancoDoBrasilAPI(FObjetoImportacao).DadosCarteira);
           pSetFocus(fraImportacaoAPI.edtDataInicial);
         End;
    End;

  End;
end;

function TfrmRetPagFor.fValidaArquivos: Boolean;
  var
    intContador : integer;
begin
  Result := True;

  For intContador := 0 To lstArquivo.Count-1 Do
  Begin
    If lstArquivo.Selected[intContador] Then
    Begin
      If Not FileExists(fraPathRetornoBco.edtDirectory.text + '\' + lstArquivo.Items.Strings[intContador]) Then
      Begin
       Result := False;
       Break;
      End;
    End;
  End;
end;

function TfrmRetPagFor.fValidaDiretorio : Boolean;
begin
  Result := False;
  lblCaminhoMsg.Caption := 'Diretório não encontrado!';

  Try
    If SysUtils.DirectoryExists(fraPathRetornoBco.edtDirectory.text) Then
    Begin
      flbArquiv.ApplyFilePath(fraPathRetornoBco.edtDirectory.text);
      Result := True;
    End;
  Except
    lblCaminhoMsg.Caption := 'Sem permissão de acesso ao diretório!';
  End;

end;

procedure TfrmRetPagFor.mnuConfigurarRelClick(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmRetPagFor.pHabilitaSelecao(blnHabilita : boolean);
Begin
  If blnHabilita Then
  Begin
    lstArquivo.Color      := clWindow;
    lstArquivo.Enabled    := True;
    lblCaminhoMsg.Visible := False;
  End
  Else
  Begin
    lstArquivo.Color      := clSilver;
    lstArquivo.Enabled    := False;
    lblCaminhoMsg.Visible := True;
  End;
End;

function TfrmRetPagFor.RetornaRelatorio: TfrxReport;
begin
  Result := frxReportJ;
  If fGetBancoConfig(0, strConfig, 'REL_MOTIVO_INCONS', '').Equals('S') Then
    Result := frxInconsistenciaRetorno;
end;

procedure TfrmRetPagFor.fraPathRetornoBcoedtDirectoryExit(Sender: TObject);
begin
  //#Asimov#
  fraPathRetornoBcoFocusChanged(Sender);
end;

procedure TfrmRetPagFor.fraPathRetornoBcoedtDirectoryEnter(Sender: TObject);
begin
  //#Asimov#
  fraPathRetornoBcoFocusChanged(Sender);
end;

end.
