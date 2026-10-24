unit untCadEpi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Data.DB, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Jpeg;

type
  TfrmCadEpi = class(TfrmPaiCad)
    dtsCadEpi: TDataSource;
    pnlCentral: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDescri: TDBEditFocus;
    dbeCodEpi: TDBEditFocus;
    btnCarregaImagem: TBitBtnLocked;
    btnRemoveImagem: TBitBtnLocked;
    OpenDialogJpeg: TOpenDialog;
    pnlImagem: TPanel;
    imgEpi: TImage;
    procedure FormCreate(Sender: TObject);
    procedure btnCarregaImagemClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnRemoveImagemClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
  private
    procedure pCarregaDadosAdicionais;
  public

  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pOnStateChange; override;
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples, untImagemBase64, untTypesSistema, untConsultas;

procedure TfrmCadEpi.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaDadosAdicionais;
end;

procedure TfrmCadEpi.btnCarregaImagemClick(Sender: TObject);
begin
  inherited;
  Try
    If OpenDialogJpeg.Execute Then
    Begin
      imgEpi.Picture.LoadFromFile(OpenDialogJpeg.FileName);
      qryTabela.FieldByName('EPI_IMGEPI').AsString := fBase64FromIMG(TJpegImage(imgEpi.Picture.Graphic));
    End;
  Except
    On E : Exception Do
      pMensagensErro('Ocorreu um err ao carregar a imagem!' + #13 + 'Carregue uma imagem da extensão JPG.' + #13 + e.Message, '');
  End;
end;

procedure TfrmCadEpi.btnRemoveImagemClick(Sender: TObject);
begin
  inherited;
  imgEpi.Picture := Nil;
  qryTabela.FieldByName('EPI_IMGEPI').Clear;
end;

procedure TfrmCadEpi.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadEpi.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pCarregaDadosAdicionais;
end;

procedure TfrmCadEpi.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadEpi.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadEpi.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodEpi, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodEpi, dbeDescri, True);

  pCarregaDadosAdicionais;
end;

procedure TfrmCadEpi.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
begin
  inherited;
  chrKey := '/';
  If fPesqEPI(Self, dbeCodEpi, dbeDescri, qryTabela, chrKey, arrSel) Then
  Begin
    pCarregaDadosAdicionais;
  End;
end;

procedure TfrmCadEpi.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADEPI';
  strNomeCampo      := 'EPI_CODEPI';
  qryTabela         := fCriarQuery('SELECT * FROM CADEPI', Self);
  dtsCadEpi.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodEpi;
end;

function TfrmCadEpi.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = dbeCodEpi) Then
  Begin

    If (fEmptyStr(dbeCodEpi.Text)) And (dbeCodEpi.Enabled) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Código do EPI deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (blnBuscaPorChave) Then
    Begin
      If Not fBuscaPorCamposChave Then
        pLimparCampos;
    End;

  End
  Else If (Sender = dbeDescri) Then
  Begin

    If fEmptyStr(dbeDescri.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Descrição do EPI deve ser preenchida!', ['&Ok']);
      Result := False;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);


end;

procedure TfrmCadEpi.pCarregaDadosAdicionais;
var
  picImagem : TPicture;
begin
  Try
    imgEpi.Picture := Nil;
    If (qryTabela.FieldByName('EPI_IMGEPI').AsString <> '') Then
    begin
      picImagem := TPicture.Create;
      try
        pImagemFromBase64(qryTabela.FieldByName('EPI_IMGEPI').AsString, picImagem);
        imgEpi.Picture := picImagem;
      finally
        FreeAndNil(picImagem);
      end;
    end;
  Except
    On E : Exception Do
      pMensagensErro(E.Message, '');
  End;
end;

procedure TfrmCadEpi.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('EPI_CODEPI');
  stlCampos.Add('EPI_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('EPI_DESCRI');
  stlCamInd.Add('EPI_CODEPI');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');

end;

procedure TfrmCadEpi.pOnStateChange;
begin
  inherited;
  btnCarregaImagem.Enabled := (qryTabela.State In dsEditModes);
  btnRemoveImagem.Enabled  := (qryTabela.State In dsEditModes);
end;

end.
