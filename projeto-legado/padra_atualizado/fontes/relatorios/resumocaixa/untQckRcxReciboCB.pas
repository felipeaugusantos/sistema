unit untQckRcxReciboCB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  frxClass, frxDBSet, frxDMPExport, Dialogs, Uni;

type
  TfrmQckRcxReciboCB = class(TForm)
    frxDotMatrixExport: TfrxDotMatrixExport;
    frxGenRec: TfrxUserDataSet;
    frxQckRcxReciboCBM: TfrxReport;
    frxQckRcxReciboCBJ: TfrxReport;
    frxRelatorio: TfrxDBDataset;
    frxChePre: TfrxDBDataset;
    frxCheAvi: TfrxDBDataset;
    procedure frxGenRecGetValue(const VarName: String; var Value: Variant);
  private
    { Private declarations }
  public
    { Public declarations }
    strForPag: String;
  end;

var
  frmQckRcxReciboCB: TfrmQckRcxReciboCB;

implementation

uses  untfuncoesSimples;

{$R *.dfm}

procedure TfrmQckRcxReciboCB.frxGenRecGetValue(const VarName: String; var Value: Variant);
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
      SQL.Add('  EMP_NOMFAN NOMEMP, ');
      SQL.Add('  CID_NOMCID NOMCID, ');
      SQL.Add('  CID_ESTADO ESTADO, ');
      SQL.Add('  EMP_FONE01 FONE01  ');
      SQL.Add('FROM ');
      SQL.Add('  CADEMP ');
      SQL.Add('  LEFT JOIN CADCID ON CID_CODCID = EMP_CODCID ');
      SQL.Add('WHERE ');
      SQL.Add('  EMP_CODEMP = :CODEMP ');
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      If VarName = 'NOMEMP' Then
        Value := FieldByName('NOMEMP').AsString

      Else If VarName = 'FONE01' Then
        Value := FieldByName('FONE01').AsString

      Else If VarName = 'CIDEMP' Then
        Value := fTiraCaracEspeciais(FieldByName('NOMCID').AsString) + '-' + fTiraCaracEspeciais(FieldByName('ESTADO').AsString)

      Else If VarName = 'FORPAG' Then
        Value := strForPag;

      Close;
    End;

  Finally
    FreeAndNil(qryCadEmp);
  End;

end;

end.

