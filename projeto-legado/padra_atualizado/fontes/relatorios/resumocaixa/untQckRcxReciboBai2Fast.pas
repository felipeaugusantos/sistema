unit untQckRcxReciboBai2Fast;

interface

uses
  SysUtils, Classes, frxClass, frxDBSet, DB, DBClient, Uni, UniClientDataSet,
  Forms, frxDMPExport;

type
  TfrmQckReciboBai2Fast = class(TForm)
    frxRelatorio: TfrxDBDataset;
    frxCheques: TfrxDBDataset;
    frxRelReciboJ: TfrxReport;
    frxRelReciboSemChqJ: TfrxReport;
    cdsCadChq: TUniClientDataSet;
    cdsCadChqCHQ_CONCOR: TStringField;
    cdsCadChqCHQ_NUMCHQ: TStringField;
    cdsCadChqCHQ_NOMEMI: TStringField;
    cdsCadChqCHQ_C_G_C_: TStringField;
    cdsCadChqCHQ_DTAVEN: TDateField;
    cdsCadChqCHQ_VALCHQ: TFloatField;
    cdsCadChqCHQ_NUMAGE: TStringField;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    frxReciboColunaCtaReceber: TfrxReport;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    strCodOpe: String;
    intSeqCon: Integer;
    fltTotRec: Double;
    qryGenEmp: TUniQuery;

    cdsImpRec: TUniClientDataSet;
    intQtdReg : Integer;

    intQtdDocImp: Integer;
    intQtdCheImp: Integer;
    blnReimpr   : Boolean;
    frxRel      : TfrxReport;
  end;

var
  frmQckReciboBai2Fast: TfrmQckReciboBai2Fast;

implementation

{$R *.dfm}

{ TfrmQckReciboBai2Fast }

procedure TfrmQckReciboBai2Fast.DataModuleCreate(Sender: TObject);
  var
    intContador:integer;
begin
  {****************************************************}
  {*  DESABILITA OS BOTÕES SAVE, LOAD e EDIT DO FAST  *}
  {*11/05/2015**************************************RB*}
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin

    If (Self.Components[intContador] Is TfrxReport) Then
    Begin
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons :=
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons - [pbSave, pbLoad, pbEdit];
    End;
  End;

end;

end.
