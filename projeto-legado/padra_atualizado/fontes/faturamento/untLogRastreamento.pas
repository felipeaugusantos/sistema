unit untLogRastreamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, EditFocus, Uni;

type
  TfrmLogRastreamento = class(TfrmPai)
    Panel1: TPanel;
    grdDadosTv: TcxGridDBTableViewCitel;
    grdDadosLvl: TcxGridLevel;
    grdDados: TcxGridCitel;
    edtDtaEnt: TEditFocus;
    Label1: TLabel;
    edtDocVen: TEditFocus;
    Label2: TLabel;
    edtPesBru: TEditFocus;
    Label3: TLabel;
    edtVrDoc: TEditFocus;
    Label4: TLabel;
    edtCodCli: TEditFocus;
    Label5: TLabel;
    edtCidade: TEditFocus;
    Label6: TLabel;
    edtNomCli: TEditFocus;
    dtsDados: TDataSource;
    grdDadosTvDTHREN: TcxGridDBColumn;
    grdDadosTvNUMROM: TcxGridDBColumn;
    grdDadosTvEMPORI: TcxGridDBColumn;
    grdDadosTvDTHRRE: TcxGridDBColumn;
    grdDadosTvEMPDES: TcxGridDBColumn;
    grdDadosTvOPEREC: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FqryTransbordo: TUniQuery;

    function fSqlTransbordo: String;
  public
    { Public declarations }
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
  end;

implementation

{$R *.dfm}

uses
  untFuncoesSimples;

procedure TfrmLogRastreamento.FormCreate(Sender: TObject);
begin
  inherited;
  FqryTransbordo := fCriaQuery;
  dtsDados.DataSet := FqryTransbordo;
end;

procedure TfrmLogRastreamento.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FqryTransbordo);
end;

procedure TfrmLogRastreamento.FormShow(Sender: TObject);
begin
  inherited;
  FqryTransbordo.SQL.Text := fSqlTransbordo;

  FqryTransbordo.ParamByName('NUMDOC').AsString := strNumDoc;
  FqryTransbordo.ParamByName('ESPDOC').AsString := strEspDoc;
  FqryTransbordo.ParamByName('CODEMP').AsString := strCodEmp;
  FqryTransbordo.Open;

  TDateTimeField(FqryTransbordo.FieldByName('TRA_DTHREN')).DisplayFormat := 'dd/MM/yyyy hh:nn:ss';
  TDateTimeField(FqryTransbordo.FieldByName('TRA_DTHRRE')).DisplayFormat := 'dd/MM/yyyy hh:nn:ss';
  grdDadosTv.ApplyBestFit();
end;

function TfrmLogRastreamento.fSqlTransbordo: String;
begin
  Result := '';
  Result := Result + 'SELECT ROMTRAX.AUTOINCREM, ';
  Result := Result + '       TIMESTAMP(TRA_DTATRA, TRA_HRATRA) AS TRA_DTHREN, ';
  Result := Result + '       GER_NUMROM, ';
  Result := Result + '       TRA_EMPORI, ';
  Result := Result + '       TRA_EMPDES, ';
  Result := Result + '       TIMESTAMP(TRA_DTAREC, TRA_HRAREC) AS TRA_DTHRRE, ';
  Result := Result + '       CONCAT(TRA_OPEREC, " - ", OPE_NOMOPE) AS OPEREC ';
  Result := Result + '  FROM ROMTRAX ';
  Result := Result + ' INNER JOIN ROMGERX ON ROMGERX.AUTOINCREM = TRA_SEQGER ';
  Result := Result + '  LEFT JOIN CADOPE  ON TRA_OPEREC = OPE_CODOPE ';
  Result := Result + 'WHERE GER_NUMDOC = :NUMDOC ';
  Result := Result + '  AND GER_ESPDOC = :ESPDOC ';
  Result := Result + '  AND GER_CODEMP = :CODEMP ';
  Result := Result + 'ORDER BY TIMESTAMP(TRA_DTATRA, TRA_HRATRA) ';
end;

end.
