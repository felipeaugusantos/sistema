unit untCadAjustes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, StdCtrls, ExtCtrls, DBCtrls, Mask, DBEditFocus, AppEvnts,
  Menus, ComCtrls, Buttons, BitBtnLockedIncrem, ComboBoxFocus, DB,
  DBComboBoxFocus, frxClass, frxExportCSVTestabilidade, Uni,
  DBLookupComboBoxFocus, UniClientDataSet;

type
  TfrmCadAjustes = class(TfrmPaiCad)
    pnlFundo: TPanel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    dbeDesAju: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    dtsAjuste: TDataSource;
    rdgDestino: TDBRadioGroup;
    dblTipAju: TDBLookupComboBoxFocus;
    dtsTipAju: TDataSource;
    labelEnvApIcms: TLabel;
    chkEnviaResumoApICMS: TDBCheckBox;
    chkEnviaResumoSuICMS: TDBCheckBox;
    Label4: TLabel;
    dbeCodSub: TDBEditFocus;
    lblCodSub: TLabel;
    chkInfObr: TDBCheckBox;
    Label5: TLabel;
    dblObrRec: TDBLookupComboBoxFocus;
    dtsObrRec: TDataSource;
    procedure btnIncluirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dbeCodigoChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure chkEnviaResumoSuICMSClick(Sender: TObject);
  private
    { Private declarations }
    cdsTipAju : TUniClientDataSet;
    cdsObrRec : TUniClientDataSet;
    procedure pCriaTipAju();
    procedure pPopulaTipAju();
    procedure pCriaObrRec;
    procedure pPopulaObrRec;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;    
  public
    { Public declarations }
  end;

implementation

uses untFuncoes, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadAjustes.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeCodigo);

  If blnAlterou Then
  Begin
    dblTipAju.Enabled := True;
    chkEnviaResumoApICMS.Enabled := True;
    chkEnviaResumoSuICMS.Enabled := True;
  End;
end;

procedure TfrmCadAjustes.btnCancelaClick(Sender: TObject);
begin
  inherited;
  dblTipAju.Enabled := False;
  chkEnviaResumoApICMS.Enabled := False;
  chkEnviaResumoSuICMS.Enabled := False;
  dbeCodSub.Visible := chkEnviaResumoSuICMS.Checked;
  lblCodSub.Visible := chkEnviaResumoSuICMS.Checked;
end;

procedure TfrmCadAjustes.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadAjustes.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
  Begin
    fCommit;
    dbeCodSub.Visible := chkEnviaResumoSuICMS.Checked;
    lblCodSub.Visible := chkEnviaResumoSuICMS.Checked;
  End
  Else
    fRollBack;
end;

procedure TfrmCadAjustes.btnGravarClick(Sender: TObject);
begin
  qryTabela.FieldByName('AJU_DESTAJ').AsString := 'E';

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadAjustes.btnGravarClick]');
    End;
  End;

  If blnGravou Then
  Begin
    fCommit;
    dblTipAju.Enabled := False;
    chkEnviaResumoApICMS.Enabled := False;
    chkEnviaResumoSuICMS.Enabled := False;
  End
  Else
    fRollBack;
end;

procedure TfrmCadAjustes.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeCodigo);

  //rdgDestino.ItemIndex := 1;
  //rdgDestino.Field.AsString := 'E';
  dblTipAju.Enabled := True;
  chkEnviaResumoApICMS.Enabled := True;
  chkEnviaResumoApICMS.Checked := True;
  chkEnviaResumoSuICMS.Enabled := True;
  chkEnviaResumoSuICMS.Checked := False;
  dbeCodSub.Visible := chkEnviaResumoSuICMS.Checked;
  lblCodSub.Visible := chkEnviaResumoSuICMS.Checked;
end;

procedure TfrmCadAjustes.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrAjus: TConsultasArray;
begin
  chrKey := '/';
  If fPesqAju(Self, Nil, Nil, qryTabela, chrKey, arrAjus) Then
  Begin
    pSetFocus(btnAlterar);
    dbeCodSub.Visible := chkEnviaResumoSuICMS.Checked;
    lblCodSub.Visible := chkEnviaResumoSuICMS.Checked;
  End;
end;

procedure TfrmCadAjustes.chkEnviaResumoSuICMSClick(Sender: TObject);
begin
  inherited;
  dbeCodSub.Visible := chkEnviaResumoSuICMS.Checked;
  lblCodSub.Visible := chkEnviaResumoSuICMS.Checked;
end;

procedure TfrmCadAjustes.dbeCodigoChange(Sender: TObject);
begin
  inherited;
  If qryTabela.State In [dsEdit, dsInsert] Then
  Begin
    qryTabela.FieldByName('AJU_TIPAJU').AsInteger := StrToIntDef(Copy(dbeCodigo.Text, 4, 1), -1);
  End;
end;

procedure TfrmCadAjustes.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadAjustes.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'AJUSTE';
  strNomeCampo      := 'AJU_CODAJU';

  qryTabela         := fCriarQuery('SELECT * FROM AJUSTE WHERE FALSE', Self);
  dtsAjuste.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  pCriaTipAju();
  pPopulaTipAju();

  dtsTipAju.DataSet := cdsTipAju;

  pCriaObrRec();
  pPopulaObrRec();

  dtsObrRec.DataSet := cdsObrRec;
end;

procedure TfrmCadAjustes.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsTipAju);
  FreeAndNil(cdsObrRec);
  inherited;
