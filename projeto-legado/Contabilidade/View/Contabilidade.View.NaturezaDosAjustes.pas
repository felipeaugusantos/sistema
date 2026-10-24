unit Contabilidade.View.NaturezaDosAjustes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, Data.DB, Contabilidade.View.TfrmPaiCadContabilidade, frxClass, frxExportCSVTestabilidade,
  EditFocus, MemDS, DBAccess, Uni;

type
  TfrmNaturezaDosAjustes = class(TfrmPaiCadContabilidade)
    pnlCentral: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    dbeDescri: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    dtsNatAju: TDataSource;
    rdgTipMov: TDBRadioGroup;
    GroupBox1: TGroupBox;
    edtDesEcf: TEditFocus;
    GroupBox2: TGroupBox;
    dbeCodLal: TDBEditFocus;
    edtDesLal: TEditFocus;
    GroupBox3: TGroupBox;
    chkGerLal: TDBCheckBox;
    chkGerLac: TDBCheckBox;
    dbeCodLac: TDBEditFocus;
    edtDesLac: TEditFocus;
    dbeTabEcf: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeTabEcfKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodLalKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodLacKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure chkGerLalClick(Sender: TObject);
    procedure chkGerLacClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rdgTipMovClick(Sender: TObject);
  private
    procedure pLimpaTela;
    procedure pAtualizaTela;
    procedure pAtualizaLalurLacsCampos;
    procedure pLimparLalurLacs;
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses
  untTypesSistema, untConsultas, untFuncoesSimples, Contabilidade.Consultas,
  Contabilidade.Funcoes;

{$R *.dfm}

procedure TfrmNaturezaDosAjustes.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
end;

procedure TfrmNaturezaDosAjustes.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pAtualizaTela;
end;

procedure TfrmNaturezaDosAjustes.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pLimpaTela;
end;

procedure TfrmNaturezaDosAjustes.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  pLimpaTela;
end;

procedure TfrmNaturezaDosAjustes.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrTip: TConsultasArray;
begin
  chrKey := '/';
  If fPesqNaturezaDosAjustes(Self, Nil, Nil, qryTabela, chrKey, arrTip) Then
  Begin
    pAtualizaTela;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmNaturezaDosAjustes.chkGerLacClick(Sender: TObject);
begin
  inherited;
  pAtualizaLalurLacsCampos ;
  if not chkGerLac.Checked then
  begin
    if dtsNatAju.DataSet.State in [dsEdit, dsInsert] then
    begin
      dbeCodLac.Field.Clear ;
      edtDesLac.Clear ;
    end;
  end;
end;

procedure TfrmNaturezaDosAjustes.chkGerLalClick(Sender: TObject);
begin
  inherited;
  pAtualizaLalurLacsCampos ;
  if not chkGerLal.Checked then
  begin
    if dtsNatAju.DataSet.State in [dsEdit, dsInsert] then
    begin
      dbeCodLal.Field.Clear ;
      edtDesLal.Clear ;
    end;
  end;
end;

procedure TfrmNaturezaDosAjustes.dbeCodLacKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCons: TConsultasArray;
  LBloco, LRegistro, LTipo, LOrientacao: string;
begin
  if fEntraCons(Key) then
  begin
    pRetornaFiltroAdicionalDemonstrativoECF(
       rdgTipMov.Field.AsString,
       dbeTabEcf.Field.AsString,
       cLACS,
       LBloco,
       LRegistro,
       LTipo,
       LOrientacao) ;
    If fPesqECFDemonstrativo(Self,
                             TDBEditFocus(Sender),
                             edtDesLac,
                             Nil,
                             Key,
                             arrCons,
                             False,
                             LBloco,
                             LRegistro,
                             LTipo,
                             LOrientacao) Then
    Begin
      If fValidaCampos(TDBEditFocus(Sender), True) Then
        SelectNext(ActiveControl, True, True);
    End;
  end;
