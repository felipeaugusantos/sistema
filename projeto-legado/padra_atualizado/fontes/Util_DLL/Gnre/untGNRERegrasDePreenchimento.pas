unit untGNRERegrasDePreenchimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Datasnap.DBClient,
  UniClientDataSet, MemDS, DBAccess, Uni, Datasnap.Provider, UniDataSetProvider,
  cxGridBandedTableView, cxGridDBBandedTableView, cxRadioGroup, cxTextEdit,
  cxCurrencyEdit, cxDropDownEdit, cxImageComboBox;

type
  TfrmGNRERegrasDePreenchimento = class(TfrmPai)
    pnlReader: TPanel;
    rdgReceita: TRadioGroup;
    dbgConsulta: TcxGrid;
    dbgConsultaDBView: TcxGridDBTableView;
    dbgConsultalevel: TcxGridLevel;
    rdgAmbiente: TRadioGroup;
    rdgVersao: TRadioGroup;
    dtsConsulta: TDataSource;
    dspConsulta: TUniDataSetProvider;
    qryConsulta: TUniQuery;
    cdsConsulta: TUniClientDataSet;
    dbgConsultaDBViewColumn1: TcxGridDBColumn;
    dbgConsultaDBViewColumn2: TcxGridDBColumn;
    dbgConsultaDBViewColumn3: TcxGridDBColumn;
    dbgConsultaDBViewColumn4: TcxGridDBColumn;
    dbgConsultaView: TcxGridDBBandedTableView;
    dbgConsultaViewColumn1: TcxGridDBBandedColumn;
    dbgConsultaViewColumn2: TcxGridDBBandedColumn;
    dbgConsultaViewColumn3: TcxGridDBBandedColumn;
    dbgConsultaViewColumn4: TcxGridDBBandedColumn;
    dbgConsultaViewColumn5: TcxGridDBBandedColumn;
    dbgConsultaViewColumn6: TcxGridDBBandedColumn;
    dbgConsultaViewColumn7: TcxGridDBBandedColumn;
    dbgConsultaViewColumn8: TcxGridDBBandedColumn;
    dbgConsultaViewColumn9: TcxGridDBBandedColumn;
    dbgConsultaViewColumn10: TcxGridDBBandedColumn;
    dbgConsultaViewColumn12: TcxGridDBBandedColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyleSelecao: TcxStyle;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    cxStyle4: TcxStyle;
    cxStyle5: TcxStyle;
    cxStyle6: TcxStyle;
    cxStyle7: TcxStyle;
    cxStyle8: TcxStyle;
    cxStyle9: TcxStyle;
    cxStyle10: TcxStyle;
    cxStyle11: TcxStyle;
    cxStyle12: TcxStyle;
    cxStyle13: TcxStyle;
    GridBandedTableViewStyleSheetUserFormat3: TcxGridBandedTableViewStyleSheet;
    cxStyle14: TcxStyle;
    cxStyle15: TcxStyle;
    cxStyle16: TcxStyle;
    cxStyleZebrado: TcxStyle;
    cxStyle18: TcxStyle;
    cxStyle19: TcxStyle;
    cxStyle20: TcxStyle;
    cxStyle21: TcxStyle;
    cxStyle22: TcxStyle;
    cxStyle23: TcxStyle;
    cxStyle24: TcxStyle;
    cxStyle25: TcxStyle;
    procedure cdsConsultaAfterPost(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure rdgReceitaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure pConsultar;
    function fGetSql: String;
    { Private declarations }
  public
    FApuracao: Boolean;
    FHomologacao: Boolean;
    { Public declarations }
  end;

var
  frmGNRERegrasDePreenchimento: TfrmGNRERegrasDePreenchimento;

implementation

uses
  untFuncoesSimples, untGravando;

{$R *.dfm}

procedure TfrmGNRERegrasDePreenchimento.btnSairClick(Sender: TObject);
begin
  If cdsConsulta.State = dsEdit Then
    cdsConsulta.Post;

  inherited;
end;

procedure TfrmGNRERegrasDePreenchimento.cdsConsultaAfterPost(DataSet: TDataSet);
begin
  inherited;
  cdsConsulta.ApplyUpdates(-1);
end;

function TfrmGNRERegrasDePreenchimento.fGetSql: String;
Begin
  Result := '';
  Result := Result + 'SELECT * FROM CFGGNR ';
  Result := Result + 'WHERE TRUE ';
  Result := Result +  ' AND CFG_GNRAPU = '+QuotedStr(IIF(FApuracao, 'S', 'N'));

  case rdgReceita.ItemIndex of
    0: Result := Result +  ' AND CFG_TIPREC = "ST" ';
    1: Result := Result +  ' AND CFG_TIPREC = "FCP" ';
    2: Result := Result +  ' AND CFG_TIPREC = "DIFAL" ';
  end;

  case rdgAmbiente.ItemIndex of
    0: Result := Result +  ' AND CFG_TIPAMB = "PRODUCAO" ';
    1: Result := Result +  ' AND CFG_TIPAMB = "HOMOLOGACAO" ';
  end;

  case rdgVersao.ItemIndex of
    0: Result := Result +  ' AND CFG_VERSAO = "1.00" ';
    1: Result := Result +  ' AND CFG_VERSAO = "2.00" ';
  end;

  Result := Result + 'ORDER BY CFG_ESTADO ';
End;

procedure TfrmGNRERegrasDePreenchimento.pConsultar;
begin
  If cdsConsulta.State = dsEdit Then
    cdsConsulta.Post;

  cdsConsulta.Close;

  qryConsulta.Close;
  qryConsulta.SQL.Text := fGetSql;
  qryConsulta.Open;

  If Assigned(dspConsulta.DataSet) Then
    pSetaClient(dspConsulta.DataSet);

  cdsConsulta.Open;

  If qryConsulta.isEmpty Then
    pMensagemOk('Nenhum documento foi encontrado com estes filtros!')
  Else
    pSetFocus(dbgConsulta);
end;

procedure TfrmGNRERegrasDePreenchimento.FormCreate(Sender: TObject);
var
  intCorZeb: Integer;
  intCorFun: Integer;
  intCorFon: Integer;
begin
  inherited;

  intCorZeb := strToIntDef(fCfgSis('CORZEB'), clMoneyGreen);
  intCorFun := strToIntDef(fCfgSis('CORFUN'), clMoneyGreen);
  intCorFon := strToIntDef(fCfgSis('CORFON'), clBlack);

  cxStyleZebrado.Color     := IIF(intCorZeb = -1, clMoneyGreen, intCorZeb);
  cxStyleSelecao.Color     := IIF(intCorFun = -1, clMoneyGreen, intCorFun);
  cxStyleSelecao.TextColor := IIF(intCorFon = -1, clBlack, intCorFon);
end;

procedure TfrmGNRERegrasDePreenchimento.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN then
  Begin
    If (ActiveControl Is TRadioGroup) Then
    Begin
      keybd_event(Vk_Tab,0, 0, 0);
      pConsultar;
    End;
  End;

  If Key = VK_ESCAPE then
    If btnSair.Enabled Then btnSair.Click;
end;

procedure TfrmGNRERegrasDePreenchimento.FormShow(Sender: TObject);
begin
  inherited;
  If FHomologacao Then
    rdgAmbiente.ItemIndex := 1;

  TfrmGravando.fExecutarModalA(pConsultar, 'Carregando . . .', '');
end;

procedure TfrmGNRERegrasDePreenchimento.rdgReceitaClick(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModalA(pConsultar, 'Carregando . . .', '');
end;

end.


