unit untFatManConsertoAlteraTecnico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Data.DB, Vcl.StdCtrls,
  EditFocus, Vcl.Grids, Vcl.DBGrids, DBGridCitel, frxClass, Vcl.AppEvnts, 
  frxExportCSVTestabilidade, Vcl.Menus, Vcl.Buttons, BitBtnLockedIncrem, UITypes,
  Vcl.ExtCtrls, Uni, untLiberacao, untConsertoEquipamento, untMsgLiberacao;

type
  TfrmFatManConsertoAlteraTecnico = class(TfrmPaiConfirma)
    dbgServico: TDBGridCitel;
    pnlTecnico: TPanel;
    pnlBottom: TPanel;
    edtNomTec: TEditFocus;
    edtCodTec: TEditFocus;
    Label11: TLabel;
    dtsSerEqu: TDataSource;
    procedure edtCodTecKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgServicoDblClick(Sender: TObject);
    procedure dbgServicoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgServicoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    stlSelecionados: TStringList;
    procedure pMarcaDesmarca;
    procedure pDesmarcarTudo;
    procedure pAtualizaTecServico;
    function fInLista: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnAtualizou: Boolean;
    objConEqu: TConEqu;
    objLiberacao : TLiberacao;
  end;

implementation

uses
  untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmFatManConsertoAlteraTecnico.btnConfirmaClick(Sender: TObject);
var
  intCont  : Integer;
  strCodMar,
  strVoltag: String;
  blnAtuali: Boolean;
  objLinha : TLinhaMsgLibera;
  objTabela: TRegistroMsgLiberaTabela;
begin
  if not fValidaCampos(edtCodTec, True) then
    Exit;

  if (stlSelecionados.Count = 0) then
  begin
    fMensagem('Atenção', 'Selecione os serviços que terão o técnico alterado!', ['&Ok']);
    Exit;
  end;

  blnAtuali := False;
  strCodMar := fCampoTabela('EQU_CODMAR', 'CADEQU', ['EQU_CODIGO'], [objConEqu.strCodEqu], False);
  strVoltag := fCampoTabela('EQU_VOLTAG', 'CADEQU', ['EQU_CODIGO'], [objConEqu.strCodEqu], False);
  
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Alteração de técnico na Ordem de Serviço');
  objLiberacao.objMsgLibera.pAddSeparador(75);
  objLiberacao.objMsgLibera.pAddTextoCaption('Número OS', objConEqu.strNumero + ' - Empresa: ' + objConEqu.strCodEmp + ' - ' + fRetNomeEmpresaSelec(objConEqu.strCodEmp), 13);
  objLiberacao.objMsgLibera.pAddTextoCaption('Equipamento', objConEqu.strCodEqu + ' - ' + fRetNomEquipamentoOS(objConEqu.strCodEqu), 13);
  objLiberacao.objMsgLibera.pAddTextoCaption('Marca', fRetNomMarca(strCodMar) + '     Voltagem: ' + strVoltag, 13);

  objTabela := TRegistroMsgLiberaTabela.Create;
  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'SERVIÇO'      , 50, alEsquerda, teAutcom);
  objLinha.pAddColuna(''  , 'TÉCNICO ATUAL', 30, alEsquerda, teAutcom);
  objLinha.pAddColuna(''  , 'NOVO TÉCNICO' , 30, alEsquerda, teAutcom);
  objTabela.lstLinhas.Add(objLinha);
  
  for intCont := 0 to Pred(stlSelecionados.Count) do
  begin
    if objConEqu.cdsSerEqu.Locate('AUTINC', stlSelecionados[intCont], []) then
    begin
      if (edtCodTec.Text <> objConEqu.cdsSerEqu.FieldByName('TECSER').AsString) then
      begin
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('SERVIÇO'      , objConEqu.cdsSerEqu.FieldByName('CODSER').AsString + ' - ' + objConEqu.cdsSerEqu.FieldByName('DESSER').AsString, 50, alEsquerda);
        objLinha.pAddColuna('TÉCNICO ATUAL', objConEqu.cdsSerEqu.FieldByName('CODDES').AsString, 30, alEsquerda);
        objLinha.pAddColuna('NOVO TÉCNICO' , edtCodTec.Text + ' - ' + edtNomTec.Text, 30, alEsquerda);
        objTabela.lstLinhas.Add(objLinha);

        blnAtuali := True;
      end;
    end;
  end;
  
  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
  objLiberacao.strDirAce := 'CEQALT';
  objLiberacao.strMsgSen := 'Alteração de Técnico na Ordem de Serviço';
  objLiberacao.blnMosMen := True;
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;

  if blnAtuali then
  begin
    if not objLiberacao.fLibera then
      Exit;

    blnAtualizou := True;
    pAtualizaTecServico;
  end;

  Close;
end;

procedure TfrmFatManConsertoAlteraTecnico.dbgServicoDblClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarca;
end;

