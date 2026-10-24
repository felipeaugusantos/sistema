unit untFatReqCompraSelItemVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Data.DB, Vcl.Grids,DBGridCitel, Vcl.DBGrids,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, untZClient, Uni, UniClientDataSet;


type
  TResultSelecionarDescricao = (trItemNaoEncontradoNoPedido, trNaoSelecionado, trSelecionado);

type
  TfrmFatReqCompraSelItemEspecialVenda = class(TfrmPai)
    dbgItem: TDBGridCitel;
    dtsDados: TDataSource;
    BitBtnLocked1: TBitBtnLocked;
    procedure dbgItemDblClick(Sender: TObject);
    procedure dbgItemDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure BitBtnLocked1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgItemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
  private
    cdsDados: TZClient;
    strCodCli,
    strCodIte,
    strNumDoc,
    strEspDoc,
    strCodEmp: String;

    function fGetSql: String;
    procedure pCarregarItensPedido;
    procedure pMarcarDesmarcar(blnSelecionar: Boolean);overload;
    procedure pMarcarDesmarcar;overload;
    procedure pConfirmar;

    procedure pcdsDadosBeforeInsert(DataSet: TDataSet);
    { Private declarations }
  public
    constructor CriarNovo(AOwner: TComponent; pstrCodIte, pstrCodCli, pstrNumDoc, pstrEspDoc, pstrCodEmp: String);
    function fObterDescricaoItemVenda(out pResultSelecionarDescricao: TResultSelecionarDescricao): String;overload;

    class function fObterDescricaoItemVenda(const pstrCodIte, pstrCodCli, pstrNumDoc, pstrEspDoc, pstrCodEmp: String; out pResultSelecionarDescricao: TResultSelecionarDescricao): String;overload;
    { Public declarations }
  end;


var
  frmFatReqCompraSelItemEspecialVenda: TfrmFatReqCompraSelItemEspecialVenda;

implementation
uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmSelItemEspecialVenda }


procedure TfrmFatReqCompraSelItemEspecialVenda.BitBtnLocked1Click(
  Sender: TObject);
begin
  inherited;
  pConfirmar
end;

constructor TfrmFatReqCompraSelItemEspecialVenda.CriarNovo(AOwner: TComponent;
  pstrCodIte, pstrCodCli, pstrNumDoc, pstrEspDoc, pstrCodEmp: String);
begin
  inherited Create(AOwner);

  Self.strCodIte := pstrCodIte;
  Self.strCodCli := pstrCodCli;
  Self.strNumDoc := pstrNumDoc;
  Self.strEspDoc := pstrEspDoc;
  Self.strCodEmp := pstrCodEmp;
  pCarregarItensPedido;
end;

procedure TfrmFatReqCompraSelItemEspecialVenda.dbgItemDblClick(Sender: TObject);

begin
  inherited;
  pMarcarDesmarcar;
end;

procedure TfrmFatReqCompraSelItemEspecialVenda.dbgItemDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
  Var
    lRect: TRect;
begin
  inherited;

  if cdsDados.FieldByName('SELECIONADO').AsString = '0' Then
    Exit;
  lRect := Rect;
  dbgItem.Canvas.Font.Color := clBlue;
  dbgItem.Canvas.FillRect(lRect);
  dbgItem.DefaultDrawColumnCell(lRect, DataCol, Column, State);
end;

procedure TfrmFatReqCompraSelItemEspecialVenda.dbgItemKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
  begin
    Key := 0;
    pMarcarDesmarcar;
  end;
end;

function TfrmFatReqCompraSelItemEspecialVenda.fGetSql: String;
begin
  Result := ' SELECT DISTINCT "0" AS SELECIONADO, D.FDO_CODITE, D.FDO_DESCRI ';
  Result := Result + ' FROM FATDOR D ';
  Result := Result + ' WHERE D.FDO_NUMDOC = :NUMDOC ';
  Result := Result + '    AND D.FDO_CODEMP = :CODEMP ';
  Result := Result + '    AND D.FDO_ESPDOC = :ESPDOC ';
  Result := Result + '    AND D.FDO_CODITE = :CODITE ';
  Result := Result + '    AND D.FDO_CODCLI = :CODCLI ';
end;

function TfrmFatReqCompraSelItemEspecialVenda.fObterDescricaoItemVenda(out pResultSelecionarDescricao: TResultSelecionarDescricao): String;
begin
  Result := EmptyStr;

  if cdsDados.IsEmpty then
  begin
    pResultSelecionarDescricao := TResultSelecionarDescricao.trItemNaoEncontradoNoPedido;
    Exit;
  end;

  if cdsDados.RecordCount = 1 then
    Result := cdsDados.FieldByName('FDO_DESCRI').AsString
  else begin
    Self.ShowModal;
    if ModalResult = mrOk then
    begin
      Result := cdsDados.FieldByName('FDO_DESCRI').AsString;
      pResultSelecionarDescricao := TResultSelecionarDescricao.trSelecionado;
    end
    else
      pResultSelecionarDescricao := TResultSelecionarDescricao.trNaoSelecionado;
  end;

