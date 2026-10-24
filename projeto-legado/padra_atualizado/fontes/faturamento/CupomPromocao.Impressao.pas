unit CupomPromocao.Impressao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, frxExportCSVTestabilidade,
  Data.DB, MemDS, DBAccess, Uni, System.MaskUtils, untEditorFastImpressao, untTypesSistema;

type
  TfrmModeloCupomPromocao = class(TForm)
    frxCupomPromo: TfrxReport;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    qryCfgRel: TUniQuery;
    { Private declarations }
    procedure pImprimeCupomArquivoFR3(strCodCli,
                                      strNumdoc,
                                      strEspDoc,
                                      strCodEmp,
                                      strNomCli,
                                      strCPF,
                                      strRG,
                                      strFone,
                                      strVendedor,
                                      strOperador,
                                      strCupomTil,
                                      strCupomDesc : string;
                                      intNumCup    : integer;
                                      strCupom     : string);

    procedure pImprimeCupomComLayout(strNumDoc,
                                     strEspDoc,
                                     strCodEmp,
                                     strCodLay: String;
                                     intNumCup: Integer;
                                     strCodPro: String;
                                     strEmpCpp: String = '';
                                     strNumCup: String = '';
                                     strSeqPro: String = '');
  public
    { Public declarations }
    procedure pImprimeCupom(strCodLay,
                            strCodCli,
                            strNumdoc,
                            strEspDoc,
                            strCodEmp,
                            strNomCli,
                            strCpfCnpj,
                            strRG,
                            strFone,
                            strVendedor,
                            strOperador,
                            strCupomTil,
                            strCupomDesc : String;
                            intNumCup    : Integer;
                            strCodCpp,
                            strEmpCpp,
                            strSequen,
                            strSeqPro,
                            strCupom     : String);

  end;

var
  frmModeloCupomPromocao: TfrmModeloCupomPromocao;

implementation

uses
  untFuncoesSimples, untFuncoesGenerica;

{$R *.dfm}

{ TfrmModeloCupomPromocao }

procedure TfrmModeloCupomPromocao.FormCreate(Sender: TObject);
begin
  qryCfgRel := fCriaQuery(Self);
end;

procedure TfrmModeloCupomPromocao.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryCfgRel);
end;

procedure TfrmModeloCupomPromocao.pImprimeCupom(strCodLay,
                                                strCodCli,
                                                strNumdoc,
                                                strEspDoc,
                                                strCodEmp,
                                                strNomCli,
                                                strCpfCnpj,
                                                strRG,
                                                strFone,
                                                strVendedor,
                                                strOperador,
                                                strCupomTil,
                                                strCupomDesc : String;
                                                intNumCup    : Integer;
                                                strCodCpp,
                                                strEmpCpp,
                                                strSequen,
                                                strSeqPro,
                                                strCupom     : String);
begin
  If fEmptyStr(strCodLay) Then
  Begin
    pImprimeCupomArquivoFR3(strCodCli,
                            strNumDoc,
                            strEspDoc,
                            strCodEmp,
                            strNomCli,
                            strCpfCnpj,
                            strRG,
                            strFone,
                            strVendedor,
                            strOperador,
                            strCupomTil,
                            strCupomDesc,
                            intNumCup,
                            strCupom);
  End
  Else
  Begin
    pImprimeCupomComLayout(strNumDoc,
                           strEspDoc,
                           strCodEmp,
                           strCodLay,
                           intNumCup,
                           strCodCpp,
                           strEmpCpp,
                           strSequen,
                           strSeqPro);
  End;
end;

procedure TfrmModeloCupomPromocao.pImprimeCupomArquivoFR3(strCodCli, strNumdoc,
  strEspDoc, strCodEmp, strNomCli, strCPF, strRG, strFone, strVendedor, strOperador,
  strCupomTil, strCupomDesc: string; intNumCup: integer; strCupom: string);
var
  strDespro,
  strTipImp,
  strNomImp: string;
