unit Contabilidade.View.ContasContabeisPorPlanoReferencial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiConfirmaContabilidade, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Data.DB, MemDS, DBAccess, Uni, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, cxTextEdit,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, untTypesSistema, cxContainer,
  cxLabel;

type
  TfrmContasContabeisPorPlanoReferencial = class(TfrmPaiConfirmaContabilidade)
    Gridtab: TcxGridDBTableViewCitel;
    GridCitelLevel1: TcxGridLevel;
    GridCitel: TcxGridCitel;
    dsConsulta: TDataSource;
    GridtabNCO_CODCON: TcxGridDBColumn;
    GridtabNCO_DESCRI: TcxGridDBColumn;
    FDMemPlanco: TFDMemTable;
    FDMemPlancoNCO_CODCON: TStringField;
    FDMemPlancoNCO_DESCRI: TStringField;
    FDMemPlancoNCO_CTAREF: TStringField;
    GridtabNCO_CTAREF: TcxGridDBColumn;
    StyleRepository: TcxStyleRepository;
    EstiloTemContaRef: TcxStyle;
    pnlInfoCores: TPanel;
    teOrigemPlanco: TcxTextEdit;
    lbOrigemPlanco: TcxLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GridtabKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure GridtabStylesGetContentStyle(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      var AStyle: TcxStyle);
    procedure FDMemPlancoAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    FarrSel : TConsultasArray ;
    FstrCodigoContas : string ;
    FblnPlanoReferencial : boolean ;
    qryConsulta : TUniQuery ;
    qryPlanco : TUniQuery ;
    procedure pCarregaContasContabeis(strCodigos:string);
    procedure pCarregaPlanco;
    function fRetornaPlancoByCodigo(strCodigo:string):string ;
    function fRetornaPlancoGrid:TStringList ;
    procedure SetstrCodigoContas(const Value: string);
  public
    { Public declarations }
    property strCodigoContas : string  read FstrCodigoContas write SetstrCodigoContas;
    property arrSel : TConsultasArray read FarrSel;
    property blnPlanoReferencial : boolean read FblnPlanoReferencial write FblnPlanoReferencial ;
  end;

implementation

uses untFuncoesSimples, Contabilidade.Consultas, Contabilidade.Funcoes ;

{$R *.dfm}

{ TfrmContasContabeisPorPlanoReferencial }

procedure TfrmContasContabeisPorPlanoReferencial.btnConfirmaClick(
  Sender: TObject);
begin
  /////carrega o array do retorno
  SetLength(FarrSel, 0);
  FDMemPlanco.DisableControls ;
  try
    FDMemPlanco.First ;
    while not FDMemPlanco.Eof do
    begin
      SetLength(FarrSel, Length(FarrSel)+1);
      FarrSel[High(FarrSel)].strCodigo := FDMemPlanco.FieldByName('NCO_CODCON').AsString ;
      FDMemPlanco.Next ;
    end;
  finally
    FDMemPlanco.EnableControls ;
  end;
  inherited;

end;

procedure TfrmContasContabeisPorPlanoReferencial.FDMemPlancoAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  if FblnPlanoReferencial then
  begin
    Gridtab.OptionsData.Deleting := fEmptyStr(DataSet.FieldByName('NCO_CTAREF').AsString) ;
  end;
end;

procedure TfrmContasContabeisPorPlanoReferencial.FormCreate(Sender: TObject);
begin
  inherited;
  FstrCodigoContas := '-1' ;
  qryConsulta := fCriaQuery(self) ;
  FDMemPlanco.CreateDataSet ;
  qryPlanco := fCriaQuery(self) ;
  pnlInfo.Caption := 'Tecle / para adicionar ou DEL para excluir contas na fórmula!' ;
  teOrigemPlanco.Style.Color := EstiloTemContaRef.Color ;
end;

procedure TfrmContasContabeisPorPlanoReferencial.FormDestroy(Sender: TObject);
begin
  inherited;
  qryConsulta.Close ;
  FreeAndNil(qryConsulta) ;
  qryPlanco.Close ;
  FreeAndNil(qryPlanco) ;
end;

procedure TfrmContasContabeisPorPlanoReferencial.FormShow(Sender: TObject);
begin
  inherited;
  teOrigemPlanco.Visible := FblnPlanoReferencial ;
  lbOrigemPlanco.Visible := FblnPlanoReferencial ;

  pCarregaPlanco;
  pCarregaContasContabeis(FstrCodigoContas);
end;

function TfrmContasContabeisPorPlanoReferencial.fRetornaPlancoByCodigo(
  strCodigo: string): string;
begin
  result := '' ;
  if qryPlanco.Locate('NCO_CODCON', strCodigo, [loCaseInsensitive]) then
    result := qryPlanco.FieldByName('NCO_DESCRI').AsString ;
end;

function TfrmContasContabeisPorPlanoReferencial.fRetornaPlancoGrid: TStringList;
var
  intCnt1 : integer ;
  intColCodigo : integer ;
  varCodigo : variant ;
begin
  result := TStringList.Create ;
  result.Sorted := true ;

  intColCodigo := GridtabNCO_CODCON.Index ;
  for intCnt1 := 0 to GridTab.ViewData.RecordCount-1 do
  begin
    if not GridTab.ViewData.Records[intCnt1].HasCells then
      exit ;

    varCodigo := GridTab.ViewData.Records[intCnt1].Values[intColCodigo] ;
    if VarIsNull(varCodigo) then
      exit ;

    result.Add(vartostr(varCodigo)) ;

  end;
