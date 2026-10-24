unit untCadTemperaturaAtendimento;

interface

uses
  Windows, Classes, Controls, untPaiCad, StdCtrls, Mask, DBCtrls, DBEditFocus,
  AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls, DB, Uni, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, SysUtils, Forms, EditFocus, Vcl.Dialogs,
  Vcl.Graphics;

type
  TfrmCadTempAtendimentoCRM = class(TfrmPaiCad)
    pnlFundo: TPanel;
    dbeCodigo: TDBEditFocus;
    lblCodigo: TLabel;
    lblDescricao: TLabel;
    dbeDescri: TDBEditFocus;
    cldCores: TColorDialog;
    lblSelCor: TLabel;
    dbeCorAdt: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure lblSelCorClick(Sender: TObject);
    procedure dbeCorAdtChange(Sender: TObject);
  private
    dtsDados: TDataSource;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure dtsDadosDataChange(Sender: TObject; Field: TField);
  public
    { Public declarations }
  end;

implementation

uses
  untPai, untConsultas, untFuncoesSimples, untTypesSistema;

{$R *.dfm}

procedure TfrmCadTempAtendimentoCRM.FormCreate(Sender: TObject);
  Var
    intCont: Integer;
begin
  inherited;

  strNomeTabela := 'CADTEA';
  strNomeCampo  := 'TEA_CODIGO';
  qryTabela     := fCriarQuery('SELECT * FROM CADTEA', Self);

  dtsDados  := fCriaDataSource(qryTabela);
  dtsDados.OnDataChange := dtsDadosDataChange;

  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsDados;
    End
    Else If (Components[intCont] is TDBCheckBox) Then
    Begin
      (Components[intCont] as TDBCheckBox).DataSource := dtsDados;
    End;
  End;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;


function TfrmCadTempAtendimentoCRM.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
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
        fMensagem('ATENÇÃO!', 'A descrição deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadTempAtendimentoCRM.lblSelCorClick(Sender: TObject);
begin
  inherited;

  If Not (qryTabela.State in dsEditModes) Then
    Exit;

  cldCores.Color := StrToIntDef(TDBEditFocus(TLabel(Sender).FocusControl).Field.AsString,0);

  If (cldCores.Execute) Then
    TDBEditFocus(TLabel(Sender).FocusControl).Field.AsString := IntToStr(cldCores.Color);
end;

procedure TfrmCadTempAtendimentoCRM.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('TEA_CODIGO');
  stlCampos.Add('TEA_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('TEA_DESCRI');
  stlCamInd.Add('TEA_CODIGO');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmCadTempAtendimentoCRM.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadTempAtendimentoCRM.btnGravarClick(Sender: TObject);
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
      pMensagensErro(E.Message, '[btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadTempAtendimentoCRM.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

end;

procedure TfrmCadTempAtendimentoCRM.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrSel: TConsultasArray;
begin
  chrKey := '/';
  If fPesqTempAtndCRM(Self, Nil, Nil, qryTabela, chrKey, arrSel) Then
  Begin
    pSetFocus(btnAlterar);
  End;

end;

procedure TfrmCadTempAtendimentoCRM.dbeCorAdtChange(Sender: TObject);
Var
  strColor : String;
begin
  inherited;

  If qryTabela.IsEmpty Then
    Exit;

  If TDBEditFocus(Sender).Field = Nil Then
    Exit;

  strColor := TDBEditFocus(Sender).Field.AsString;

  If not fEmptyStr(strColor) Then
  Begin
    TDBEditFocus(Sender).Color       := StrToIntDef(strColor,0);
    TDBEditFocus(Sender).NormalColor := StrToIntDef(strColor,0);
    TDBEditFocus(Sender).FocusColor  := StrToIntDef(strColor,0);
    TDBEditFocus(Sender).Font.Color  := StrToIntDef(strColor,0);
  End
  Else
  Begin
    TDBEditFocus(Sender).Color       := clWindow;
    TDBEditFocus(Sender).NormalColor := clWindow;
    TDBEditFocus(Sender).FocusColor  := clWindow;
    TDBEditFocus(Sender).Font.Color  := clBlack;
  End;
end;

procedure TfrmCadTempAtendimentoCRM.dtsDadosDataChange(Sender: TObject; Field: TField);
begin

  If Field = dbeCorAdt.Field Then
    dbeCorAdtChange(dbeCorAdt);
end;

procedure TfrmCadTempAtendimentoCRM.btnAlterarClick(Sender: TObject);
begin
  inherited;

  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
end;

end.
