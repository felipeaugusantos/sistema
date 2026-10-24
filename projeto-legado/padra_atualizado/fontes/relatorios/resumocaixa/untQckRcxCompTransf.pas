unit untQckRcxCompTransf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxClass, frxDBSet, frxDMPExport, Uni;

type
  TfrmQckRcxCompTransf = class(TForm)
    frxQckRcxCompTransf40Col_M: TfrxReport;
    frxDotMatrixExport: TfrxDotMatrixExport;
    frxGen: TfrxUserDataSet;
    frxQckRcxCompTransf40Col_J: TfrxReport;
    frxReport80M: TfrxReport;
    frxDBCheAvi: TfrxDBDataset;
    frxDBChePre: TfrxDBDataset;
    frxDBCarcre: TfrxDBDataset;
    frxReport80J: TfrxReport;
    frxUserDataSet: TfrxUserDataSet;
    frxQckRcxCompTransf40Col_Epson: TfrxReport;
    procedure frxGenGetValue(const VarName: String; var Value: Variant);
    procedure frxUserDataSetCheckEOF(Sender: TObject; var Eof: Boolean);
    procedure frxUserDataSetGetValue(const VarName: String;
      var Value: Variant);
    procedure frxUserDataSetNext(Sender: TObject);
    procedure frxUserDataSetFirst(Sender: TObject);
  private
    { Private declarations }
    intCont: Integer;
  public
    { Public declarations }
    strCodOpe: String;
    strNomOpe: String;
    strDados : String;
    strRecibo : String;
    strCodEmp: String;
    dtaDatCad: TDateTime;
    horHorCad: TDateTime;
    intSeqCon: Integer;
    strCaixa : String;

    CodigoEmpresaTrf,
    NomeEmpresaTrf,
    FoneEmpresaTrf,
    CidadeEmpresaTrf,
    UfEmpresaTrf: String;
  end;

var
  frmQckRcxCompTransf: TfrmQckRcxCompTransf;

implementation

uses untfuncoesSimples;

{$R *.dfm}

procedure TfrmQckRcxCompTransf.frxGenGetValue(const VarName: String; var Value: Variant);
  Var
    qryCadEmp: TUniQuery;
begin

  Try
    qryCadEmp := fCriaQuery;

    With qryCadEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ');
      SQL.Add('  EMP_NOMEMP NOMEMP, ');
      SQL.Add('  CID_NOMCID NOMCID, ');
      SQL.Add('  CID_ESTADO ESTADO, ');
      SQL.Add('  EMP_FONE01 FONE01  ');
      SQL.Add('FROM ');
      SQL.Add('  CADEMP ');
      SQL.Add('  LEFT JOIN CADCID ON CID_CODCID = EMP_CODCID ');
      SQL.Add('WHERE ');
      SQL.Add('  LOCATE(EMP_CODEMP, :CODEMP) ');
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      If VarName = 'NOMEMP' Then
        Value := FieldByName('NOMEMP').AsString

      Else If VarName = 'FONE01' Then
        Value := FieldByName('FONE01').AsString

      Else If VarName = 'CIDEMP' Then
        Value := fTiraCaracEspeciais(FieldByName('NOMCID').AsString) + '-' + fTiraCaracEspeciais(FieldByName('ESTADO').AsString)

      Else If VarName = 'OPERAD' Then
        Value := strCodOpe + '-' + strNomOpe

      Else If VarName = 'RESULT' Then
        Value := strDados

      Else If VarName = 'RECIBO' Then
        Value := strRecibo

      Else If VarName = 'SEQCON' Then
        Value := IntToStr(intSeqCon)

      Else If VarName = 'DTACAD' Then
        Value := dtaDatCad

      Else If VarName = 'HORCAD' Then
        Value := horHorCad

      Else If VarName = 'CAIXA' Then
        Value := strCaixa

      Else If VarName = 'CODEMPTRF' Then
        Value := CodigoEmpresaTrf

      Else If VarName = 'NOMEMPTRF' Then
        Value := NomeEmpresaTrf

      Else If VarName = 'FONEMPTRF' Then
        Value := FoneEmpresaTrf

      Else If VarName = 'CIDEMPTRF' Then
        Value := CidadeEmpresaTrf

      Else If VarName = 'ESTEMPTRF' Then
        Value := UfEmpresaTrf;

      Close;
    End;

  Finally
    FreeAndNil(qryCadEmp);
  End;

end;

procedure TfrmQckRcxCompTransf.frxUserDataSetCheckEOF(Sender: TObject;
  var Eof: Boolean);
begin
  eof := (intCont = 1);
end;

procedure TfrmQckRcxCompTransf.frxUserDataSetGetValue(
  const VarName: String; var Value: Variant);
begin
  Value := '';
end;

procedure TfrmQckRcxCompTransf.frxUserDataSetNext(Sender: TObject);
begin
  intCont := 1;
end;

procedure TfrmQckRcxCompTransf.frxUserDataSetFirst(Sender: TObject);
begin
  intCont := 0;
end;

end.