end;

procedure TfrmNaturezaDosAjustes.dbeCodLalKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCons: TConsultasArray;
  LBloco, LRegistro, LTipo, LOrientacao: string;
begin
  if fEntraCons(Key) then
  begin
    pRetornaFiltroAdicionalDemonstrativoECF(
       rdgTipMov.Field.AsString,
       dbeTabEcf.Field.AsString,
       cLalur,
       LBloco,
       LRegistro,
       LTipo,
       LOrientacao) ;
    If fPesqECFDemonstrativo(Self,
                             TDBEditFocus(Sender),
                             edtDesLal,
                             Nil,
                             Key,
                             arrCons,
                             False,
                             LBloco,
                             LRegistro,
                             LTipo,
                             LOrientacao) Then
    Begin
      If fValidaCampos(TDBEditFocus(Sender), True) Then
        SelectNext(ActiveControl, True, True);
    End;
  end;
end;

procedure TfrmNaturezaDosAjustes.dbeTabEcfKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrTabEcf: TConsultasArray;
begin
  if fEntraCons(Key) then
  Begin
    If fPesqTipoDaTabelaDinamicaDoEcf(Self, dbeTabEcf, edtDesEcf, Nil, Key, arrTabEcf) Then
    Begin
      If fValidaCampos(dbeTabEcf, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmNaturezaDosAjustes.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'NATAJU';
  strNomeCampo      := 'NAT_CODIGO';

  qryTabela         := fCriarQuery('SELECT * FROM NATAJU', Self);
  dtsNatAju.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmNaturezaDosAjustes.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = VK_RETURN then
  Begin
    If (ActiveControl Is TDBRadioGroup) Or
       (ActiveControl.ClassName = 'TGroupBox') Or
       (ActiveControl.ClassName = 'TGroupButton') Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmNaturezaDosAjustes.FormShow(Sender: TObject);
begin
  inherited;
  pAtualizaLalurLacsCampos ;
end;

function TfrmNaturezaDosAjustes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  LBloco, LRegistro: string ;
begin

  Result := True;

  If (Sender = dbeCodigo) Then
  Begin
    If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
    Begin
      fMensagem('ATENÇÃO!', 'O código da natureza do ajuste deve ser preenchido!', ['&OK']);
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
      fMensagem('ATENÇÃO!', 'A descrição da natureza do ajuste deve ser preenchida!', ['&OK']);
      Result := False;
    End;
  End
  Else If (Sender = dbeTabEcf) Then
  Begin
    if not fEmptyStr(dbeTabEcf.Text) then
    Begin
      edtDesEcf.Text := fRetDescTipoDaTabelaDinamicaDoEcf(dbeTabEcf.Text);
      if fEmptyStr(edtDesEcf.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse tipo da tabela dinâminca do ECF não está cadastrada!', ['&Ok']);
        Result := False;
      End;
    End
    else
    Begin
      edtDesEcf.Clear;
      dbeTabEcf.DataSource.DataSet.FieldByName('NAT_TABECF').Clear;
      fMensagem('ATENÇÃO!', 'O tipo da tabela dinâminca do ECF deve ser preenchida!', ['&OK']);
      Result := False;
    End;
    If blnBuscaPorChave Then
      pLimparLalurLacs ;
  End
  Else If (Sender = dbeCodLal) Then
  Begin
    if chkGerLal.Checked then
    Begin
      edtDesLal.Text := fRetDescDemonstrativoECF(dbeCodLal.Text, cLALUR, rdgTipMov.Field.AsString, dbeTabEcf.Field.AsString, LBloco, LRegistro);
      dtsNatAju.DataSet.FieldByName('NAT_BLCLAL').AsString := LBloco ;
      dtsNatAju.DataSet.FieldByName('NAT_REGLAL').AsString := LRegistro ;
      if fEmptyStr(edtDesLal.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'LAIR - Plano referêncial não está cadastrada!', ['&Ok']);
        Result := False;
      End;
    End
    else
    Begin
      edtDesLal.Clear;
      dbeCodLal.DataSource.DataSet.FieldByName('NAT_CODLAL').Clear;
      dtsNatAju.DataSet.FieldByName('NAT_BLCLAL').Clear ;
      dtsNatAju.DataSet.FieldByName('NAT_REGLAL').Clear ;
    End
  End
  Else If (Sender = dbeCodLac) Then
  Begin
    if chkGerLac.Checked then
    Begin
      edtDesLac.Text := fRetDescDemonstrativoECF(dbeCodLac.Text, cLACS, rdgTipMov.Field.AsString, dbeTabEcf.Field.AsString, LBloco, LRegistro);
      dtsNatAju.DataSet.FieldByName('NAT_BLCLAC').AsString := LBloco ;
      dtsNatAju.DataSet.FieldByName('NAT_REGLAC').AsString := LRegistro ;
      if fEmptyStr(edtDesLac.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'LACS - Plano referêncial não está cadastrada!', ['&Ok']);
        Result := False;
      End ;
    End
    else
    Begin
      edtDesLac.Clear;
      dbeCodLac.DataSource.DataSet.FieldByName('NAT_CODLAC').Clear;
      dtsNatAju.DataSet.FieldByName('NAT_BLCLAC').Clear ;
      dtsNatAju.DataSet.FieldByName('NAT_REGLAC').Clear ;
    End
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmNaturezaDosAjustes.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NAT_CODIGO');
  stlCampos.Add('NAT_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NAT_DESCRI');
  stlCamInd.Add('NAT_CODIGO');

  stlDesInd.Add('Nome');
  stlDesInd.Add('Código');
end;

procedure TfrmNaturezaDosAjustes.pLimparLalurLacs;
begin
  if dtsNatAju.DataSet.State in [dsEdit, dsInsert] then
  begin
    dbeCodLal.Field.Clear ;
    edtDesLal.Clear ;
    dtsNatAju.DataSet.FieldByName('NAT_BLCLAL').Clear ;
    dtsNatAju.DataSet.FieldByName('NAT_REGLAL').Clear ;

    dbeCodLac.Field.Clear ;
    edtDesLac.Clear ;
    dtsNatAju.DataSet.FieldByName('NAT_BLCLAC').Clear ;
    dtsNatAju.DataSet.FieldByName('NAT_REGLAC').Clear ;
  end;
end;

procedure TfrmNaturezaDosAjustes.pLimpaTela;
begin
  rdgTipMov.ItemIndex := 0;
  chkGerLal.Checked  := False;
  chkGerLac.Checked  := False;
  edtDesEcf.Clear;
  edtDesLal.Clear;
  edtDesLac.Clear;
end;

procedure TfrmNaturezaDosAjustes.rdgTipMovClick(Sender: TObject);
begin
  inherited;
  pLimparLalurLacs;
end;

procedure TfrmNaturezaDosAjustes.pAtualizaLalurLacsCampos;
begin
  dbeCodLal.Enabled := chkGerLal.Checked ;
  dbeCodLac.Enabled := chkGerLac.Checked ;
end;

procedure TfrmNaturezaDosAjustes.pAtualizaTela;
var
  LBloco, LRegistro: string ;
begin
  edtDesEcf.Text := fRetDescTipoDaTabelaDinamicaDoEcf(dbeTabEcf.Text);
  edtDesLal.Text := fRetDescDemonstrativoECF(dbeCodLal.Text, cLALUR, rdgTipMov.Field.AsString, dbeTabEcf.Field.AsString, LBloco, LRegistro);
  edtDesLac.Text := fRetDescDemonstrativoECF(dbeCodLac.Text, cLACS, rdgTipMov.Field.AsString, dbeTabEcf.Field.AsString, LBloco, LRegistro);
  pAtualizaLalurLacsCampos ;
end;

end.
