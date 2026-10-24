unit untCadOriFgo;

interface

uses
  Windows, Controls, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, Classes,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, Uni, DB, EditFocus, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, untDBECgcCpf, untLabelCgc, QColorLabel, SysUtils;

type
  TfrmCadOriFgo = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodOri: TDBEditFocus;
    Label2: TLabel;
    dbeDesOri: TDBEditFocus;
    LabelCgc1: TLabelCgc;
    dbeC_G_C_: TDBEditCgcCpf;
    lblNomFan: TLabel;
    dbeIdenti: TDBEditFocus;
    Label29: TLabel;
    dbeCanOri: TDBEditFocus;
    ColorLabel4: TColorLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    qryOriFgo: TUniQuery;
    dtsOriFgo: TDataSource;
    procedure pCriaDataSets;
    procedure pLigaDataSets;
    procedure pAfterScrool(DataSet: TDataSet);
    procedure pAfterOpen(DataSet: TDataSet);
    { Private declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadOriFgo: TfrmCadOriFgo;

implementation

uses Variants, Forms, untFuncoesSimples, untConsultas, untTypesSistema, untFuncoesGenerica;

{$R *.dfm}

{ TfrmCadOriFgo }

procedure TfrmCadOriFgo.pCriaDataSets;
begin
  qryOriFgo := fCriarQuery('SELECT * FROM ORIFGO', Self);

  qryOriFgo.FieldByName('ORI_CODORI').DisplayLabel := 'Código';
  qryOriFgo.FieldbyName('ORI_DESORI').DisplayLabel := 'Descrição';

  qryOriFgo.FieldbyName('ORI_CANORI').Visible := False;
  qryOriFgo.FieldByName('ORI_C_G_C_').Visible := False;
  qryOriFgo.FieldByName('ORI_IDENTI').Visible := False;
  qryOriFgo.FieldByName('AUTOINCREM').Visible := False;

  dtsOriFgo := fCriaDataSource(qryOriFgo);

  qryOriFgo.AfterScroll := pAfterScrool;
  qryOriFgo.AfterOpen := pAfterOpen;
end;

procedure TfrmCadOriFgo.pLigaDataSets;
  Var
    intCont: Integer;
begin
  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsOriFgo;
    End;
  End;

  qryTabela := qryOriFgo;
  strNomeTabela := 'ORIFGO';
  strNomeCampo  := 'ORI_CODORI';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodOri;
end;

procedure TfrmCadOriFgo.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;
end;

function TfrmCadOriFgo.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If Sender = dbeDesOri Then
    Begin
      If fEmptyStr(dbeDesOri.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO', 'A descrição deve ser preenchida!', ['OK']);
      End;
    End
    Else If (Sender = dbeC_G_C_) Then
    Begin
      If Not fEmptyStr(dbeC_G_C_.Text) Then
      Begin
        If Not fTestaCgc(dbeC_G_C_.Text) Then
        Begin
          fMensagem('ATENÇÃO', dbeC_G_C_.Text + ' não é um Número de CNPJ válido!', ['&Ok']);
          Result := False;
        End;
      End
      Else If Not (fEmptyStr(dbeIdenti.Text)) And (Not blnBuscaPorChave) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO', 'O CNPJ do Intermediador deve ser informado!', ['OK']);
      End;
    End
    Else If (Sender = dbeIdenti) Then
    Begin
      If fEmptyStr(dbeIdenti.Text) And Not fEmptyStr(dbeC_G_C_.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO', 'A Razão Social do Intermediador deve ser informada!', ['OK']);
      End;
    End
    Else If (Sender = dbeCanOri) Then
    Begin
      If (Pos(dbeCanOri.Text, 'SN') <= 0) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO', 'Permite Cancelamento do Pedido deve ser S ou N!', ['OK']);
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadOriFgo.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('ORI_CODORI');
  stlCampos.Add('ORI_DESORI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('ORI_DESORI');
  stlCamInd.Add('ORI_CODORI');
  stlCamInd.Add('AUTOINCREM');
  
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmCadOriFgo.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadOriFgo.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadOriFgo.btnGravarClick(Sender: TObject);
begin


  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    dbeC_G_C_.Field.AsString := fTiraCaracEspeciais(dbeC_G_C_.Field.AsString,
    True, True, True, True, True, True);
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadOriFgo.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadOriFgo.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeDesOri);
  dbeCanOri.Field.AsString := 'N';
end;

procedure TfrmCadOriFgo.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrOrigem: TConsultasArray;
begin
  chrKey := '/';
  If fPesqOrigemPedidoVenda(Self, Nil, Nil, qryTabela, chrKey, arrOrigem) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadOriFgo.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeDesOri);
end;

procedure TfrmCadOriFgo.pAfterOpen(DataSet: TDataSet);
begin
  TStringField(DataSet.FieldByName('ORI_C_G_C_')).EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_);
end;

procedure TfrmCadOriFgo.pAfterScrool(DataSet: TDataSet);
begin
 //do something
end;

end.
