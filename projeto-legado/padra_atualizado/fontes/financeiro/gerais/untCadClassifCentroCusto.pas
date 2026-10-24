unit untCadClassifCentroCusto;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, DBCtrls, DBEditFocus, untClasseBalanceteFinanceiro,
  DB, ComboBoxFocus, BitBtnLockedIncrem, Mask, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadClassifCentroCusto = class(TfrmPaiCad)
    pnl1: TPanel;
    dbeCodigo: TDBEditFocus;
    lbl1: TLabel;
    dbeDescri: TDBEditFocus;
    lbl2: TLabel;
    dbeClaRe1: TDBEditFocus;
    lbl3: TLabel;
    lbl4: TLabel;
    dbeClaRe2: TDBEditFocus;
    lbl5: TLabel;
    dbeClaRe3: TDBEditFocus;
    dtsClaCCu: TDataSource;
    lbl6: TLabel;
    edtTipOpe: TComboBoxFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
     objClaCCu: TCadClaCCu;
    procedure pAtuTipOpe(DataSet: TDataSet);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;


implementation

uses SysUtils, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadClassifCentroCusto }

procedure TfrmCadClassifCentroCusto.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodigo.Enabled := False;
  If dbeDescri.Enabled Then
    pSetFocus(dbeDescri);
end;

procedure TfrmCadClassifCentroCusto.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadClassifCentroCusto.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadClassifCentroCusto.btnGravarClick(Sender: TObject);
begin
  If fValidacoesBotaoGravarPai Then
  Begin
    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
    qryTabela.FieldByName('CCC_TIPOPE').AsInteger := edtTipOpe.ItemIndex + 1;

    Try
      inherited;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmCadClassifCentroCusto.btnGravarClick]');
      End;
    End;

    If blnGravou Then
      fCommit
    Else
      fRollBack;
  End;
end;

procedure TfrmCadClassifCentroCusto.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);
  qryTabela.FieldByName('CCC_CODEMP').AsString := VS_strCodEmp;
end;

procedure TfrmCadClassifCentroCusto.btnPesquisaClick(Sender: TObject);
  Var
    arrSel : TConsultasArray;
    chrKey : Char;
begin

  chrKey := '/';

  If fPesqClaCentCus(Self, dbeCodigo, qryTabela, chrKey, arrSel) Then
  Begin
    If (btnAlterar.Enabled) And (btnAlterar.Visible) Then
      pSetFocus(btnAlterar);
  End;

end;

procedure TfrmCadClassifCentroCusto.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadClassifCentroCusto.FormCreate(Sender: TObject);
begin
  objClaCCu := TCadClaCCu.Create(Self);
  inherited;
  strNomeTabela := 'CADCCC';
  strNomeCampo  := 'CCC_CODIGO';
  qryTabela     := objClaCCu.qryClaCCu;

  qryTabela.AfterScroll := pAtuTipOpe;

  dtsClaCCu.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

function TfrmCadClassifCentroCusto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    Try

      If (Sender = dbeCodigo) Then
      Begin
        If dbeCodigo.Enabled Then
          objClaCCu.strCodCCu := dbeCodigo.Text;

        If blnBuscaPorChave Then
        Begin
          If Not fBuscaPorCamposChave Then
          Begin
            pLimparCampos;
          End
          Else
          Begin
            dbeCodigo.Enabled := False;
            If dbeDescri.Enabled Then
            Begin
              pSetFocus(dbeDescri);
              blnMudarFoco := False;
            End;
          End;
        End

      End

      Else If (Sender = dbeDescri) Then
      Begin

        If fEmptyStr(dbeDescri.Text) Then
        Begin
          fMensagem('', 'A Descrição deve ser preenchida!', ['&Ok']);
          Result := False;
        End;

      End

    Except
      On E: Exception Do
      Begin
        fMensagem('',E.Message,['&OK']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadClassifCentroCusto.pAtuTipOpe(DataSet: TDataSet);
begin
  edtTipOpe.ItemIndex := qryTabela.FieldByName('CCC_TIPOPE').AsInteger - 1;
end;

procedure TfrmCadClassifCentroCusto.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CCC_CODIGO');
  stlCampos.Add('CCC_DESCRI');
  stlCampos.Add('CCC_DESRE1');
  stlCampos.Add('CCC_DESRE2');
  stlCampos.Add('CCC_DESRE3');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CCC_DESCRI');
  stlCamInd.Add('CCC_CODIGO');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

end.
