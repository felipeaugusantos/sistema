unit untCadTimeFutebol;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, DB, DBCtrls, DBEditFocus, BitBtnLockedIncrem, Mask,
  frxClass, frxExportCSVTestabilidade, SysUtils;

type
  TfrmCadTimeFutebol = class(TfrmPaiCad)
    pnlDados: TPanel;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDesTfu: TDBEditFocus;
    Label2: TLabel;
    dtsCadTfu: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadTimeFutebol.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDesTfu, False);
end;

procedure TfrmCadTimeFutebol.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadTimeFutebol.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadTimeFutebol.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadTimeFutebol.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadTimeFutebol.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDesTfu, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);
end;

procedure TfrmCadTimeFutebol.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrCargo: TConsultasArray;
begin
  {*************************************}
  {* NOVA CONSULTA DE TIMES DE FUTEBOL *}
  {**********************************AC*}
  chrKey := '/';
  If fPesqTimesFutebolCliCon(Self, Nil, Nil, qryTabela, chrKey, arrCargo) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadTimeFutebol.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADTFU';
  strNomeCampo      := 'TFU_CODTFU';
  qryTabela         := fCriarQuery('SELECT * FROM CADTFU', Self);
  dtsCadTfu.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadTimeFutebol.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
end;

procedure TfrmCadTimeFutebol.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('TFU_CODTFU');
  stlCampos.Add('TFU_DESTFU');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('TFU_DESTFU');
  stlCamInd.Add('TFU_CODTFU');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código Time');
end;

function TfrmCadTimeFutebol.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

 Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Time deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    Else
    If (Sender = dbeDesTfu) Then
    Begin
      If fEmptyStr(dbeDesTfu.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição do Time deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;


end.

