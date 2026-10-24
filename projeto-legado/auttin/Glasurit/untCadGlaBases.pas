{*******************************************}
{* frmModuloCons.qryCon001 -> CADITE       *}
{****************************************MV*}

unit untCadGlaBases;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls, Mask,
  DBCtrls, DBEditFocus, EditFocus, DB, AppEvnts, Uni, DBComboBoxFocus,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, StrUtils;

type
  TfrmCadGlaBases = class(TfrmPaiCad)
    pnlCentral: TPanel;
    Label2: TLabel;
    dbeCodBas: TDBEditFocus;
    Label3: TLabel;
    dbeDescri: TDBEditFocus;
    Label6: TLabel;
    dbeValBas: TDBEditFocus;
    Label8: TLabel;
    edtDesIte: TEditFocus;
    dbeCodIte: TDBEditFocus;
    Label4: TLabel;
    dbePesBas: TDBEditFocus;
    Label1: TLabel;
    dbeLinha_: TDBComboBoxFocus;
    Label5: TLabel;
    dbeEmbala: TDBComboBoxFocus;
    procedure FormCreate(Sender: TObject);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dbeValBasExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    StrCodIteAnt : String;
    qryCadIte: TUniQuery;
    qryCadbas: TUniQuery;
    dtsCadBas: TDataSource;
    blnAlterou: Boolean;
    procedure pCriaDataSets;
    procedure pLigaDataSets;
    procedure pCarregaItem;
    procedure pHabilitaBtn;
    procedure FormataEmbalagem(strValor: String);
    procedure PreencheEmbalagem();
    function VerificaDataBalanco(qryCadastro: TUniQuery; strUniTab: String): Boolean;
    function fVerificaBasPesAntigo(qryCadastro: TUniQuery; strValorCampo: String; strTabela: String; strCampo: String; strCamEmb: String = ''; strCamEsp: String  = ''): Boolean;
    procedure MensagemInfoDtaBalanco();
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    procedure pAtualizarFatorTintometrico;
    { Public declarations }
  end;

var
  frmCadGlaBases: TfrmCadGlaBases;

implementation

uses untPai,
  untPesqAux, untFuncoesSimples, untFuncTinta,
  untTypesSistema, untConsultas, untValidarBaseItemAmarracao;

{$R *.dfm}

{ TfrmCadGlaColorantes }

