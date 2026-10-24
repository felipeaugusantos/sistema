{*******************************************}
{* frmModuloCons.qryCon001 -> CADITE       *}
{****************************************MV*}

unit untCadWanBases;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls, Mask,
  DBCtrls, DBEditFocus, EditFocus, DB, AppEvnts, Uni, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadWanBases = class(TfrmPaiCad)
    pnlCentral: TPanel;
    Label1: TLabel;
    dbeLinha: TDBEditFocus;
    Label2: TLabel;
    dbeCodBas: TDBEditFocus;
    Label3: TLabel;
    dbeDescri: TDBEditFocus;
    Label4: TLabel;
    dbePesBas: TDBEditFocus;
    Label5: TLabel;
    dbePesUni: TDBEditFocus;
    Label6: TLabel;
    dbeValBas: TDBEditFocus;
    Label8: TLabel;
    edtDesIte: TEditFocus;
    dbeCodIte: TDBEditFocus;
    dtsWanCadBas: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    { Private declarations }

    qryCadIte: TUniQuery;

    procedure pCarregaItem;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    procedure pAtualizaFatorTintometrico;
  end;

var
  frmCadWanBases: TfrmCadWanBases;

implementation

uses untPai, untModuloTinta,
  untPesqAux, untFuncoesSimples, untFuncTinta,
  untTypesSistema, untConsultas;

{$R *.dfm}

{ TfrmCadWanColorantes }

function TfrmCadWanBases.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = dbeLinha) Then
  Begin

    If (fEmptyStr(dbeLinha.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A linha deve ser preenchida!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeCodBas) Then
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
      fMensagem('ATENÇÃO!', 'O peso da base deve ser preechido!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(dbePesBas.Text) <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O peso da base deve ser maior que Zero!!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbePesUni) Then
  Begin
    If (fEmptyStr(dbePesUni.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O peso da unidade deve ser preechido!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(dbePesUni.Text) <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O peso da unidade deve ser maior que Zero!!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeValBas) Then
  Begin
    If (fEmptyStr(dbeValBas.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor da base deve ser preechido!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(dbeValBas.Text) <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor da base deve ser maior que Zero!!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeCodIte) Then
  Begin
    If (fEmptyStr(dbeCodIte.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Item Base deve ser preenchido!', ['&O k']);
      Result := False;
    End
    Else If fExisteValorNoCampo(dbeCodIte.Text, 'BAS_CODITE', 'WAN_CADBAS', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
    Begin
      Result := fMensagem('ATENÇÃO', 'Esse item já está relacionado a outra base!'#10#13'Deseja continuar ?', ['Sim', 'Não']) = 1;
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

end;

procedure TfrmCadWanBases.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('BAS_LINHA_');
  stlCampos.Add('BAS_CODBAS');
  stlCampos.Add('BAS_DESBAS');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('BAS_DESBAS+BAS_CODBAS+BAS_LINHA_');
  stlCamInd.Add('ITE_CODITE');
  stlCamInd.Add('ITE_DESITE+ITE_REFERE');

  stlDesInd.Add('Descrição/Base/Linha');
  stlDesInd.Add('Código do Item');
  stlDesInd.Add('Descrição do Item/Referência do Item');
end;

procedure TfrmCadWanBases.FormCreate(Sender: TObject);
  Var
    dbeCodEmp: TDBEdit;
begin
  inherited;
  strNomeTabela := 'WAN_CADBAS';
  strNomeCampo  := 'BAS_LINHA_';
  qryTabela     := frmModuloTinta.qryWan_CadBas;

  dtsWanCadBas.DataSet := frmModuloTinta.qryWan_CadBas;

  {*****************************************}
  {* CRIA O CAMPO EMPRESA PARA SER USADO   *}
  {* NA FUNÇÃO DE BUSCA PARA ALTERAÇÃO     *}
  {**************************************MV*}
  dbeCodEmp            := TDBEdit.Create(Self);
  dbeCodEmp.DataField  := 'BAS_CODEMP';
  dbeCodEmp.DataSource := frmModuloTinta.dtsWan_CadBas;

  SetLength(arrCamposChave, 3);
  arrCamposChave[0] := dbeLinha;
  arrCamposChave[1] := dbeCodBas;
  arrCamposChave[2] := dbeCodEmp;

  qryCadIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
end;

procedure TfrmCadWanBases.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, dbeCodIte, edtDesIte, nil, key, arrSel) Then
     SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadWanBases.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;

  qryTabela.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
  pSetFocus(dbeLinha);
  edtDesIte.Clear;
end;

procedure TfrmCadWanBases.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    key: Char;
begin
  key := '/';
  If fPesqBaseTinta(Self, conWanda, dbeCodBas, nil, qryTabela, key, arrSel, True, '', '', False) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadWanBases.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pCarregaItem;
end;

procedure TfrmCadWanBases.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaItem;
end;

procedure TfrmCadWanBases.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeLinha.Enabled := False;
  dbeCodBas.Enabled := False;

  pSetFocus(dbeDescri);
  dbePesBas.ReadOnly := True;
end;

procedure TfrmCadWanBases.pCarregaItem;
begin
  pPesquisaCadIte(qryCadIte, qryCadIte, dbeCodIte.Text);
  With qryCadIte Do
  Begin
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
  End;
end;

procedure TfrmCadWanBases.pAtualizaFatorTintometrico;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.sql.Text := '';
end;

end.

