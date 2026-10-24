unit untCadMotVendasPerdidas;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, DBEditFocus, untCadMotVenPer, DB,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadMotVendasPerdidas = class(TfrmPaiCad)
    pnl1: TPanel;
    dbeCodMot: TDBEditFocus;
    dbeDesMot: TDBEditFocus;
    lbl1: TLabel;
    lbl2: TLabel;
    dtsCadMot: TDataSource;
    dbeConPed: TDBCheckBox;
    dbeInfCon: TDBCheckBox;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
     objCadMot: TCadMotVenPer;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  end;


implementation

uses SysUtils, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadMotVendasPerdidas }

procedure TfrmCadMotVendasPerdidas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodMot.Enabled := False;
  pSetFocus(dbeDesMot);
end;

procedure TfrmCadMotVendasPerdidas.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadMotVendasPerdidasS.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadMotVendasPerdidas.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[untCadMotVendasPerdidas.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadMotVendasPerdidas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodMot, dbeDesMot, False)
  Else
    pHabilitaCodigo(dbeCodMot, dbeCodMot, True);

  qryTabela.FieldByName('MOT_CONPED').AsString := 'S';
  qryTabela.FieldByName('MOT_INFCON').AsString := 'N';
end;

procedure TfrmCadMotVendasPerdidas.btnPesquisaClick(Sender: TObject);
Var
  chrKey   : Char;
  arrCodMot: TConsultasArray;
begin
  chrKey := '/';
  If fPesqMotVendasPerdidas(Self, Nil, Nil, qryTabela, chrKey, arrCodMot) Then
    If (btnAlterar.Enabled) And (btnAlterar.Visible) Then
      pSetFocus(btnAlterar);
end;

procedure TfrmCadMotVendasPerdidas.FormCreate(Sender: TObject);
begin
  objCadMot         := TCadMotVenPer.Create(Self);
  inherited;
  strNomeTabela     := 'MOTVPD';
  strNomeCampo      := 'MOT_CODMOT';
  qryTabela         := objCadMot.qryTabela;
  dtsCadMot.DataSet := qryTabela;
end;

function TfrmCadMotVendasPerdidas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    Try

      If (Sender = dbeCodMot) Then
      Begin
        If dbeCodMot.Enabled Then
          objCadMot.strCodMot := dbeCodMot.Text;

        If blnBuscaPorChave Then
        Begin
          If Not fBuscaPorCamposChave Then
          Begin
            pLimparCampos;
          End
          Else
          Begin
            dbeCodMot.Enabled := False;
            If dbeDesMot.Enabled Then
            Begin
              pSetFocus(dbeDesMot);
              blnMudarFoco := False;
            End;
          End;
        End

      End

      Else If (Sender = dbeDesMot) Then
      Begin
        objCadMot.strDesMot := dbeDesMot.Text;
      End

    Except
      On E: Exception Do
      Begin
        fMensagem('',E.Message,['&OK']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadMotVendasPerdidas.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('MOT_DESMOT');
  stlCampos.Add('MOT_DESMOT');

  stlCamInd.Add('MOT_DESMOT');
  stlCamInd.Add('MOT_CODMOT');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

end.