function TfrmCadGlaBases.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = dbeCodBas) Then
  Begin

    If (fEmptyStr(dbeCodBas.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O código da base deve ser preechido!', ['&Ok']);
      Result := False;
    End
    Else If (blnBuscaPorChave) And (Not fBuscaPorCamposChave) Then
    Begin
      pLimparCampos;
    End;

  End

  Else If (Sender = dbeDescri) Then
  Begin
    If (fEmptyStr(dbeDescri.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A descrição deve ser preechida!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbePesBas) Then
  Begin
    If (fEmptyStr(dbePesBas.Text)) Then
    Begin
      dbePesBas.Field.AsFloat := 0.0;
    End
    Else If (fStrToFloat(dbePesBas.Text) < 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O peso específico deve ser maior ou igual a Zero!!', ['&Ok']);
      Result := False;
    End
    Else If Not (VerificaDataBalanco(qryTabela, 'BAS'))  And (blnAlterou) And (
      Not fVerificaBasPesAntigo(qryTabela, dbePesBas.Text, 'GLA_CADBAS', 'BAS_CODBAS', '', 'BAS_PESBAS')) Then
    Begin
       MensagemInfoDtaBalanco;
       Result := False;
    End;
  End

  Else If (Sender = dbeEmbala) Then
  Begin
    If (fEmptyStr(dbeEmbala.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A embalagem deve ser preenchida!!', ['&Ok']);
      Result := False;
    End
    Else If Not (VerificaDataBalanco(qryTabela, 'BAS'))  And (blnAlterou) And (
      Not fVerificaBasPesAntigo(qryTabela, dbeEmbala.Text, 'GLA_CADBAS', 'BAS_CODBAS', 'BAS_QTDEMB')) Then
    Begin
      MensagemInfoDtaBalanco;
      Result := False;
      FormataEmbalagem(dbeEmbala.Text);
    End
    Else
    Begin
      FormataEmbalagem(dbeEmbala.Text);
    End;
  End

  Else If (Sender = dbeValBas) Then
  Begin
    If (fEmptyStr(dbeValBas.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Valor da Base deve ser preenchido!!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(dbeValBas.Text) <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Valor da Base deve ser maior que Zero!!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeCodIte) Then
  Begin
    If fEmptyStr(dbeCodIte.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Produto dever ser preenchido!', ['&Ok']);
      Result := False
    End
    Else
    Begin
      pCarregaItem;
      If (qryCadIte.FieldByName('ITE_CODITE').IsNull) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&O k']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = dbeLinha_) Then
  Begin
    If (fEmptyStr(dbeLinha_.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Linha deve ser preechida!', ['&Ok']);
      Result := False;
    End;
  End

end;

function TfrmCadGlaBases.fVerificaBasPesAntigo(qryCadastro: TUniQuery;
  strValorCampo, strTabela, strCampo, strCamEmb, strCamEsp: String): Boolean;
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Try
    Result := True;

    strSQL := '';
    strSQL := '   SELECT * FROM ' + strTabela;

    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Text := strSQL;
    qryGen.Open;

    If Not qryGen.Locate(strCampo, qryCadastro.FieldByName(strCampo).AsString, []) Then
    Begin
      Result := True;
      Exit;
    End;

    If Not fEmptyStr(strCamEmb) Then
    Begin
      qryCadastro.FieldByName(strCamEmb).AsString := strValorCampo;

      If qryGen.FieldByName(strCamEmb).AsString <> qryCadastro.FieldByName(strCamEmb).AsString Then
      Begin
        Result := False;
        Exit;
      End;
    End;

    If Not fEmptyStr(strCamEsp) Then
    Begin
      qryCadastro.FieldByName(strCamEsp).AsFloat := StrToFloat(strValorCampo);

      If qryGen.FieldByName(strCamEsp).AsFloat <> qryCadastro.FieldByName(strCamEsp).AsFloat Then
      Begin
        Result := False;
        Exit;
      End;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadGlaBases.MensagemInfoDtaBalanco;
Var
  arrMensagem: TStringArray;
begin
  pAddDados(arrMensagem, '----------------------------------------------------------------------------------------------------------------');
  pAddDados(arrMensagem, 'Para alterar peso específico e/ou embalagem, é necessário realizar Digitação de Saldo de Balanço através do menu');
  pAddDados(arrMensagem, '[ Operações Ref. a Produtos > Digitação de Saldo de Balanço ]. ');
  pAddDados(arrMensagem, '----------------------------------------------------------------------------------------------------------------');
  pAddDados(arrMensagem, '1) Se houver movimento de entrada/saída deste produto no dia de hoje, esta operação deve ser feita no final do ');
  pAddDados(arrMensagem, 'dia e deve ser informado o dia de hoje na data de balanço, pois a digitação da data de hoje na data de balanço');
  pAddDados(arrMensagem, 'irá permitir nova movimentação somente a partir de amanhã.');
  pAddDados(arrMensagem, '2) Se não houver movimento de entrada/saída deste produto no dia de hoje, esta operação pode ser feita agora e ');
  pAddDados(arrMensagem, 'deve ser informado o dia de ontem na data de balanço.');
  pAddDados(arrMensagem, '----------------------------------------------------------------------------------------------------------------');

  fMensagemTabelaTintas('ATENÇÃO!', 'AVISO', arrMensagem, '', ['&Ok'], 1, True, 1, 827, False, 0, False, False, False, 20, 360, 850, True);
end;

procedure TfrmCadGlaBases.pInicializaIndices;
begin
  inherited;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('BAS_DESBAS+BAS_CODBAS');
  stlCamInd.Add('ITE_CODITE');
  stlCamInd.Add('ITE_DESITE+ITE_REFERE');

  stlDesInd.Add('Descrição/Base');
  stlDesInd.Add('Código do Item');
  stlDesInd.Add('Descrição do Item/Referência do Item');

end;

procedure TfrmCadGlaBases.pLigaDataSets;
var
  intCont: Integer;
begin
  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsCadBas;
    End;
  End;

  dbeLinha_.DataSource := dtsCadBas;
  dbeEmbala.DataSource := dtsCadBas;
end;

procedure TfrmCadGlaBases.PreencheEmbalagem;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('  SELECT              ');
    qryGen.SQL.Add('    *                 ');
    qryGen.SQL.Add('  FROM                ');
    qryGen.SQL.Add('    TABTIN            ');
    qryGen.SQL.Add('  WHERE TIN_TABELA = "GLA_CADBAS"   ');
    qryGen.SQL.Add('    AND TIN_CAMPO_ = "BAS_EMBALA"   ');
    qryGen.SQL.Add('  ORDER BY TIN_VALCOM               ');
    qryGen.Open;

    While Not qryGen.Eof Do
    Begin
      dbeEmbala.Items.Add(qryGen.FieldByName('TIN_OPCCOM').AsString);
      qryGen.Next;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmCadGlaBases.VerificaDataBalanco(qryCadastro: TUniQuery;
  strUniTab: String): Boolean;
Var
  qryGen: TUniQuery;
  DataHoje: TDate;
  DataOntem: TDate;
begin
  Try
    Result := True;

    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Text := '';
    qryGen.SQL.Text := qryGen.SQL.Text + '  SELECT            ';
    qryGen.SQL.Text := qryGen.SQL.Text + '    ITE_DTABAL      ';
    qryGen.SQL.Text := qryGen.SQL.Text + '  FROM              ';
    qryGen.SQL.Text := qryGen.SQL.Text + '    ITEGER          ';
    qryGen.SQL.Text := qryGen.SQL.Text + '  WHERE             ';
    qryGen.SQL.Text := qryGen.SQL.Text + '    ITE_CODITE = :CODITE   AND        ';
    qryGen.SQL.Text := qryGen.SQL.Text + '    ITE_CODEMP = :CODEMP              ';

    qryGen.ParamByName('CODITE').AsString := qryCadastro.FieldByName(strUniTab + '_CODITE').AsString;
    qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGen.Open;

    If qryGen.IsEmpty Then
    Begin
      Result := True;
      Exit;
    End;

    DataHoje  := Date;
    DataOntem := Date - 1;

    If qryGen.FieldByName('ITE_DTABAL').AsDateTime <> DataHoje Then
    Begin
      If qryGen.FieldByName('ITE_DTABAL').AsDateTime = DataOntem Then
      Begin
        Result := True;
        Exit;
      End
      Else
      Begin
        Result := False;
        Exit;
      End;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadGlaBases.FormataEmbalagem(strValor: String);
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Add('  SELECT          ');
    qryGen.SQL.Add('    *             ');
    qryGen.SQL.Add('  FROM            ');
    qryGen.SQL.Add('    TABTIN        ');
    qryGen.SQL.Add('  WHERE           ');
    qryGen.SQL.Add('    TIN_TABELA = "GLA_CADBAS"   ');
    qryGen.SQL.Add('  AND TIN_CAMPO_ = "BAS_EMBALA" ');
    qryGen.SQL.Add('  AND TIN_OPCCOM = "' + strValor + '"   ');
    qryGen.Open;

    qryCadbas.FieldByName('BAS_EMBALA').AsFloat := qryGen.FieldByName('TIN_VALCOM').AsFloat;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadGlaBases.FormCreate(Sender: TObject);
  Var
    dbeCodLin: TDBEdit;
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  qryTabela := qryCadbas;

  TFloatField(qryCadbas.FieldByName('BAS_VALBAS')).DisplayFormat := '0.00';

  strNomeTabela := 'GLA_CADBAS';
  strNomeCampo := 'BAS_CODBAS';

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeCodBas;

  dbeCodLin            := TDBEdit.Create(Self);
  dbeCodLin.DataField  := 'BAS_LINHA_';
  dbeCodLin.DataSource := dtsCadBas;

  arrCamposChave[1] := dbeCodLin;  

  qryCadIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);

  pSetaCodIte(dbeCodIte);
end;

procedure TfrmCadGlaBases.FormShow(Sender: TObject);
begin
  inherited;
  PreencheEmbalagem();
end;

procedure TfrmCadGlaBases.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, dbeCodIte, edtDesIte, nil, key, arrSel) Then
     SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadGlaBases.dbeValBasExit(Sender: TObject);
begin
  inherited;
  dbeValBas.Text := FormatFloat('#0.00', fStrToFloat(dbeValBas.Text));
end;

procedure TfrmCadGlaBases.btnIncluirClick(Sender: TObject);
begin
  StrCodIteAnt := '';
  blnAlterou := False;
  inherited;
  blnUsaProCodigo := False;
  
  qryTabela.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
  pSetFocus(dbeCodBas);
  edtDesIte.Clear;
  pHabilitaBtn;
  dbeEmbala.Enabled := True;
  dbeLinha_.Enabled := True;
end;

procedure TfrmCadGlaBases.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  blnAlterou := False;
  If fPesqBaseTinta(Self, conGla, nil, nil, qryTabela, Key, arrSel, True, '', '', False) Then
  Begin
    pCarregaItem;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadGlaBases.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  StrCodIteAnt := dbeCodIte.Text;
  blnAlterou := False;

  Try
    inherited;

    If (blnExcluiu) Then
    Begin
      If Not (fEmptyStr(strCodIteAnt)) Then
        pEnviarLogRep(strCodIteAnt, 'GLA');

      fCommit;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadGlaBases.btnExcluirClick]');
    End
  End;

  pCarregaItem;
  dbeEmbala.Enabled := False;
  dbeLinha_.Enabled := False;
end;

procedure TfrmCadGlaBases.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaItem;
  dbeLinha_.Enabled := False;
  dbeEmbala.Enabled := False;
  blnAlterou := False;
end;

procedure TfrmCadGlaBases.btnAlterarClick(Sender: TObject);
begin
  StrCodIteAnt := dbeCodIte.text;
  blnAlterou := True;
  inherited;

  dbeCodBas.Enabled := False;
  dbePesBas.ReadOnly := True;
  dbeEmbala.Enabled := True;
  dbeLinha_.Enabled := True;

  pSetFocus(dbeDescri);
  pHabilitaBtn;
end;

procedure TfrmCadGlaBases.pCarregaItem;
begin
  pPesquisaCadIte(qryCadIte, qryCadIte, dbeCodIte.Text);
  With qryCadIte Do
  Begin
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
  End;
end;

procedure TfrmCadGlaBases.pCriaDataSets;
begin
  {**********************************}
  {* CRIA OS DATASETS DINAMICAMENTE *}
  {*******************************PH*}

  qryCadbas := fCriarQuery('SELECT * FROM GLA_CADBAS', Self);

  qryCadbas.FieldByName('BAS_CODBAS').DisplayLabel := 'Código';
  qryCadbas.FieldbyName('BAS_LINHA_').DisplayLabel := 'Linha';
  qryCadbas.FieldbyName('BAS_DESBAS').DisplayLabel := 'Descrição';
  qryCadbas.FieldbyName('BAS_CODITE').DisplayLabel := 'Código do Item';
  qryCadbas.FieldbyName('BAS_PESBAS').DisplayLabel := 'Peso Específico';
//  TFloatField(qryCadbas.FieldbyName('BAS_PESBAS')).DisplayFormat := '0.0000';
  qryCadbas.FieldByName('AUTOINCREM').Visible := False;

  dtsCadBas := fCriaDataSource(qryCadbas);
end;

procedure TfrmCadGlaBases.pHabilitaBtn;
begin
  dbePesBas.ReadOnly := (qryTabela.State in [dsEdit]);
end;

procedure TfrmCadGlaBases.pAtualizarFatorTintometrico;
  Var
    qryGen: TUniQuery;
    fltEmbalagem :Double;
begin
  fltEmbalagem := qryCadbas.FieldByName('BAS_PESBAS').AsFloat * qryCadbas.FieldByName('BAS_EMBALA').AsFloat;

  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'UPDATE CADITE INNER JOIN GLA_CADBAS ON ITE_CODITE = BAS_CODITE SET ITE_CNV_ML = ' + AnsiReplaceStr(FloatToStr(fltEmbalagem), ',', '.') +
                     ' WHERE ITE_CODITE = ' + qryCadBas.FieldByName('BAS_CODITE').AsString;
  qryGen.ExecSQL;
  FreeAndNil(qryGen);
end;

procedure TfrmCadGlaBases.btnGravarClick(Sender: TObject);
Var
  ObjValidarBaseItemAmarracao : TValidarBaseItemAmarracao;
  blnEdit : Boolean;
begin
  ObjValidarBaseItemAmarracao := TValidarBaseItemAmarracao.Create;

  FormataEmbalagem(dbeEmbala.Text);

  blnEdit := (qryCadBas.State in [dsEdit]);

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  If blnEdit Then
    blnAlterou := True;

  Try
//    fStartTransaction;

    if ObjValidarBaseItemAmarracao.fValidarBaseItemAmarracao('GLA', dbeCodBas.text, dbeDescri.text, dbeCodIte.Text , StrCodIteAnt ,
                                 qryCadBas.FieldByName('BAS_PESBAS').AsFloat , qryCadBas.FieldByName('BAS_EMBALA').AsFloat) Then
    begin
      inherited;
      pAtualizarFatorTintometrico;

      If (Not fEmptyStr(strCoditeAnt)) And (blnEdit) Then
      Begin
        If (strCoditeAnt <> dbeCodIte.Text) Then
          pEnviarLogRep(strCodIteAnt, 'GLA');
      End;

      If blnGravou Then
        fCommit
      Else
        fRollBack;

      dbeEmbala.Enabled := False;
      dbeLinha_.Enabled := False;
    End
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

end.

