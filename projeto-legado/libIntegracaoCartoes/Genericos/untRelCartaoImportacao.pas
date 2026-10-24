unit untRelCartaoImportacao;

interface

uses
    
  SysUtils, Classes, frxClass, frxDBSet, DB,
  DBClient, frxExportPDF, frxExportXLS, frxExportCSV,
  ComObj, frxExportCSVTestabilidade, Windows, Graphics,
  untFuncoes, untIDataSet, Uni, frxRich;

type
  TfrmRelCartaoImportacao = class(TDataModule)
    frxInconsist: TfrxReport;
    frxRelatorio: TfrxDBDataset;
    cdsRelat: TClientDataSet;
    cdsRelatRED_NOMARQ: TStringField;
    cdsRelatRED_NUM_PV: TStringField;
    cdsRelatRED_NUM_RV: TStringField;
    cdsRelatRED_PARCEL: TStringField;
    cdsRelatRED_DTALAN: TDateField;
    cdsRelatRED_DTA_RV: TDateField;
    cdsRelatRED_TIPREG: TStringField;
    frxExportaXLS: TfrxXLSExport;
    frxExportaCSV: TfrxCSVExportTestabilidade;
    cdsRelatRED_VALLAN: TFloatField;
    frxPagina: TfrxReport;
    frxRichObject1: TfrxRichObject;
    frxInstrucoesML: TfrxReport;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    frxExportaPDF: TfrxPDFExport;

    procedure pAbreAjuda(strNomFor, strNomRel: String);
  end;

var
  frmRelCartaoImportacao: TfrmRelCartaoImportacao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TfrmRelCartaoImportacao.DataModuleCreate(Sender: TObject);
Var oleTestar: Variant;
    resFast:   TResourceStream;
begin
  frxExportaPDF := TfrxPDFExport.Create(Self);
  resFast := TResourceStream.Create(HInstance, 'RELATORIO', RT_RCDATA);
  frxInconsist.LoadFromStream(resFast);
  Try
    oleTestar := CreateOleObject('Excel.Application');
    oleTestar.quit;
  Except
    FreeAndNil(frxExportaXLS);
  End;
end;

procedure TfrmRelCartaoImportacao.pAbreAjuda(strNomFor, strNomRel: String);
Var
    strSQL   : String;
    qrySelRel: IDataSet;
    stmRelato: TStringStream;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT HLP_RELFR3 FROM CADHLP ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + ' HLP_NOMFOR=:NOMFOR AND HLP_NOMHLP=:NOMHLP ';

  qrySelRel := objFunctions.fGetDataSet;
  With qrySelRel Do
  Begin
    SQL := strSQL;
    ParamByName('NOMFOR').AsString := strNomFor;
    ParamByName('NOMHLP').AsString := strNomRel;
    Open;

    If RecordCount = 0 Then
      objFunctions.fIMensagem('','Registro de ajuda não encontrado!',['&OK'])
    Else
    Begin
      stmRelato := TStringStream.Create;
      stmRelato.WriteString(FieldByName('HLP_RELFR3').AsString);
      stmRelato.Position := 0;
      frxPagina.LoadFromStream(stmRelato);
      pExibirRelatorio(strNomFor, 'Registro de ajuda (' + strNomRel + ')', TReport.New(frxPagina));
      FreeAndNil(stmRelato);
    End;
  End;
end;

end.
