unit untQckRelFatReciboAvulso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, frxDMPExport, Uni, frxDBSet;

type
  TfrmQckRelFatReciboAvulso = class(TForm)
    frxDotMatrixExport: TfrxDotMatrixExport;
    frxGen: TfrxUserDataSet;
    frxDBDatasetCTPDET: TfrxUserDataSet;
    frxReportM: TfrxReport;
    frxReportJ: TfrxReport;
    procedure frxGenGetValue(const VarName: string; var Value: Variant);
    procedure frxDBDatasetCTPDETCheckEOF(Sender: TObject; var Eof: Boolean);
    procedure frxDBDatasetCTPDETGetValue(const VarName: string; var Value: Variant);
    procedure frxDBDatasetCTPDETFirst(Sender: TObject);
    procedure frxDBDatasetCTPDETNext(Sender: TObject);
    procedure frxDBDatasetCTPDETPrior(Sender: TObject);
    function fRetornaValor(strCampo_, strVarNom, strValor_, strPadrao : String) : String;
  private
    { Private declarations }
  public
    { Public declarations }
    strCodOpe: String;
    strNomOpe: String;
    strDados : String;
    strCodEmp: String;
    dtaDatCad: TDateTime;
    horHorCad: TDateTime;
    intSeqCon: Integer;
    strTipImp: String;
    intQtdVia: Integer;
    strQtdVia: String;
    strNomEmp: String;
    strNumTel: String;
    strNomCid: String;
    strNomEnd: String;
    strNomBai: String;
    strNumCep: String;
    strNumCNPJ : String;
    strValRec: String;
    strNomRec: String;
    strVlrExt: String;
    //strHisRec: String;
    strDtaRec: String;
    strNomAss: String;
    strNroVia: String;
    strCgcCpf: String;
    strCodCli: String;
    strEndNro: String;
    strEndCid: String;
  end;

var
  frmQckRelFatReciboAvulso: TfrmQckRelFatReciboAvulso;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmQckRelFatReciboAvulso.frxGenGetValue(const VarName: string; var Value: Variant);
  Var
    qryCadEmp: TUniQuery;
begin

  Try
    qryCadEmp := fCriaQuery;

    qryCadEmp.Close;
    qryCadEmp.SQL.Clear;
    qryCadEmp.SQL.Add('SELECT ');
    qryCadEmp.SQL.Add('  EMP_NOMEMP NOMEMP, ');
    qryCadEmp.SQL.Add('  CID_NOMCID NOMCID, ');
    qryCadEmp.SQL.Add('  CID_ESTADO ESTADO, ');
    qryCadEmp.SQL.Add('  EMP_FONE01 FONE01,  ');
    qryCadEmp.SQL.Add('  EMP_C_G_C_ NUMCNPJ, ');
    qryCadEmp.SQL.Add('  EMP_ENDNUM NUMEND   ');
    qryCadEmp.SQL.Add('FROM ');
    qryCadEmp.SQL.Add('  CADEMP ');
    qryCadEmp.SQL.Add('  LEFT JOIN CADCID ON CID_CODCID = EMP_CODCID ');
    qryCadEmp.SQL.Add('WHERE ');
    qryCadEmp.SQL.Add('  LOCATE(EMP_CODEMP, :CODEMP) ');
    qryCadEmp.ParamByName('CODEMP').AsString := strCodEmp;
    qryCadEmp.Open;

    qryCadEmp.Close;

  Finally
    FreeAndNil(qryCadEmp);
  End;

end;

function TfrmQckRelFatReciboAvulso.fRetornaValor(strCampo_, strVarNom, strValor_, strPadrao : String) : String;
begin
  Result := strPadrao;
  If SameText(strCampo_, strVarNom) Then
    Result := strValor_;
end;

procedure TfrmQckRelFatReciboAvulso.frxDBDatasetCTPDETCheckEOF(Sender: TObject;
  var Eof: Boolean);
begin
  Eof := intQtdVia > StrToIntDef(strQtdVia, 0);
end;

procedure TfrmQckRelFatReciboAvulso.frxDBDatasetCTPDETFirst(Sender: TObject);
begin
  intQtdVia := 1;
end;

procedure TfrmQckRelFatReciboAvulso.frxDBDatasetCTPDETGetValue(const VarName: string;
  var Value: Variant);
   Var
     strEndCli : String;
begin
  strEndCli :=  VarToStrDef(fCampoTabela('CLI_ENDERE', 'CADCLI',
                                        ['CLI_CODCLI'],
                                        [strCodCli]), '');

  strEndCli := IIF( fEmptyStr(strEndCli), '', strEndCli + ', ');

  if Value = Null then
    Value := '';
  Value := fRetornaValor('DTAREC',  VarName, strDtaRec, Value);
  Value := fRetornaValor('VALREC',  VarName, 'R$ '+strValRec, Value);
  Value := fRetornaValor('NOMREC',  VarName, strNomRec, Value);
  Value := fRetornaValor('NOMASS',  VarName, strNomAss, Value);
  //Value := fRetornaValor('HISREC', VarName, strHisRec, Value);
  Value := fRetornaValor('NROVIA',  VarName, '- ( '+IntToStr(intQtdVia)+'a. Via ) -', Value);
  Value := fRetornaValor('VLREXT',  VarName, strVlrExt, Value);
  Value := fRetornaValor('CGCCPF',  VarName, strCgcCpf, Value);
  Value := fRetornaValor('NOMEMP',  VarName, strNomEmp, Value);
  Value := fRetornaValor('NUMTEL',  VarName, strNumTel, Value);
  Value := fRetornaValor('NOMCID',  VarName, strNomCid, Value);
  Value := fRetornaValor('NOMEND',  VarName, strNomEnd, Value);
  Value := fRetornaValor('NOMBAI',  VarName, strNomBai, Value);
  Value := fRetornaValor('NUMCEP',  VarName, strNumCep, Value);
  Value := fRetornaValor('CLICPF',  VarName, fRetCgcCpf(strCodCli), Value);
  Value := fRetornaValor('ENDCLI',  VarName, strEndCli, Value);
  Value := fRetornaValor('CLIEND',  VarName, strEndCli, Value);
  Value := fRetornaValor('CLINRO',  VarName, strEndNro, Value);
  Value := fRetornaValor('CLICID',  VarName, strEndCid, Value);
  Value := fRetornaValor('NUMCNPJ', VarName, strNumCnpj, Value);

end;

procedure TfrmQckRelFatReciboAvulso.frxDBDatasetCTPDETNext(Sender: TObject);
begin
  Inc(intQtdVia);
end;

procedure TfrmQckRelFatReciboAvulso.frxDBDatasetCTPDETPrior(Sender: TObject);
begin
  Dec(intQtdVia);
end;

end.