end;

procedure TfrmCadAjustes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
//  If (Key = VK_RETURN) And (ActiveControl.Parent = rdgDestino) Then
//  Begin
//    SelectNext(ActiveControl,True,True);
//  End;
end;

procedure TfrmCadAjustes.FormShow(Sender: TObject);
begin
  inherited;
  dblTipAju.Enabled := False;
  chkEnviaResumoApICMS.Enabled := False;
  chkEnviaResumoSuICMS.Enabled := False;
end;

function TfrmCadAjustes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do ajuste deve ser preenchido!', ['&Ok']);
        Result := False;
      End
    End

    Else If (Sender = dbeDesAju) Then
    Begin

      If (fEmptyStr(dbeDesAju.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição do ajuste deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dblTipAju) Then
    Begin
      If fEmptyStr(dblTipAju.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Tipo do ajuste deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If StrToIntDef(Copy(dbeCodigo.Text, 4, 1), -1) <> dblTipAju.KeyValue Then
      Begin
        If fMensagem('', 'Tipo não está de acordo com o 4º dígito do Código do Ajuste. Deseja continuar?', ['&Sim', '&Não']) = 2 Then
          Result := False;
      End;
      {Else
      Begin
        If blnBuscaPorChave And rdgDestino.Enabled Then
        Begin
          blnMudarFoco := False;
          pSetFocus(TRadioButton(rdgDestino.Components[rdgDestino.ItemIndex]));
        End;
      End;}
    End

    Else If Sender = dblObrRec Then
    Begin
      If (chkInfObr.Checked) and fEmptyStr(dblObrRec.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'É necessário informar um código de obrigação a recolher!', ['&Ok']);
        Result := False;
      End;
    End;

    {Else If (Sender = rdgDestino) Then
    Begin
      If rdgdestino.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO', 'O Destino do ajuste deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End }

  End;

  If Not Result Then
  Begin
    pSetFocus(Sender);
  End;
end;

procedure TfrmCadAjustes.pCriaTipAju();
begin
  cdsTipAju := TUniClientDataSet.Create(Self);

  With cdsTipAju.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODTIP';
    DataType := ftString;
    Size     := 1;
  End;

  With cdsTipAju.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESTIP';
    DataType := ftString;
    Size     := 50;
  End;

  cdsTipAju.CreateDataSet;
  cdsTipAju.IndexFieldNames := 'CODTIP';
  cdsTipAju.LogChanges := False;
end;

procedure TfrmCadAjustes.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('AJU_CODAJU');
  stlCampos.Add('AJU_DESAJU');
  stlCampos.Add('AJU_TIPAJU');
//  stlCampos.Add('AJU_DESTAJ');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('AJU_CODAJU');
  stlCamInd.Add('AJU_DESAJU');
  stlCamInd.Add('AJU_TIPAJU');
//  stlCamInd.Add('AJU_DESTAJ');
  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Tipo');
//  stlDesInd.Add('Destino');
end;

procedure TfrmCadAjustes.pPopulaTipAju();

  procedure pInsert(strCodTip, strDesTip: String);
  begin
    cdsTipAju.Insert;
    cdsTipAju.FieldByName('CODTIP').AsString := strCodTip;
    cdsTipAju.FieldByName('DESTIP').AsString := strDesTip;
    cdsTipAju.Post;
  end;

begin
  pInsert('0', '0 - OUTROS DÉBITOS');
  pInsert('1', '1 - ESTORNO DE CRÉDITOS');
  pInsert('2', '2 - OUTROS CRÉDITOS');
  pInsert('3', '3 - ESTORNO DE DÉBITOS');
  pInsert('4', '4 - DEDUÇÕES DO IMPOSTO APURADO');
  pInsert('5', '5 - DÉBITOS ESPECIAIS');
end;

procedure TfrmCadAjustes.pCriaObrRec();
begin
  cdsObrRec := TUniClientDataSet.Create(Self);

  With cdsObrRec.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODOBR';
    DataType := ftString;
    Size     := 3;
  End;

  With cdsObrRec.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DESOBR';
    DataType := ftString;
    Size     := 255;
  End;

  cdsObrRec.CreateDataSet;
  cdsObrRec.IndexFieldNames := 'CODOBR';
  cdsObrRec.LogChanges := False;
end;

procedure TfrmCadAjustes.pPopulaObrRec();

  procedure pInsert(strCodObr, strDesObr: String);
  begin
    cdsObrRec.Insert;
    cdsObrRec.FieldByName('CODOBR').AsString := strCodObr;
    cdsObrRec.FieldByName('DESOBR').AsString := strDesObr;
    cdsObrRec.Post;
  end;

begin
  pInsert('000', '000 - ICMS a recolher');
  pInsert('001', '001 - ICMS da substituição tributária pelas entradas');
  pInsert('002', '002 - ICMS da substituição tributária pelas saídas para o Estado');
  pInsert('003', '003 - Antecipação do diferencial de alíquotas do ICMS');
  pInsert('004', '004 - Antecipação do ICMS da importação');
  pInsert('005', '005 - Antecipação tributária');
  pInsert('006', '006 - ICMS resultante da alíquota adicional dos itens incluídos no Fundo de Combate à Pobreza');
  pInsert('090', '090 - Outras obrigações do ICMS');
  pInsert('999', '999 - ICMS da substituição tributária pelas saídas para outro Estado');
end;

end.