end;

class function TfrmFatReqCompraSelItemEspecialVenda.fObterDescricaoItemVenda(
  const pstrCodIte, pstrCodCli, pstrNumDoc, pstrEspDoc, pstrCodEmp: String; out pResultSelecionarDescricao: TResultSelecionarDescricao): String;
begin
  frmFatReqCompraSelItemEspecialVenda := Nil;

  if Assigned(frmFatReqCompraSelItemEspecialVenda) then
      pFreeAndNil(frmFatReqCompraSelItemEspecialVenda);


  Try

    frmFatReqCompraSelItemEspecialVenda
      := TfrmFatReqCompraSelItemEspecialVenda.CriarNovo(Nil,
                                                     pstrCodIte,
                                                     pstrCodcli,
                                                     pstrNumDoc,
                                                     pstrEspDoc,
                                                     pstrCodEmp);


    Result := frmFatReqCompraSelItemEspecialVenda.fObterDescricaoItemVenda(pResultSelecionarDescricao);
  Finally
    pFreeAndNil(frmFatReqCompraSelItemEspecialVenda);
  End;

end;

procedure TfrmFatReqCompraSelItemEspecialVenda.FormDestroy(Sender: TObject);
begin
  if Assigned(cdsDados) then
    FreeAndNil(cdsDados);
  inherited;

end;

procedure TfrmFatReqCompraSelItemEspecialVenda.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_F10 then
  begin
    Key := 0;
    pConfirmar;
  end;
end;


procedure TfrmFatReqCompraSelItemEspecialVenda.pCarregarItensPedido;
begin

  cdsDados := TZClient.Create(Nil, fGetSql);
  cdsDados.qryQuery.ParamByName('NUMDOC').AsString := strNumDoc;
  cdsDados.qryQuery.ParamByName('CODEMP').AsString := strCodEmp;
  cdsDados.qryQuery.ParamByName('ESPDOC').AsString := strEspDoc;
  cdsDados.qryQuery.ParamByName('CODITE').AsString := strCodIte;
  cdsDados.qryQuery.ParamByName('CODCLI').AsString := strCodCli;
  cdsDados.fAbreClient(false,'TfrmFatReqCompraSelItemEspecialVenda.pCarregarItensPedido');
  cdsDados.BeforeInsert := pcdsDadosBeforeInsert;
  dtsDados.DataSet := cdsDados.dtsSource.DataSet;
end;

procedure TfrmFatReqCompraSelItemEspecialVenda.pcdsDadosBeforeInsert(
  DataSet: TDataSet);
begin
  Abort;
end;

procedure TfrmFatReqCompraSelItemEspecialVenda.pConfirmar;
begin
  cdsDados.DisableControls;
  cdsDados.Filtered := False;
  cdsDados.Filter := ' SELECIONADO = ''1'' ';
  cdsDados.Filtered := true;
  if cdsDados.IsEmpty then
  begin
    cdsDados.Filtered := False;
    cdsDados.Filter := EmptyStr;
    cdsDados.First;
    cdsDados.DisableControls;
    pMensagemOk('É obrigatório selecionar um item antes para confirmar!');
  end
  else
    ModalResult := mrOk;
end;

procedure TfrmFatReqCompraSelItemEspecialVenda.pMarcarDesmarcar;
  Var
    blnMarcar: boolean;
begin
  blnMarcar := cdsDAdos.FieldByname('SELECIONADO').AsString = '0';
  pMarcarDesmarcar(blnMarcar);
end;

procedure TfrmFatReqCompraSelItemEspecialVenda.pMarcarDesmarcar(
  blnSelecionar: Boolean);
  Var
    intRecNoSel: Integer;
begin
  if blnSelecionar then
    intRecNoSel := cdsDados.RecNo
  else
    intRecNoSel := -1;

  Try
    cdsDados.DisableControls;
    cdsDados.Filtered := False;
    cdsDados.Filter := ' SELECIONADO = ''1'' ';
    cdsDados.Filtered := true;
    cdsDados.First;
    While Not cdsDados.Eof do
    begin
      cdsDados.edit;
      cdsDados.Fieldbyname('SELECIONADO').AsString := '0';
      cdsDados.Post;
      cdsDados.Next;
    end;

    cdsDados.Filtered := False;
    cdsDados.Filter := EmptyStr;
    if (intRecNoSel >= 1) and blnSelecionar then
    begin
      cdsDados.RecNo := intRecNoSel;
      cdsDados.edit;
      cdsDados.Fieldbyname('SELECIONADO').AsString := '1';
      cdsDados.Post;
    end;
  Finally
    cdsDados.EnableControls;
  end;
end;

end.


