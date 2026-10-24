unit untCtaImpDDA;

interface
{$WARN UNIT_PLATFORM OFF}
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask,
  DirectoryEditFocus, FileCtrl, untFuncoesSimples, Uni, untTypesSistema,
  untFuncoesBoleto, StrUtils, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFuncAutban, untTImportaDDA, 
  untFrameDirectoryEditFocus;

type
  TfrmCtaImpDDA = class(TfrmPaiConfirma)
    pnlTopo: TPanel;
    pnlPath: TPanel;
    lblPathArquivosRet: TLabel;
    fraPathImpDDA: TfraDirectoryEditFocus;
    pnlArquivos: TPanel;
    lstArquivo: TFileListBox;
    btnGravar: TBitBtnLocked;
    lblCaminhoMsg: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure fraPathImpDDAPropertiesChange(Sender: TObject);

    procedure pHabilitaSelecao(blnHabilita : boolean);

    function fValidaDiretorio : Boolean;
    function fValidaArquivos : Boolean;
    procedure fraPathImpDDAFocusChanged(Sender: TObject);
    procedure fraPathImpDDAedtDirectoryEnter(Sender: TObject);
    procedure fraPathImpDDAedtDirectoryExit(Sender: TObject);
    procedure fraPathImpDDAedtDirectoryChange(Sender: TObject);
  private
    FstrConfig: String;
    FstrCodBco: String;

    procedure pAtualizaHist;
    { Private declarations }
  public
    property strConfig: String read FstrConfig write FstrConfig;
    property strCodBco: String read FstrCodBco write FstrCodBco;
    { Public declarations }
  end;

var
  frmCtaImpDDA: TfrmCtaImpDDA;

implementation
Uses untGravando;
{$R *.dfm}

procedure TfrmCtaImpDDA.btnGravarClick(Sender: TObject);
  Var
    lstArquiv: TStringList;
    intCont  : Integer;
    objImpDDA: TImportaDDA;
begin
  inherited;

  If Not fValidaArquivos Then
  Begin
    fMensagem('ATENÇÃO','Os arquivos selecionados não estão no caminho indicado. Favor verificar!',['&OK']);
    Exit;
  End;

  Try
    If lstArquivo.SelCount <= 0 Then
      fMensagem('ATENÇÃO','Selecione o(s) arquivo(s) que deseja importar!',['&OK'])
    Else
    Begin
      pnlInfo.Caption := 'Importando arquivos... Aguarde!';
      Application.ProcessMessages;

      lstArquiv := TStringList.Create;
      For intCont := 0 To lstArquivo.Items.Count - 1 Do
        If lstArquivo.Selected[intCont] Then
          lstArquiv.Add(fraPathImpDDA.edtDirectory.text + '\' + lstArquivo.Items.Strings[intCont]);

      objImpDDA := TImportaDDA.Create;
      objImpDDA.fImportaDDA(lstArquiv, FstrCodBco);

      pAtualizaHist;

      FreeAndNil(objImpDDA);
      pnlInfo.Caption := '';
      Application.ProcessMessages;

      Close;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[frmCtaImpDDA.btnGravar]');
  End;
end;

procedure TfrmCtaImpDDA.fraPathImpDDAFocusChanged(Sender: TObject);
begin
  inherited;
  pHabilitaSelecao(fValidaDiretorio);
end;

procedure TfrmCtaImpDDA.fraPathImpDDAPropertiesChange(Sender: TObject);
begin
  inherited;
   If System.SysUtils.DirectoryExists(fraPathImpDDA.edtDirectory.text) Then
    lstArquivo.ApplyFilePath(fraPathImpDDA.edtDirectory.text);
end;

procedure TfrmCtaImpDDA.FormShow(Sender: TObject);
begin
  inherited;
  fraPathImpDDA.edtDirectory.text    := fGetBancoConfig(0, FstrConfig , 'PATHRET', '');

  pHabilitaSelecao(fValidaDiretorio);
end;

function TfrmCtaImpDDA.fValidaDiretorio : Boolean;
begin
  Result := False;

  If System.SysUtils.DirectoryExists(fraPathImpDDA.edtDirectory.text) Then
  Begin
    lstArquivo.ApplyFilePath(fraPathImpDDA.edtDirectory.text);
    Result := True;
  End;
end;

function TfrmCtaImpDDA.fValidaArquivos : Boolean;
var
  intContador : integer;
begin

  Result := True;

  For intContador := 0 To lstArquivo.Count-1 Do
  Begin
      If lstArquivo.Selected[intContador] Then
      Begin
        If Not System.SysUtils.FileExists(fraPathImpDDA.edtDirectory.text + '\' + lstArquivo.Items.Strings[intContador]) Then
        Begin
         Result := False;
         Break;
        End;
      End;
  End;

end;

procedure TfrmCtaImpDDA.pAtualizaHist;
  var
    strSQL: String;
    qryUpdHIS: TUniQuery;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'UPDATE                                       ';
    strSQL := strSQL + '  RETDDA                                     ';
    strSQL := strSQL + '  LEFT JOIN CADPAG                           ';
    strSQL := strSQL + '    ON AUTOINCREM = DDA_AUTCTP               ';
    strSQL := strSQL + '  LEFT JOIN CADFOR A                         ';
    strSQL := strSQL + '    ON A.FOR_CODFOR = DDA_CODFOR             ';
    strSQL := strSQL + '  LEFT JOIN CADFOR B                         ';
    strSQL := strSQL + '    ON B.FOR_CODFOR = CTP_CODFOR             ';
    strSQL := strSQL + ' SET                                         ';
    strSQL := strSQL + '   DDA_HIST01 = "DUPLICATA IMPORTADA - DDA"  ';
    strSQL := strSQL + 'WHERE DDA_HIST01 IS NULL                     ';
    strSQL := strSQL + '  AND (                                      ';
    strSQL := strSQL + '    A.FOR_CODFOR IS NOT NULL                 ';
    strSQL := strSQL + '    OR B.FOR_CODFOR IS NOT NULL              ';
    strSQL := strSQL + '  )                                          ';


    qryUpdHIS := fCriaQuery(Nil);

    qryUpdHIS.Close;
    qryUpdHIS.SQL.Clear;
    qryUpdHIS.SQL.Add(strSQL);
    qryUpdHIS.ExecSQL;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmCtaImpDDA.pAtualizaHist');
    End;
  End;

  qryUpdHIS.Close;
  FreeAndNil(qryUpdHIS);
end;

procedure TfrmCtaImpDDA.pHabilitaSelecao(blnHabilita : boolean);
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

procedure TfrmCtaImpDDA.fraPathImpDDAedtDirectoryChange(Sender: TObject);
begin
  //#Asimov#
  fraPathImpDDAPropertiesChange(Sender);
end;

procedure TfrmCtaImpDDA.fraPathImpDDAedtDirectoryExit(Sender: TObject);
begin
  //#Asimov#
  fraPathImpDDAFocusChanged(Sender);
end;

procedure TfrmCtaImpDDA.fraPathImpDDAedtDirectoryEnter(Sender: TObject);
begin
  //#Asimov#
  fraPathImpDDAFocusChanged(Sender);
end;

end.
