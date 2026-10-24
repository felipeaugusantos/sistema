unit untRelRcxResumoCaixaMod;

interface

uses
  SysUtils, Classes, frxClass, Forms,
  untRelRcxResumoCaixa, DB, UniClientDataSet, frxDBSet;

type
  TfrmRelRcxResumoCaixaMod = class(TForm)
    frxRelRcxResumoCaixaM: TfrxReport;
    frxRelRcxResumoCaixaJ: TfrxReport;
    frxTermoFechamento: TfrxReport;
    frxDataSetEmpresa: TfrxDBDataset;
    frxDataSetFechamentoCaixa: TfrxDBDataset;
    frxTermoFechamento40c: TfrxReport;
    frxRelatorio_RelRcx: TfrxDBDataset;
    frxGen_RelRcx: TfrxUserDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure frxRelRcxResumoCaixaMNewGetValue(Sender: TObject;
      const VarName: string; var Value: Variant);
    procedure frxGenGetValue(const VarName: String;  var Value: Variant);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelRcxResumoCaixaMod: TfrmRelRcxResumoCaixaMod;

implementation
Uses untFuncoesSimples;
{$R *.dfm}

procedure TfrmRelRcxResumoCaixaMod.DataModuleCreate(Sender: TObject);
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

  frxRelRcxResumoCaixaM.AddFunction('function fAdicionaCheques(strDocum, strCodEmp : String; intSeqCon: Integer; dtaDtaCad: TDate): Boolean');
  frxRelRcxResumoCaixaJ.AddFunction('function fAdicionaCheques(strDocum, strCodEmp : String; intSeqCon: Integer; dtaDtaCad: TDate): Boolean');
  frxRelRcxResumoCaixaM.AddFunction('function fTotalSeq(strCodEmp : String; intSeqCon: Integer; dtaDtaCad: TDate): Double');
  frxRelRcxResumoCaixaJ.AddFunction('function fTotalSeq(strCodEmp : String; intSeqCon: Integer; dtaDtaCad: TDate): Double');
end;

procedure TfrmRelRcxResumoCaixaMod.frxRelRcxResumoCaixaMNewGetValue(
  Sender: TObject; const VarName: string; var Value: Variant);
begin
  If VarName = 'FORMAPAGAMENTO015' Then
    Value := fCampoTabela('FPG_DESCRI', 'CADFPG', ['FPG_CODIGO'], ['015']);
end;

procedure TfrmRelRcxResumoCaixaMod.frxGenGetValue(const VarName: String;
  var Value: Variant);
begin
  inherited;

  If VarName = 'EMP_NOMEMP' Then
    Value := fCampoTabela('EMP_NOMEMP', 'CADEMP INNER JOIN CADCID ON EMP_CODCID = CID_CODCID', ['EMP_CODEMP'], [VS_strCodEmp], False)

  Else If VarName = 'EMP_NOMFAN' Then
    Value := fCampoTabela('EMP_NOMFAN', 'CADEMP INNER JOIN CADCID ON EMP_CODCID = CID_CODCID', ['EMP_CODEMP'], [VS_strCodEmp], False)

  Else If VarName = 'REL_NOMREL' Then
    Value := Self.Name

  Else If VarName = 'EMP_NOMCID' Then
    Value := fCampoTabela('CID_NOMCID', 'CADEMP INNER JOIN CADCID ON EMP_CODCID = CID_CODCID', ['EMP_CODEMP'], [VS_strCodEmp], False);

end;

end.
