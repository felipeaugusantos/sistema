unit untCadPpgBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Uni, DB, Mask, DBCtrls, DBEditFocus, EditFocus, untTypesSistema,
  BitBtnLockedIncrem, untFuncoesSimples, frxClass, frxExportCSVTestabilidade;


type
  TfrmCadPpgBase = class(TfrmPaiCad)
    pnlFundo: TPanel;
    btnRestPreco: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label5: TLabel;
    Label9: TLabel;
    dbeCodBas: TDBEditFocus;
    dbeCodIte: TDBEditFocus;
    dbeDesBas: TDBEditFocus;
    dbePesEsp: TDBEditFocus;
    dbeTipo: TDBEditFocus;
    dbePCusto: TDBEditFocus;
    dbePMargem: TDBEditFocus;
    dbeEmbalagem: TDBEditFocus;
    dbePVenda: TDBEditFocus;
    edtDesIte: TEditFocus;
    dbeBasePo: TDBCheckBox;
    btnBasEmp: TBitBtnLocked;
    pnlCabecalho: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure dbeTipoKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnRestPrecoClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure dbeCodIteExit(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbeBasePoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnBasEmpClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    arrOpcoesTipo: TStringArray;
    qryCadBas: TUniQuery;
    dtsCadBas: TDataSource;
    StrCodIteAnt : String;
    procedure pCriaDataSets;
    procedure pLigaDataSets;
    procedure pCarregaIte;
    function fRetPrecoVenda(intOpcao: Integer): Double;
    procedure pHabilitaBtn;
    procedure pGetEscolhas(var escolhas: TStringArray);
    procedure pHabilitaBtnBasEmp;
    procedure pBasesPorEmpresas;
  public
    { Public declarations }
  protected
    procedure pUpdateFatorTintometrico;
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pCamposReadOnlyPaintManager;
  end;

var
  frmCadPpgBase: TfrmCadPpgBase;

implementation

 uses  untFuncTinta,
       untIConfTinta, untCadPPGBasesEmp, untConsultas,
  untValidarBaseItemAmarracao;

{$R *.dfm}

procedure TfrmCadPpgBase.FormCreate(Sender: TObject);
begin
  inherited;
  pGetEscolhas(arrOpcoesTipo);

  pCriaDataSets;
  pLigaDataSets;

  qryTabela     := qryCadBas;
  strNomeTabela := 'PPG_CADBAS';
  strNomeCampo  := 'BAS_CODBAS';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodBas;
end;

procedure TfrmCadPpgBase.FormShow(Sender: TObject);
begin
  inherited;
  pHabilitaBtnBasEmp;
end;

procedure TfrmCadPpgBase.dbeTipoKeyPress(Sender: TObject; var Key: Char);
  Var
    intOpcao: Integer;
    conf: IConfTinta;
begin
  inherited;
  conf := fGetConfTinta('PPG');
  If (fEntraCons(Key)) And (Not conf.fGetBoolean('PAINTM')) Then
  Begin
    Key := #0;
    intOpcao := fGetMenu('Tipo de Bases', arrOpcoesTipo, 1, True);
    if intOpcao >= 0 then
      dbeTipo.Field.AsString := arrOpcoesTipo[intOpcao - 1];
  End;

end;

function TfrmCadPpgBase.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If Sender = dbeCodBas Then
    Begin
      If fEmptyStr(dbeCodBas.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Código da base deve ser preenchido!', ['OK']);
        Result := False;
      End;
    End

    Else If Sender = dbeDesBas Then
    Begin
      If fEmptyStr(dbeDesBas.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'A Descrição da base dese ver preencida!', ['OK']);
        Result := False;
      End;
    End

    Else If Sender = dbePesEsp Then
    Begin

      If  fEmptyStr(dbePesEsp.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O peso especifico deve ser preenchido!', ['OK']);
        Result := False ;
      End;

    End
    Else If Sender = dbeEmbalagem Then
    Begin
      If fEmptyStr(dbeEmbalagem.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'A embalagem deve ser preenchida!', ['OK']);
        Result := False;
      End
      Else If fStrToFloat(dbeEmbalagem.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'A Embalagem deve ser preenchida!', ['OK']);
        Result := False;
      End;
    End

    Else If Sender = dbeCodIte Then
    Begin

      pCarregaIte;
      If Not fEmptyStr(dbeCodIte.Text) Then
      Begin

        If fEmptyStr(edtDesIte.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse item não está Cadastrado!', ['OK']);
          Result := False;
        End

        Else If Not (fItemAtivo(dbeCodIte.Field.AsString)) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse item não está ativo!', ['OK']);
          Result := False;
        End;
      End;

    End
    Else If Not fEmptyStr(dbecodIte.Field.AsString) Then
    Begin

      If Sender = dbePCusto Then
      Begin

        If fEmptyStr(dbePCusto.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'O Preço de custo deve ser preenchido!', ['OK']);
          Result := False;
        End
        Else If fStrToFloat(dbePCusto.Text) <= 0Then
        Begin
          fMensagem('ATENÇÃO', 'O Preço de custo deve ser maior que zero', ['OK']);
          Result := False;
        End
        Else
          dbePVenda.Field.AsFloat := fRetPrecoVenda(1);
      End
      Else If Sender = dbePVenda Then
      Begin
        If fEmptyStr(dbePVenda.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'O Preço de venda deve ser preenchido!', ['OK']);
          Result := False;
        End
        Else If fStrToFloat(dbePVenda.Text) <= 0 Then
        Begin
          fMensagem('ATENÇÃO', 'O Preço de venda deve ser maior que zero!', ['OK']);
          Result := False;
        End
        Else
          dbePMargem.Field.AsFloat := fRetPrecoVenda(2);
      End
      Else If Sender = dbePMargem Then
      Begin
        If fEmptyStr(dbePMargem.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'A Margem deve ser preenchida!', ['OK']);
          Result := False;
        End
        Else If fStrToFloat(dbePMargem.Text) <= 0 Then
        Begin
          fMensagem('ATENÇÃO', 'A Margem deve ser maior que zero!', ['OK']);
          Result := False;
        End
        Else
          dbePVenda.Field.AsFloat := fRetPrecoVenda(1);
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadPpgBase.pInicializaIndices;
begin
  inherited;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('BAS_CODBAS+BAS_DESBAS');
  stlCamInd.Add('ITE_CODITE');
  stlCamInd.Add('ITE_DESITE+ITE_REFERE');

  stlDesInd.Add('Código/Descrição');
  stlDesInd.Add('Código do Item');
  stlDesInd.Add('Descrição do Item/Referência');
end;

procedure TfrmCadPpgBase.pCriaDataSets;
begin
  {**********************************}
  {* CRIA OS DATASETS DINAMICAMENTE *}
  {*******************************PH*}

  qryCadBas := fCriarQuery('SELECT * FROM PPG_CADBAS', Self);

  qryCadBas.FieldByName('BAS_CODBAS').DisplayLabel := 'Código';
  qryCadBas.FieldByName('BAS_CODITE').DisplayLabel := 'Código Item';
  qryCadBas.FieldByName('BAS_DESBAS').DisplayLabel := 'Descrição';
  qryCadBas.FieldByName('BAS_PESESP').DisplayLabel := 'Peso Especifico';
  qryCadBas.FieldByName('BAS_EMBALA').DisplayLabel := 'Embalagem';
  qryCadBas.FieldByName('BAS_TIPO__').DisplayLabel := 'Tipo';
  qryCadBas.FieldByName('BAS_PRECUS').DisplayLabel := 'Preço de custo';
  qryCadBas.FieldByName('BAS_MARGEM').DisplayLabel := 'Margem';
  qryCadBas.FieldByName('BAS_PREVEN').DisplayLabel := 'Preço de Venda';

  qryCadBas.FieldByName('AUTOINCREM').Visible := False;

  TFloatField(qryCadBas.FieldByName('BAS_PRECUS')).DisplayFormat := '0.00';
  TFloatField(qryCadBas.FieldByName('BAS_PREVEN')).DisplayFormat := '0.00';
  TFloatField(qryCadBas.FieldByName('BAS_MARGEM')).DisplayFormat := '0.00';
//  TFloatField(qryCadBas.FieldByName('BAS_PESESP')).DisplayFormat := '0.0000';

  dtsCadBas := fCriaDataSource(qryCadBas);
end;

procedure TfrmCadPpgBase.pGetEscolhas(var escolhas: TStringArray);
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT DISTINCT   ' +
        '   BAS_TIPO__      ' +
        ' FROM              ' +
        '   PPG_CADBAS      ';
      qryGen.Open;

      SetLength(escolhas, qryGen.RecordCount);
      while not qryGen.Eof do
      begin
        escolhas[qryGen.RecNo - 1] := qryGen.FieldByName('BAS_TIPO__').AsString;
        qryGen.Next;
      end;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadPpgBase.pHabilitaBtn;
begin
  dbePesEsp.ReadOnly := (qryTabela.State in [dsEdit]);
end;

procedure TfrmCadPpgBase.pHabilitaBtnBasEmp;
begin
  btnBasEmp.Enabled := (Not (qryTabela.IsEmpty)) And (Not (qryTabela.State in [dsEdit, dsInsert]));
end;

procedure TfrmCadPpgBase.pLigaDataSets;
  Var
    intCont: Integer;
begin
  {***********************************************************}
  {* LIGA TODOS OS DBEDITS NO DATASOUCE CRIADO DINAMICAMENTE *}
  {********************************************************PH*}
  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsCadBas;
    End
    Else If (Components[intCont] is TDBCheckBox) Then
    Begin
      (Components[intCont] as TDBCheckBox).DataSource := dtsCadBas;
    End;
  End;

  {**************************************}
  {* LIGA OS DBEDITS NOS DEVIDOS CAMPOS *}
  {***********************************PH*}
  dbeCodBas.DataField := 'BAS_CODBAS';
  dbeCodIte.DataField := 'BAS_CODITE';
  dbeDesBas.DataField := 'BAS_DESBAS';
  dbePesEsp.DataField := 'BAS_PESESP';
  dbeEmbalagem.DataField := 'BAS_EMBALA';
  dbeTipo.DataField := 'BAS_TIPO__';
  dbeBasePo.DataField := 'BAS_BASEPO';
  dbePCusto.DataField := 'BAS_PRECUS';
  dbePMargem.DataField := 'BAS_MARGEM';
  dbePVenda.DataField := 'BAS_PREVEN';


end;

procedure TfrmCadPpgBase.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, dbeCodIte, edtDesIte, nil, key, arrSel) Then
     SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadPpgBase.pBasesPorEmpresas;
begin
  Try
    Try
      frmCadPPGBasesEmp := TfrmCadPPGBasesEmp.Create(Self);
      frmCadPPGBasesEmp.strCodBas := qryTabela.FieldByName('BAS_CODBAS').AsString;
      frmCadPPGBasesEmp.strDesBas := qryTabela.FieldByName('BAS_DESBAS').AsString;
      frmCadPPGBasesEmp.strBasEpo := qryTabela.FieldByName('BAS_BASEPO').AsString;
      frmCadPPGBasesEmp.fltPesEsp := qryTabela.FieldByName('BAS_PESESP').AsFloat;
      frmCadPPGBasesEmp.fltEmbala := qryTabela.FieldByName('BAS_EMBALA').AsFloat;
      frmCadPPGBasesEmp.ShowModal;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frmCadPPGBasesEmp) then pFreeAndNil(frmCadPPGBasesEmp);
  End;
end;

procedure TfrmCadPpgBase.pCamposReadOnlyPaintManager;
Var
  intCont : Integer;
begin
  {***********************************************************}
  {* COLOCA OS CAMPOS QUANDO PAINT MANAGER READONLY          *}
  {********************************************************AC*}
  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).ReadOnly := True;
    End
    Else If (Components[intCont] is TDBCheckBox) Then
    Begin
      (Components[intCont] as TDBCheckBox).ReadOnly := True;
    End;
  End;
  //Só pode alterar o codigo do item
  dbeCodIte.ReadOnly := False;
end;

procedure TfrmCadPpgBase.pCarregaIte;
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE';
  qryGen.ParamByName('CODITE').AsString := qryCadBas.FieldByName('BAS_CODITE').AsString;
  qryGen.Open;

  edtDesIte.Text := qryGen.FieldbyName('ITE_DESITE').AsString;
end;

procedure TfrmCadPpgBase.btnRestPrecoClick(Sender: TObject);
  Var
    fltPrecus: Double;
    fltMargem: Double;
    fltPreVen: Double;
begin
  inherited;
  pRetornaPrecos(dbeCodIte.Field.AsString, fltPrecus, fltMargem, fltPreVen);
  dbePCusto.Field.AsFloat := fltPrecus;
  dbePMargem.Field.AsFloat := fltMargem;
  dbePVenda.Field.AsFloat := fltPreVen;
end;

function TfrmCadPpgBase.fRetPrecoVenda(intOpcao: Integer): Double;
begin
  If fEmptyStr(dbePVenda.Field.AsString) Then
    dbePVenda.Field.AsString := '0,00';

  If fEmptyStr(dbePMargem.Field.AsString) Then
    dbePMargem.Field.AsString := '0,00';

  Result := fCalculaPrecoVenda(intOpcao,
                               fStrToFloat(dbePCusto.Text),
                               fStrToFloat(dbePVenda.Text),
                               fStrToFloat(dbePMargem.Text),
                               0.0,
                               0.0,
                               0.0,
                               0.0);
end;

procedure TfrmCadPpgBase.btnBasEmpClick(Sender: TObject);
begin
  inherited;
  If Not qryTabela.IsEmpty Then
    pBasesPorEmpresas;
end;

procedure TfrmCadPpgBase.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pHabilitaBtnBasEmp;
end;

procedure TfrmCadPpgBase.btnExcluirClick(Sender: TObject);
begin
  strCodIteAnt := dbeCodite.text;
  inherited;

  If fEmptyStr(dbeCodite.Text) Then
    pEnviarLogRep(strCodIteAnt, 'PPG');

  pHabilitaBtnBasEmp;
end;

procedure TfrmCadPpgBase.btnGravarClick(Sender: TObject);
Var
  ObjValidarBaseItemAmarracao : TValidarBaseItemAmarracao;
  blnEdit : Boolean;
begin
  ObjValidarBaseItemAmarracao := TValidarBaseItemAmarracao.Create;

  blnEdit := (qryCadBas.State in [dsEdit]);

  Try
    fStartTransaction;

    if ObjValidarBaseItemAmarracao.fValidarBaseItemAmarracao('PPG', dbeCodBas.text, dbeDesBas.text, dbeCodIte.Text , StrCodIteAnt ,
                                 qryCadBas.FieldByName('BAS_PESESP').AsFloat , strToFloat(dbeEmbalagem.Text)) Then
    begin
      inherited;

      pUpdateFatorTintometrico;

      If (Not fEmptyStr(strCoditeAnt)) And (blnEdit) Then
      Begin
        If (strCoditeAnt <> dbeCodIte.Text) Then
          pEnviarLogRep(strCodIteAnt, 'PPG');
      End;

      pHabilitaBtnBasEmp;
      fCommit;
    end
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnGravarClick]');
    End;
  End;

  If Assigned(ObjValidarBaseItemAmarracao)Then
    FreeAndNil(ObjValidarBaseItemAmarracao);