end;

procedure TfrmContasContabeisPorPlanoReferencial.GridtabKeyPress(
  Sender: TObject; var Key: Char);
var
  arrSel : TConsultasArray;
  intCnt : integer ;
  lstExists : TStringList ;
begin
  inherited;
  if key = '/' then
  begin
    If fPesqPlanoContabilEcf(Self, Nil, Nil, Nil, Key, arrSel, False, '', FblnPlanoReferencial) Then
    Begin
      key := #0 ;

      lstExists := fRetornaPlancoGrid ;
      try
        for intCnt := Low(arrSel) to High(arrSel) do
        begin
          if lstExists.IndexOf(arrSel[intCnt].strCodigo) < 0 then
          begin
            FDMemPlanco.Append ;
            FDMemPlanco.FieldByName('NCO_CODCON').AsString := arrSel[intCnt].strCodigo ;
            FDMemPlanco.FieldByName('NCO_DESCRI').AsString := fRetornaPlancoByCodigo(arrSel[intCnt].strCodigo) ;
            FDMemPlanco.Post ;
          end;
        end;
      finally
        lstExists.Free ;
      end;

    End;
  end;
end;

procedure TfrmContasContabeisPorPlanoReferencial.GridtabStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
Var
  ARowInfo: TcxRowInfo;
begin
  inherited;
  If ARecord.IsData Then
  begin
    if FblnPlanoReferencial then
    begin
      if ARecord.Index > -1 then
      begin
        ARowInfo := GridTab.DataController.GetRowInfo(ARecord.Index);

        If not fEmptyStr(VarToStr(GridTab.DataController.Values[ARowInfo.RecordIndex,
                           GridTab.GetColumnByFieldName('NCO_CTAREF').Index])) Then
        Begin
          AStyle := EstiloTemContaRef;
        End;
      end;
    end;
  end;
end;

procedure TfrmContasContabeisPorPlanoReferencial.pCarregaContasContabeis(
  strCodigos: string);
var
  strSql : string ;
  strTplaco : string ;
begin
  strTplaco := fRetTplacoEmpresaLogada ;
  strSql := '' ;
  strSql := strSql + ' SELECT NCO_CODCON, NCO_DESCRI, NCO_CTAREF ' ;
  strSql := strSql + ' FROM PLANCO ' ;
  strSql := strSql + ' WHERE NCO_CODCON IN ('+strCodigos+') AND NCO_TPLACO = ' + strTplaco.QuotedString ;

  qryConsulta.Close ;
  qryConsulta.SQL.Clear ;
  qryConsulta.SQL.Add(strSql) ;
  qryConsulta.Open ;
  qryConsulta.First ;

  ////carrega os dados na fdmem para ser manipulados pelo usuário[
  qryConsulta.DisableControls ;
  FDMemPlanco.DisableControls ;
  try
    while not qryConsulta.Eof do
    begin
      FDMemPlanco.Append ;
      FDMemPlanco.FieldByName('NCO_CODCON').AsString := qryConsulta.FieldByName('NCO_CODCON').AsString ;
      FDMemPlanco.FieldByName('NCO_DESCRI').AsString := qryConsulta.FieldByName('NCO_DESCRI').AsString ;
      FDMemPlanco.FieldByName('NCO_CTAREF').AsString := qryConsulta.FieldByName('NCO_CTAREF').AsString ;
      FDMemPlanco.Post ;
      qryConsulta.Next ;
    end;
  finally
    qryConsulta.EnableControls ;
    FDMemPlanco.EnableControls ;
  end;


end;

procedure TfrmContasContabeisPorPlanoReferencial.pCarregaPlanco;
var
  strSql : string ;
  strTplaco : string ;
begin
  strTplaco := fRetTplacoEmpresaLogada ;

  strSql := '' ;
  strSql := strSql + ' SELECT NCO_CODCON, NCO_DESCRI ' ;
  strSql := strSql + ' FROM PLANCO  WHERE NCO_TPLACO = ' + strTplaco.QuotedString ;
  strSql := strSql + ' ORDER BY NCO_CODCON ' ;

  qryPlanco.Close ;
  qryPlanco.SQL.Clear ;
  qryPlanco.SQL.Add(strSql) ;
  qryPlanco.Open ;
  qryPlanco.First ;
end;

procedure TfrmContasContabeisPorPlanoReferencial.SetstrCodigoContas(
  const Value: string);
var
  lstTrata : TStringList ;
  intCnt : integer ;
  strTratado : string ;
begin
  lstTrata := TStringList.Create ;
  try
    lstTrata.StrictDelimiter := True ;
    lstTrata.Delimiter := ',' ;
    lstTrata.DelimitedText := value ;
    strTratado := '' ;
    for intCnt := 0 to lstTrata.Count-1 do
    begin
      if strTratado = '' then
      begin
        strTratado := quotedstr(lstTrata.Strings[intCnt]) ;
      end
      else
      begin
        strTratado := strTratado + ',' + quotedstr(lstTrata.Strings[intCnt]) ;
      end;
    end;
  finally
    lstTrata.Free ;
  end;
  FstrCodigoContas := strTratado;
end;

end.