procedure TfrmFatManConsertoAlteraTecnico.dbgServicoDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  if (dbgServico.DataSource.DataSet.FieldByName('MARDES').AsString = '1') then
  begin
    if dbgServico.Canvas.Brush.Color = clHighLight then
      dbgServico.Canvas.Font.Color := clHighLightText
    else
      dbgServico.Canvas.Brush.Color := clAqua;
  end;

  dbgServico.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmFatManConsertoAlteraTecnico.dbgServicoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Key = #13) then
    pMarcaDesmarca;
end;

procedure TfrmFatManConsertoAlteraTecnico.edtCodTecKeyPress(Sender: TObject;
  var Key: Char);
var
  qryCons: TUniQuery;
  arrSel : TConsultasArray;
begin
  inherited;

  if fEntraCons(Key) then
  Begin
    qryCons := fCriaQuery(nil);

    try
      if fPesqOperador(Self, edtCodTec, edtNomTec, qryCons, Key, arrSel) then
      begin
        if (fValidaCampos(edtCodTec, True)) then
          Self.SelectNext(ActiveControl, True, True);
      end;
    finally
      FreeAndNil(qryCons);
    end;
  end;
end;

function TfrmFatManConsertoAlteraTecnico.fInLista: Boolean;
begin
  Result := stlSelecionados.IndexOf(objConEqu.cdsSerEqu.FieldByName('AUTINC').AsString) > -1;
end;

procedure TfrmFatManConsertoAlteraTecnico.FormCreate(Sender: TObject);
begin
  inherited;
  stlSelecionados := TStringList.Create;
  stlSelecionados.Clear;
  blnAtualizou := False;
end;

procedure TfrmFatManConsertoAlteraTecnico.FormDestroy(Sender: TObject);
begin
  inherited;
  dtsSerEqu.DataSet := Nil;
  FreeAndNil(stlSelecionados);
end;

procedure TfrmFatManConsertoAlteraTecnico.FormShow(Sender: TObject);
begin
  inherited;
  pDesmarcarTudo;
  dtsSerEqu.DataSet := objConEqu.cdsSerEqu;
end;

function TfrmFatManConsertoAlteraTecnico.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if (Sender = edtCodTec) and blnBuscaPorChave then
  begin
    if fEmptyStr(edtCodTec.Text) then
    begin
      fMensagem('AVISO', 'Informe o novo técnico!', ['&Ok']);
      Result := False;
    end
    else
    begin
      edtNomTec.Text := fRetNomeOperador(edtCodTec.Text);

      if fEmptyStr(edtNomTec.Text) then
      begin
        fMensagem('AVISO', 'Técnico não encontrado!', ['&Ok']);
        Result := False;
      end;
    end;
  end;
end;

procedure TfrmFatManConsertoAlteraTecnico.pAtualizaTecServico;
var
  intCont: Integer;
begin
  for intCont := 0 to Pred(stlSelecionados.Count) do
  begin
    if objConEqu.cdsSerEqu.Locate('AUTINC', stlSelecionados[intCont], []) then
    begin
      objConEqu.cdsSerEqu.Edit;
      objConEqu.cdsSerEqu.FieldByName('TECSER').AsString := edtCodTec.Text;
      objConEqu.cdsSerEqu.FieldByName('CODDES').AsString := edtCodTec.Text + ' - ' + edtNomTec.Text;
      objConEqu.cdsSerEqu.Post;
    end;
  end;
end;

procedure TfrmFatManConsertoAlteraTecnico.pDesmarcarTudo;
begin
  objConEqu.cdsSerEqu.First;

  while not objConEqu.cdsSerEqu.Eof do
  begin
    objConEqu.cdsSerEqu.Edit;
    objConEqu.cdsSerEqu.FieldByName('MARDES').AsInteger := 0;
    objConEqu.cdsSerEqu.Post;

    objConEqu.cdsSerEqu.Next;
  end;

  objConEqu.cdsSerEqu.First;
end;

procedure TfrmFatManConsertoAlteraTecnico.pMarcaDesmarca;
begin
  objConEqu.cdsSerEqu.Edit;

  if (objConEqu.cdsSerEqu.FieldByName('MARDES').AsInteger = 0) then
  begin
    objConEqu.cdsSerEqu.FieldByName('MARDES').AsInteger := 1;

    if (not fInLista) then
      stlSelecionados.Add(objConEqu.cdsSerEqu.FieldByName('AUTINC').AsString);
  end
  else
  begin
    objConEqu.cdsSerEqu.FieldByName('MARDES').AsInteger := 0;

    if (fInLista) then
      stlSelecionados.Delete(stlSelecionados.IndexOf(objConEqu.cdsSerEqu.FieldByName('AUTINC').AsString));
  end;

  objConEqu.cdsSerEqu.Post;
end;

end.