end;

procedure TfrmCadPpgBase.btnIncluirClick(Sender: TObject);
Var
  conf: IConfTinta;
begin
  strCodIteAnt := '';
  inherited;
  conf := fGetConfTinta('PPG');

  pSetFocus(dbeCodBas);

  qryCadBas.FieldByName('BAS_BASEPO').AsString := 'N';

  if conf.fGetBoolean('PAINTM') then
    dbeTipo.ReadOnly := False;

  pHabilitaBtn;
  pHabilitaBtnBasEmp;
end;

procedure TfrmCadPpgBase.dbeBasePoClick(Sender: TObject);
begin
  inherited;
  If (dbeBasePo.Checked) Then
  Begin
    dbePesEsp.Enabled := False;
    dbePesEsp.Hint := 'Base em pó não necessita de peso específico.';
    dbePesEsp.ShowHint := True;
  End
  Else
  Begin
    dbePesEsp.Enabled := True;
    dbePesEsp.Hint := '';
    dbePesEsp.ShowHint := False;  
  End;
end;

procedure TfrmCadPpgBase.dbeCodIteExit(Sender: TObject);
begin
  inherited;
  pCarregaIte;
end;

procedure TfrmCadPpgBase.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    key: Char;
begin
  Key := '/';
  If fPesqBaseTinta(Self, conPPG, Nil, Nil, qryTabela, key, arrSel, True, '', 'BAS_CODITE', False) Then
  Begin
    pCarregaIte;
    pHabilitaBtnBasEmp;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadPpgBase.btnAlterarClick(Sender: TObject);
Var
  conf: IConfTinta;
begin
  StrCodIteAnt := dbeCodIte.text;
  inherited;
  conf := fGetConfTinta('PPG');

  if conf.fGetBoolean('PAINTM') then
  begin
    pCamposReadOnlyPaintManager;
    pSetFocus(dbeCodIte);
  end
  else

  pSetFocus(dbeDesBas);
  dbePesEsp.ReadOnly := True;
  pHabilitaBtn;
  pHabilitaBtnBasEmp;
end;

procedure TfrmCadPpgBase.pUpdateFatorTintometrico;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'UPDATE CADITE INNER JOIN PPG_CADBAS ON ITE_CODITE = BAS_CODITE SET ITE_CNV_ML = BAS_EMBALA * IF(BAS_BASEPO="S", 1, BAS_PESESP);';
  qryGen.ExecSQL;
  FreeAndNil(qryGen);
end;

procedure TfrmCadPpgBase.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pUpdateFatorTintometrico;
end;

end.

