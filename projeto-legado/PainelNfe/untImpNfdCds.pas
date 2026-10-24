unit untImpNfdCds;

{
  Editor da impressao dinamica: datasets (IMPNFE_CDS) de um provedor.
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DB, DBCtrls,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  cxTextEdit, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid,
  {$IFDEF VER300}
  cxDataControllerConditionalFormattingRulesManagerDialog,
  {$ENDIF}
{$IF Defined(UNIDAC)}
  Uni;
{$ELSE}
  ZConnection, ZDataset;
{$IFEND}

type
  TfrmImpNfdCds = class(TForm)
    grdCds: TcxGrid;
    tbvCds: TcxGridDBTableView;
    tbvCdsCDS_NOMCDS: TcxGridDBColumn;
    tbvCdsCDS_NOMFRX: TcxGridDBColumn;
    tbvCdsCDS_ORIGEM: TcxGridDBColumn;
    lvlCds: TcxGridLevel;
    pnlCampos: TPanel;
    lblNomCds: TLabel;
    dbeNomCds: TDBEdit;
    lblNomFrx: TLabel;
    dbeNomFrx: TDBEdit;
    dbrOrigem: TDBRadioGroup;
    lblSelect: TLabel;
    dbmSelect: TDBMemo;
    lblCamBas: TLabel;
    dbeCamBas: TDBEdit;
    lblChvSel: TLabel;
    dbeChvSel: TDBEdit;
    lblCondic: TLabel;
    dbmCondic: TDBMemo;
    lblPosPrc: TLabel;
    dbePosPrc: TDBEdit;
    lblOrdem: TLabel;
    dbeOrdem: TDBEdit;
    dbcRegVaz: TDBCheckBox;
    btnSalvar: TButton;
    btnNovo: TButton;
    btnEditar: TButton;
    btnExcluir: TButton;
    btnCancelar: TButton;
    btnFields: TButton;
    btnFechar: TButton;
    dtsCds: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dtsCdsStateChange(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnFieldsClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    qryCds: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    // NOTA_FISCAL/CUPOM_FISCAL com as colunas do script 003
    FblnModeloNovo: Boolean;
    procedure pConfiguraModeloNovo;
    procedure qryCdsNewRecord(DataSet: TDataSet);
    procedure pAbrir(const ALocalizar: String = '');
    procedure pAjustaBotoes;
    procedure pHabilitaCampos(AHabilita: Boolean);
    function fEmEdicao: Boolean;
    function fTemRegistro: Boolean;
  public
    NomePrv: String;   // chave do provedor (PRV_NOME)
  end;

var
  frmImpNfdCds: TfrmImpNfdCds;

implementation

uses
  untUtil, untImpNfdFields, untNfsDinamico, untNfeDinamico, untNfceDinamico;

{$R *.dfm}

{ TfrmImpNfdCds }

procedure TfrmImpNfdCds.FormCreate(Sender: TObject);
begin
  qryCds := fCriaQuery(Self);
  qryCds.SQL.Text :=
    'SELECT CDS_CODPRV, CDS_NOMCDS, CDS_NOMFRX, CDS_ORIGEM, CDS_SELECT ' +
    'FROM IMPNFE_CDS WHERE CDS_CODPRV = :PRV ORDER BY CDS_NOMFRX';
{$IF Defined(UNIDAC)}
  qryCds.KeyFields := 'CDS_CODPRV;CDS_NOMCDS';
{$IFEND}
  qryCds.OnNewRecord := qryCdsNewRecord;
  dtsCds.DataSet := qryCds;
end;

procedure TfrmImpNfdCds.FormShow(Sender: TObject);
begin
  Caption := 'Datasets (CDS) - Provedor: ' + NomePrv;
  pConfiguraModeloNovo;
  pAbrir;
end;

procedure TfrmImpNfdCds.pConfiguraModeloNovo;
var
  intDif, i: Integer;
begin
  // origem A e colunas do modelo novo: somente NOTA_FISCAL/CUPOM_FISCAL com o script 003
  FblnModeloNovo := (SameText(NomePrv, cstProvedorNotaFiscal) or SameText(NomePrv, cstProvedorCupomFiscal)) and
    TNfsDinamico.fModeloNovoDisponivel;

  lblCamBas.Visible := FblnModeloNovo;
  dbeCamBas.Visible := FblnModeloNovo;
  lblChvSel.Visible := FblnModeloNovo;
  dbeChvSel.Visible := FblnModeloNovo;
  lblCondic.Visible := FblnModeloNovo;
  dbmCondic.Visible := FblnModeloNovo;
  lblPosPrc.Visible := FblnModeloNovo;
  dbePosPrc.Visible := FblnModeloNovo;
  lblOrdem.Visible  := FblnModeloNovo;
  dbeOrdem.Visible  := FblnModeloNovo;
  dbcRegVaz.Visible := FblnModeloNovo;

  if not FblnModeloNovo then
  begin
    // sem a origem A (Ambos): so XML e Banco
    if dbrOrigem.Items.Count > 2 then
    begin
      dbrOrigem.Items.Delete(2);
      dbrOrigem.Values.Delete(2);
    end;

    // sem as colunas novas: fecha o espaco delas (os botoes sobem junto)
    intDif := pnlCampos.Height - lblCamBas.Top;
    pnlCampos.Height := lblCamBas.Top;
    for i := 0 to ControlCount - 1 do
      if Controls[i].Top > pnlCampos.Top then
        Controls[i].Top := Controls[i].Top - intDif;
    ClientHeight := ClientHeight - intDif;
    Exit;
  end;

  dbeCamBas.DataField := 'CDS_CAMBAS';
  dbeChvSel.DataField := 'CDS_CHVSEL';
  dbmCondic.DataField := 'CDS_CONDIC';
  dbePosPrc.DataField := 'CDS_POSPRC';
  dbeOrdem.DataField  := 'CDS_ORDEM';
  dbcRegVaz.DataField := 'CDS_REGVAZ';

  qryCds.Close;
  qryCds.SQL.Text :=
    'SELECT CDS_CODPRV, CDS_NOMCDS, CDS_NOMFRX, CDS_ORIGEM, CDS_SELECT, ' +
    '       CDS_CAMBAS, CDS_CHVSEL, CDS_CONDIC, CDS_REGVAZ, CDS_POSPRC, CDS_ORDEM ' +
    'FROM IMPNFE_CDS WHERE CDS_CODPRV = :PRV ORDER BY CDS_ORDEM, CDS_NOMFRX';
end;

procedure TfrmImpNfdCds.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if fEmEdicao then
  begin
    if MessageDlg('Existem alterações não salvas. Deseja descartá-las e sair?',
         mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      qryCds.Cancel
    else
      CanClose := False;
  end;
end;

procedure TfrmImpNfdCds.qryCdsNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('CDS_CODPRV').AsString  := NomePrv;
  DataSet.FieldByName('CDS_ORIGEM').AsString  := 'X';
end;

procedure TfrmImpNfdCds.pAbrir(const ALocalizar: String);
begin
  qryCds.Close;
  qryCds.ParamByName('PRV').AsString := NomePrv;
  qryCds.Open;
  if ALocalizar <> '' then
    qryCds.Locate('CDS_NOMCDS', ALocalizar, []);
  pAjustaBotoes;
end;

function TfrmImpNfdCds.fEmEdicao: Boolean;
begin
  Result := Assigned(qryCds) and (qryCds.State in [dsEdit, dsInsert]);
end;

function TfrmImpNfdCds.fTemRegistro: Boolean;
begin
  Result := Assigned(qryCds) and qryCds.Active and (not qryCds.IsEmpty);
end;

procedure TfrmImpNfdCds.pHabilitaCampos(AHabilita: Boolean);
var
  i: Integer;
begin
  for i := 0 to pnlCampos.ControlCount - 1 do
  begin
    if pnlCampos.Controls[i] is TLabel then
      Continue;

    // memo fica habilitado (para rolar/copiar), apenas somente-leitura fora da edicao
    if pnlCampos.Controls[i] is TDBMemo then
    begin
      TDBMemo(pnlCampos.Controls[i]).ReadOnly := not AHabilita;
      if AHabilita then
        TDBMemo(pnlCampos.Controls[i]).Color := clWindow
      else
        TDBMemo(pnlCampos.Controls[i]).Color := clBtnFace;
      Continue;
    end;

    pnlCampos.Controls[i].Enabled := AHabilita;
  end;
end;

procedure TfrmImpNfdCds.pAjustaBotoes;
var
  blnEdicao, blnReg: Boolean;
begin
  if (csDestroying in ComponentState) or (not Assigned(qryCds)) then
    Exit;

  blnEdicao := fEmEdicao;
  blnReg    := fTemRegistro;

  btnSalvar.Enabled   := blnEdicao;
  btnCancelar.Enabled := blnEdicao;
  btnNovo.Enabled     := qryCds.Active and (not blnEdicao);
  btnEditar.Enabled   := blnReg and (not blnEdicao);
  btnExcluir.Enabled  := blnReg and (not blnEdicao);
  btnFields.Enabled   := blnReg and (not blnEdicao);

  grdCds.Enabled := not blnEdicao;
  pHabilitaCampos(blnEdicao);
  // o nome do cds é chave (PK): só pode ser informado na inclusão
  dbeNomCds.Enabled := blnEdicao and (qryCds.State = dsInsert);
end;

procedure TfrmImpNfdCds.dtsCdsStateChange(Sender: TObject);
begin
  pAjustaBotoes;
end;

procedure TfrmImpNfdCds.btnNovoClick(Sender: TObject);
begin
  if fEmEdicao then
    Exit;
  qryCds.Append;
  dbeNomCds.SetFocus;
end;

procedure TfrmImpNfdCds.btnEditarClick(Sender: TObject);
begin
  if (not fTemRegistro) or fEmEdicao then
    Exit;
  qryCds.Edit;
  dbeNomFrx.SetFocus;
end;

procedure TfrmImpNfdCds.btnCancelarClick(Sender: TObject);
begin
  if fEmEdicao then
    qryCds.Cancel;
end;

procedure TfrmImpNfdCds.btnSalvarClick(Sender: TObject);
var
  qry: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  blnInserindo: Boolean;
  strNomCds: String;
  intQtd: Integer;
begin
  if not fEmEdicao then
    Exit;

  qryCds.UpdateRecord;

  strNomCds := Trim(qryCds.FieldByName('CDS_NOMCDS').AsString);
  if fEmptyStr(strNomCds) or
     fEmptyStr(Trim(qryCds.FieldByName('CDS_NOMFRX').AsString)) then
  begin
    MessageDlg('Informe o nome do cds e o nome do dataset no fr3.', mtInformation, [mbOk], 0);
    if fEmptyStr(strNomCds) and dbeNomCds.Enabled then
      dbeNomCds.SetFocus
    else
      dbeNomFrx.SetFocus;
    Exit;
  end;

  // origem A e exclusiva do modelo novo
  if (UpperCase(Trim(qryCds.FieldByName('CDS_ORIGEM').AsString)) = 'A') and (not FblnModeloNovo) then
  begin
    MessageDlg('A origem Ambos (A) é exclusiva dos provedores ' + cstProvedorNotaFiscal +
      ' e ' + cstProvedorCupomFiscal + ' e requer o SCRIPT_PAINEL_003.', mtInformation, [mbOk], 0);
    Exit;
  end;

  // na NF-e um dataset de Banco sem SELECT e valido (fica fechado, como Eventos no ACBr)
  if (UpperCase(Trim(qryCds.FieldByName('CDS_ORIGEM').AsString)) = 'B') and (not FblnModeloNovo) and
     fEmptyStr(Trim(qryCds.FieldByName('CDS_SELECT').AsString)) then
  begin
    MessageDlg('Para a origem Banco informe o SELECT do dataset.', mtInformation, [mbOk], 0);
    dbmSelect.SetFocus;
    Exit;
  end;

  blnInserindo := (qryCds.State = dsInsert);

  qry := fCriaQuery(Self);
  try
    // o nome do cds é chave: não pode repetir no provedor
    if blnInserindo then
    begin
      qry.SQL.Text :=
        'SELECT COUNT(*) AS QTD FROM IMPNFE_CDS ' +
        'WHERE CDS_CODPRV = :PRV AND CDS_NOMCDS = :CDS';
      qry.ParamByName('PRV').AsString := NomePrv;
      qry.ParamByName('CDS').AsString := strNomCds;
      qry.Open;
      intQtd := qry.FieldByName('QTD').AsInteger;
      qry.Close;

      if intQtd > 0 then
      begin
        MessageDlg('Já existe o cds "' + strNomCds + '" para este provedor.', mtInformation, [mbOk], 0);
        dbeNomCds.SetFocus;
        Exit;
      end;
    end;

    // o mesmo dataset do fr3 não pode aparecer duas vezes no provedor
    qry.SQL.Text :=
      'SELECT COUNT(*) AS QTD FROM IMPNFE_CDS ' +
      'WHERE CDS_CODPRV = :PRV AND CDS_NOMFRX = :FRX AND CDS_NOMCDS <> :CDS';
    qry.ParamByName('PRV').AsString := NomePrv;
    qry.ParamByName('FRX').AsString := Trim(qryCds.FieldByName('CDS_NOMFRX').AsString);
    qry.ParamByName('CDS').AsString := strNomCds;
    qry.Open;
    intQtd := qry.FieldByName('QTD').AsInteger;
    qry.Close;
  finally
    FreeAndNil(qry);
  end;

  if intQtd > 0 then
  begin
    MessageDlg('Já existe um dataset "' + Trim(qryCds.FieldByName('CDS_NOMFRX').AsString) +
      '" para este provedor.', mtInformation, [mbOk], 0);
    dbeNomFrx.SetFocus;
    Exit;
  end;

  if blnInserindo then
    qryCds.FieldByName('CDS_NOMCDS').AsString := strNomCds;

  try
    qryCds.Post;
  except
    on E: Exception do
    begin
      MessageDlg('Não foi possível salvar o dataset.' + sLineBreak + E.Message, mtError, [mbOk], 0);
      Exit;
    end;
  end;

  pAbrir(strNomCds);
end;

procedure TfrmImpNfdCds.btnExcluirClick(Sender: TObject);
var
  qry: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  if (not fTemRegistro) or fEmEdicao then
    Exit;

  if MessageDlg('Deseja realmente excluir o dataset "' + qryCds.FieldByName('CDS_NOMFRX').AsString +
       '" e TODOS os seus campos?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  qry := fCriaQuery(Self);
  try
    qry.SQL.Text := 'DELETE FROM IMPNFE_FLD WHERE FLD_CODPRV = :PRV AND FLD_CODCDS = :CDS';
    qry.ParamByName('PRV').AsString := NomePrv;
    qry.ParamByName('CDS').AsString := qryCds.FieldByName('CDS_NOMCDS').AsString;
    qry.ExecSQL;
  finally
    FreeAndNil(qry);
  end;

  qryCds.Delete;
  pAjustaBotoes;
end;

procedure TfrmImpNfdCds.btnFieldsClick(Sender: TObject);
var
  frm: TfrmImpNfdFields;
  strNomCds: String;
begin
  if (not fTemRegistro) or fEmEdicao then
    Exit;

  strNomCds := qryCds.FieldByName('CDS_NOMCDS').AsString;

  frm := TfrmImpNfdFields.Create(nil);
  try
    frm.NomePrv := NomePrv;
    frm.NomeCds := strNomCds;
    frm.Origem  := UpperCase(Trim(qryCds.FieldByName('CDS_ORIGEM').AsString));
    if FblnModeloNovo then
      frm.CamBas := Trim(qryCds.FieldByName('CDS_CAMBAS').AsString);
    frm.ShowModal;
  finally
    FreeAndNil(frm);
  end;

  // o SELECT pode ter sido alterado na tela de fields (origem Banco)
  pAbrir(strNomCds);
end;

procedure TfrmImpNfdCds.btnFecharClick(Sender: TObject);
begin
  Close;
end;

end.