begin
  If (intNumCup <= 0) Then
    Exit;

  If FileExists(fCfgSis('PATETI') + '\CupomPromo.fr3') Then
    frxCupomPromo.LoadFromFile(fCfgSis('PATETI') + '\CupomPromo.fr3');

  pCarregaConfImpr(qryCfgRel, 'ImpressaoCupomPromo', VS_strCodEmp);
  strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

  frxCupomPromo.Script.Variables['NUMDOC']    := strNumdoc;
  frxCupomPromo.Script.Variables['ESPDOC']    := strEspDoc;
  frxCupomPromo.Script.Variables['NOME']      := strNomCli;
  frxCupomPromo.Script.Variables['CPF']       := fFormataCpfCgc(strCPF, fSetaPais);
  frxCupomPromo.Script.Variables['RG']        := strRG;
  frxCupomPromo.Script.Variables['FONE']      := FormatMaskText('(99)99999-9999;0;_', strFone);
  frxCupomPromo.Script.Variables['VENDEDOR']  := strVendedor;
  frxCupomPromo.Script.Variables['DATA']      := FormatDateTime('dd/mm/yyyy',fRetDataServidor);
  frxCupomPromo.Script.Variables['HORA']      := FormatDateTime('hh:nn', fRetHoraServidor);
  frxCupomPromo.Script.Variables['OPERADOR']  := strOperador;
  frxCupomPromo.Script.Variables['DTACUP']    := FormatDateTime('dd/mm/yyyy',fRetDataServidor);
  frxCupomPromo.Script.Variables['HORCUP']    := FormatDateTime('hh:mm', fRetHoraServidor);
  frxCupomPromo.Script.Variables['NOMTIL']    := strCupomTil;
  frxCupomPromo.Script.Variables['CUPOMDESC'] := strCupomDesc;
  frxCupomPromo.Script.Variables['ENDERE']    := fCampoTabela('CLI_ENDERE', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
  frxCupomPromo.Script.Variables['NUM']       := fCampoTabela('CLI_ENDNUM', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
  frxCupomPromo.Script.Variables['EMAIL']     := fCampoTabela('CLI_EMAIL_', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);

  frxCupomPromo.Script.Variables['NOMOPE']    := fCampoTabela('OPE_NOMOPE', 'CADOPE', ['OPE_CODOPE'], [strOperador], False);
  frxCupomPromo.Script.Variables['NOMEMP']    := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp], False);
  frxCupomPromo.Script.Variables['DOCEMP']    := fCampoTabela('EMP_C_G_C_', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp], False);

  frxCupomPromo.Script.Variables['CODEMP']    := VS_strCodEmp;
  frxCupomPromo.Script.Variables['CODCLI']    := strCodCli;
  frxCupomPromo.Script.Variables['CUPOM']     := strCupom;

  If fEmptyStr(strNomImp) Then
    fPreImpressao(qryCfgRel, strNomImp, strTipImp, False, 'I');

  strDespro := 'Cupom de Promoção ('
             + strNumDoc + '-' + strEspDoc + '-' + strCodEmp
             +')';

  If Not fEmptyStr(strNomImp) Then
  Begin
    frxCupomPromo.PrintOptions.Printer    := strNomImp;
    frxCupomPromo.PrintOptions.ShowDialog := False;
    frxCupomPromo.PrintOptions.Copies     := 1;

    If frxCupomPromo.PrepareReport Then
      pPrintReport('ImpressaoCupomPromo', strDesPro, strNomImp, frxCupomPromo);
  End;
end;

procedure TfrmModeloCupomPromocao.pImprimeCupomComLayout(strNumDoc, strEspDoc,
  strCodEmp, strCodLay: String; intNumCup: Integer; strCodPro, strEmpCpp,
  strNumCup, strSeqPro: String);
var
  objImpressao: TEditorFastImpressao;
  qryCupons: TUniQuery;
  strTipImp,
  strNomImp: String;
begin
  If (intNumCup <= 0) Then
    Exit;

  pCarregaConfImpr(qryCfgRel, 'ImpressaoCupomPromo', VS_strCodEmp);
  strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

  If fEmptyStr(strNomImp) Then
    fPreImpressao(qryCfgRel, strNomImp, strTipImp, False, 'I');

  If fEmptyStr(strNomImp) Then
    Exit;

  objImpressao := TEditorFastImpressao.Create(Nil);
  qryCupons := fCriaQuery;

  Try
    qryCupons.Close;
    qryCupons.SQL.Clear;
    qryCupons.SQL.Add(' SELECT AUTOINCREM, CPG_SEQUEN, CPG_CODLAY');
    qryCupons.SQL.Add('   FROM CPPGER');
    qryCupons.SQL.Add('  WHERE CPG_NUMDOC = :NUMDOC');
    qryCupons.SQL.Add('    AND CPG_ESPDOC = :ESPDOC');
    qryCupons.SQL.Add('    AND CPG_CODEMP = :CODEMP');
    qryCupons.SQL.Add('    AND CPG_CODLAY = :CODLAY ');

    If (Not fEmptyStr(strCodPro)) Then
      qryCupons.SQL.Add('  AND CPG_CODCPP = :CODPRO ');

    If (Not fEmptyStr(strSeqPro)) Then
      qryCupons.SQL.Add('  AND CPG_SEQPRO = :SEQPRO ');

    qryCupons.SQL.Add(' LIMIT ' + intNumCup.ToString());

    qryCupons.ParamByName('NUMDOC').AsString := strNumDoc;
    qryCupons.ParamByName('ESPDOC').AsString := strEspDoc;
    qryCupons.ParamByName('CODEMP').AsString := strCodEmp;
    qryCupons.ParamByName('CODLAY').AsString := strCodLay;

    If (Not fEmptyStr(strCodPro)) Then
      qryCupons.ParamByName('CODPRO').AsString := strCodPro;

    If (Not fEmptyStr(strSeqPro)) Then
      qryCupons.ParamByName('SEQPRO').AsString := strSeqPro;

    qryCupons.Open;

    if qryCupons.IsEmpty then
      Exit;

    qryCupons.First;

    while not qryCupons.Eof do
    begin
      objImpressao.recDocume.strNumDoc        := strNumDoc;
      objImpressao.recDocume.strEspDoc        := strEspDoc;
      objImpressao.recDocume.strCodEmp        := strCodEmp;
      objImpressao.recDocume.blnTemLay        := True;
      objImpressao.recDocume.strCodLay        := qryCupons.FieldByName('CPG_CODLAY').AsString;
      objImpressao.recDocume.strAutInc        := qryCupons.FieldByName('AUTOINCREM').AsString;
      objImpressao.recDocume.strNomImp        := strNomImp;
      objImpressao.recDocume.blnCupomPromocao := True;
      objImpressao.recDocume.intQtdIte        := intNumCup;
      objImpressao.recDocume.strCodPro        := strCodPro;
      objImpressao.recDocume.strNumCup        := strNumCup;

      if (not fEmptyStr(strEmpCpp)) then
        TEditorFastImpressao.strEmpresaLayout := strEmpCpp;

      objImpressao.fImprimeDocumento(tpaNormal);

      qryCupons.Next;
    end;
  Finally
    TEditorFastImpressao.strEmpresaLayout := '';
    FreeAndNil(objImpressao);
    FreeAndNil(qryCupons);
  End;
end;

end.
