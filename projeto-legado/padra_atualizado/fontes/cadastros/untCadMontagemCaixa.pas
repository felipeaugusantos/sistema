unit untCadMontagemCaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB, Uni;

type
  TfrmCadMontagemCaixa = class(TfrmPaiCad)
    Panel1: TPanel;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    Label2: TLabel;
    dbeDescri: TDBEditFocus;
    Label3: TLabel;
    dbeAltura: TDBEditFocus;
    Label4: TLabel;
    dbeLargur: TDBEditFocus;
    Label5: TLabel;
    dbeProfun: TDBEditFocus;
    dtsMntCxa: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    qryMntCxa: TUniQuery;
    procedure pAfterOpen(DataSet: TDataSet);

  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema, untPesqAux;

{$R *.dfm}

{ TfrmCadMontagemCaixa }

procedure TfrmCadMontagemCaixa.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
end;

procedure TfrmCadMontagemCaixa.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadMontagemCaixa.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadMontagemCaixa.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadMontagemCaixa.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadMontagemCaixa.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);

  dbeAltura.Field.AsFloat  := 0;
  dbeLargur.Field.AsFloat  := 0;
  dbeProfun.Field.AsFloat  := 0;
end;

procedure TfrmCadMontagemCaixa.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrMontagemCaixa: TConsultasArray;
begin
  chrKey := '/';
  If fPesqMontagemCaixa(Self, Nil, Nil, qryTabela, chrKey, arrMontagemCaixa) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadMontagemCaixa.FormCreate(Sender: TObject);
var
  strSQL: String;
begin
  inherited;
  strNomeTabela     := 'MNTCXA';
  strNomeCampo      := 'MCX_CODIGO';

  strSQL            := 'SELECT * FROM MNTCXA';
  qryMntCxa         := fCriarQuery(strSQL, Self);
  qryTabela         := qryMntCxa;
  dtsMntCxa.DataSet := qryTabela;

  qryTabela.AfterOpen := pAfterOpen;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadMontagemCaixa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: If ActiveControl Is TRadioButton Then
               Begin
                 Key := 0;
                 SelectNext(ActiveControl, True, True);
               end;
  End;
end;

function TfrmCadMontagemCaixa.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = dbeCodigo) Then
  Begin
    If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
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
      fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeAltura) Then
  Begin
    If (StrToFloatDef(dbeAltura.Text, 0) = 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Altura deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeLargur) Then
  Begin
    If (StrToFloatDef(dbeLargur.Text, 0) = 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Largura deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeProfun) Then
  Begin
    If (StrToFloatDef(dbeProfun.Text, 0) = 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Profundidade deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadMontagemCaixa.pAfterOpen(DataSet: TDataSet);
begin
  TFloatField(qryTabela.FieldByName('MCX_ALTURA')).DisplayFormat := ',0.00';
  TFloatField(qryTabela.FieldByName('MCX_LARGUR')).DisplayFormat := ',0.00';
  TFloatField(qryTabela.FieldByName('MCX_PROFUN')).DisplayFormat := ',0.00';
end;

procedure TfrmCadMontagemCaixa.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('MCX_CODIGO');
  stlCampos.Add('MCX_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('MCX_DESCRI');
  stlCamInd.Add('MCX_CODIGO');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

end.
