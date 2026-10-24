unit untRelFatComVendedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, RLFilters, RLDraftFilter, Menus, StdCtrls,
  EditFocus, QColorLabel, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils,
  frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, frxExportTXT, AppEvnts;

type
  TfrmRelFatComVendedor = class(TfrmPaiRelatorio)
    Label5: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    lblVenDig: TLabel;
    edtCodVendedor: TEditFocus;
    edtDesVendedor: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    gpbOpcao: TGroupBox;
    ColorLabel2: TColorLabel;
    edtOpcao: TEditFocus;
    ColorLabel3: TColorLabel;
    ColorLabel4: TColorLabel;
    ColorLabel5: TColorLabel;
    gpbTipo: TGroupBox;
    ColorLabel6: TColorLabel;
    edtTipo: TEditFocus;
    Label2: TLabel;
    lstClaFis: TMemo;
    ColorLabel7: TColorLabel;
    ColorLabel8: TColorLabel;
    gpbVendedor: TGroupBox;
    lblVendedor: TColorLabel;
    edtVendedor: TEditFocus;
    Label1: TLabel;
    Label3: TLabel;
    procedure edtCodVendedorExit(Sender: TObject);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaVendedor;
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaEmpresa;
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pAtualizaClaFis;
    procedure edtVendedorChange(Sender: TObject);
  private
    { Private declarations }
    strCodVen: String;
  public
    { Public declarations }
    blnLiberado: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmRelFatComVendedor: TfrmRelFatComVendedor;

implementation

uses untModuloCons, untModulo, untFuncoes, untfuncoesSimples, untQckFatComVendedor,
  untModuloSPR, untModuloCadEmp, untModuloCadOpe, DB, ZAbstractRODataset;

{$R *.dfm}

procedure TfrmRelFatComVendedor.edtCodVendedorExit(Sender: TObject);
begin
  inherited;

  If (blnLiberado) Then
    strCodVen := edtCodVendedor.Text
  Else
  Begin
    strCodVen := fRetCodVendedor(edtCodVendedor.Text);
    If (fEmptyStr(strCodVen)) And (Not fEmptyStr(edtCodVendedor.Text)) Then
    Begin

      If edtVendedor.Text = '3' Then
        fMensagem('','Digitador não encontrado.',['&O K'])
      Else
        fMensagem('AVISO','Vendedor não encontrado.', ['&O K']);

      edtCodVendedor.Clear;
      edtCodVendedor.SetFocus;
      edtDesVendedor.Clear;
      Exit;
    End;
  End;

  If fEmptyStr(edtCodVendedor.Text) Then
    edtDesVendedor.Text := 'TODOS'
  Else
    edtDesVendedor.Text := fRetNomVendRep(strCodVen);

  If fEmptyStr(edtDesVendedor.Text) And (Not fEmptyStr(strCodVen))  Then
  Begin

    If edtVendedor.Text = '3' Then
      fMensagem('','Código do digitador não encontrado.',['&O K'])
    Else
      fMensagem('AVISO','Código do vendedor não encontrado.', ['&O K']);
      
    edtCodVendedor.Clear;
    edtCodVendedor.SetFocus;
  End;

end;

procedure TfrmRelFatComVendedor.edtCodVendedorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlIndiceVen, stlDesIndVen, stlCamposVen: TStringList;
begin
  inherited;

  If (fEntraCons(Key)) And (blnLiberado) Then
  Begin

    stlIndiceVen := TStringList.Create;
    stlDesIndVen := TStringList.Create;
    stlCamposVen := TStringList.Create;

    Key := #0;

    stlCamposVen.Add('OPE_CODOPE');
    stlCamposVen.Add('OPE_NOMOPE');
    stlCamposVen.Add('AUTOINCREM');

    stlIndiceVen.Add('OPE_NOMOPE');
    stlIndiceVen.Add('OPE_CODOPE');
    stlDesIndVen.Add('Nome');
    stlDesIndVen.Add('Código');

    frmModuloCons.qryCon004 := frmModuloCadOpe.qryCadOpe;
    If pConsultaRapida(Self, frmModuloCons.qryCon004, 'CADOPE', stlIndiceVen, stlDesIndVen, stlCamposVen) Then
    Begin

      edtCodVendedor.Text := frmModuloCons.qryCon004.FieldByName('OPE_CODOPE').AsString;
      Self.SelectNext(ActiveControl, True, True);

    End;

    pCarregaVendedor;

    FreeAndNil(stlIndiceVen);
    FreeAndNil(stlDesIndVen);
    FreeAndNil(stlCamposVen);
  End;

end;

procedure TfrmRelFatComVendedor.pCarregaVendedor;
Begin
  If Not (fEmptyStr(edtCodVendedor.Text)) Then
    edtDesVendedor.Text := frmModuloCons.qryCon004.FieldByName('OPE_NOMOPE').AsString
  Else
    edtDesVendedor.Text := '';
End;

procedure TfrmRelFatComVendedor.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodEmpresa.Text) Then
    edtDesEmpresa.Text := 'TODOS'
  Else
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

  If fEmptyStr(edtDesEmpresa.Text) And (Not fEmptyStr(edtCodEmpresa.Text))  Then
  Begin
    fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
    edtCodEmpresa.Clear;
    edtCodEmpresa.SetFocus;
  End;

end;

procedure TfrmRelFatComVendedor.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlIndiceEmp: TStringList;
    stlDesIndEmp: TStringList;
    stlCamposEmp: TStringList;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    stlIndiceEmp := TStringList.Create;
    stlDesIndEmp := TStringList.Create;
    stlCamposEmp := TStringList.Create;

    Key := #0;

    stlCamposEmp.Add('EMP_CODEMP');
    stlCamposEmp.Add('EMP_NOMEMP');
    stlCamposEmp.Add('AUTOINCREM');

    stlIndiceEmp.Add('EMP_NOMEMP');
    stlIndiceEmp.Add('EMP_CODEMP');
    stlDesIndEmp.Add('Nome');
    stlDesIndEmp.Add('Código');

    frmModuloCons.qryCon004 := frmModuloCadEmp.qryCadEmp;
    If pConsultaRapida(Self, frmModuloCons.qryCon004, 'CADEMP', stlIndiceEmp, stlDesIndEmp, stlCamposEmp) Then
    Begin
      edtCodEmpresa.Text := frmModuloCons.qryCon004.FieldByName('EMP_CODEMP').AsString;
      Self.SelectNext(ActiveControl, True, True);
    End;
    pCarregaEmpresa;

    FreeAndNil(stlIndiceEmp);
    FreeAndNil(stlDesIndEmp);
    FreeAndNil(stlCamposEmp);
  End;

end;

procedure TfrmRelFatComVendedor.pCarregaEmpresa;
Begin
  If Not (fEmptyStr(edtCodEmpresa.Text)) Then
    edtDesEmpresa.Text := frmModuloCons.qryCon004.FieldByName('EMP_NOMEMP').AsString
  Else
    edtDesEmpresa.Text := '';
End;

{*****************}
{* VALIDA CAMPOS *}
{**************AF*}
function TfrmRelFatComVendedor.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {***********************}
    {* VALIDA DATA INICIAL *}
    {********************AF*}
    If (Sender = mskDtaIni) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
      End;

    End

    {*********************}
    {* VALIDA DATA FINAL *}
    {******************AF*}
    Else If (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Data Final deve ser preenchido!', ['&O k']);
        Result := False;
      End

      Else If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!','A data inicial deve ser menor que a data final!',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtOpcao) Then
    Begin

      If Pos(edtOpcao.Text,'1_2_3_4_5_6_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo opção deve ser 1,2,3,4,5 ou 6!',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtVendedor) Then
    Begin

      if VS_strUsaDig <> 'S' Then
      Begin
        If Pos(edtVendedor.Text,'1_2_') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!','O campo opção de vendedor deve ser 1 ou 2!',['&O K']);
          Result := False;
        End;
      End
      Else
      Begin
        If Pos(edtVendedor.Text,'1_2_3') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!','O campo opção de vendedor deve ser 1, 2 ou 3 !',['&O K']);
          Result := False;
        End;
      End;

    End;

  End;

  If Not Result Then
    Sender.SetFocus;

end;

procedure TfrmRelFatComVendedor.btnImprimirClick(Sender: TObject);
  Var
    strSQL   : String;
    strSQL2  : String;
    strCreate: String;
begin

  If (Not blnLiberado) Then
  Begin
    If (fEmptyStr(edtCodVendedor.Text)) Then
    Begin

      If edtVendedor.Text = '3' Then
        fMensagem('', 'O digitador deve ser preenchido!', ['&Ok'])
      Else
        fMensagem('', 'O vendedor deve ser preenchido!', ['&Ok']);

      Exit;
    End;
  End;

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;

  If blnImprime Then
  Begin

    If fTabelaExiste('TMP_COMVEN') Then
    Begin
      With frmModuloSPR.qryGen001 Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('DROP TABLE TMP_COMVEN');
        ExecSQL;
        Close;
      End;
    End;

    strCreate := 'CREATE TEMPORARY TABLE TMP_COMVEN ';

    strSQL := '';
    strSQL := strSQL + 'SELECT  ';

    strSQL := strSQL + '  DATE_FORMAT(D.DET_DTAENT,"%d/%m/%y")                                                       AS DTAENT, ';
    strSQL := strSQL + '  D.DET_ESPDOC                                                                               AS ESPDOC, ';
    strSQL := strSQL + '  CONCAT(D.DET_NUMDOC,"-",D.DET_ESPDOC)                                                      AS NUMDOC, ';
    strSQL := strSQL + '  D.DET_CODEMP                                                                               AS CODEMP, ';
    strSQL := strSQL + '  D.DET_CODVEN                                                                               AS CODVEN, ';
    strSQL := strSQL + '  D.DET_CODVE2                                                                               AS CODVE2, ';
    strSQL := strSQL + '  D.DET_CODDIG                                                                               AS CODDIG, ';
    strSQL := strSQL + '  IF(C.CLI_NOMCLI = "CONSUMIDOR", G.GER_NOMCON, C.CLI_NOMCLI)                                AS NOMCL2, ';

    If edtVendedor.Text = '1' Then
      strSQL := strSQL + '  CONCAT(D.DET_CODVEN,"-",O.OPE_NOMOPE)                                                    AS NOMVEN, '
    Else If edtVendedor.Text = '2' Then
      strSQL := strSQL + '  CONCAT(D.DET_CODVE2,"-",O.OPE_NOMOPE)                                                    AS NOMVEN, '
    Else
      strSQL := strSQL + '  CONCAT(D.DET_CODDIG,"-",O.OPE_NOMOPE)                                                    AS NOMVEN, ';
    {***************************************************************}
    {* SE FOR CONSUMIDOR PEGA O NOME QUE FOI GRAVADO EM DET_NOMCON *}
    {************************************************************AF*}
    strSQL := strSQL + '  IF(C.CLI_NOMCLI = "CONSUMIDOR", G.GER_NOMCON, CONCAT(D.DET_CODCLI,"-",C.CLI_NOMCLI))       AS NOMCLI, ';
    {*******************************************************************************************}
    {* SE O PRIMEIRO DIGITO DA CLAS.FISCAL FOR < 5 ENTAO O NUMERO FICA NEGATIVO PARA SUBTRAÇÃO *}
    {****************************************************************************************AF*}
    strSQL := strSQL + '  IF(LEFT(D.DET_CLAFIS,1) < 5, -(D.DET_TOTITE - D.DET_DESESP), D.DET_TOTITE - D.DET_DESESP)  AS TOTITE, ';
    {*******************************************************************************************}
    {* SE O PRIMEIRO DIGITO DA CLAS.FISCAL FOR < 5 ENTAO O NUMERO FICA NEGATIVO PARA SUBTRAÇÃO *}
    {****************************************************************************************AF*}
    strSQL := strSQL + '  IF(LEFT(D.DET_CLAFIS,1) < 5, -D.DET_TOTCOM, D.DET_TOTCOM)                                  AS TOTCOM, ';
    {*******************************************************************************************}
    {* SE O PRIMEIRO DIGITO DA CLAS.FISCAL FOR < 5 ENTAO O NUMERO FICA NEGATIVO PARA SUBTRAÇÃO *}
    {* CALCULA A COMISSÃO DO VENDEDOR                                                          *}
    {****************************************************************************************AF*}
    strSQL := strSQL + '  IF(LEFT(D.DET_CLAFIS,1) < 5, -(((D.DET_TOTITE - D.DET_DESESP) * O.OPE_PERCOM)/100), ';
    strSQL := strSQL + '                        (((D.DET_TOTITE - D.DET_DESESP) * O.OPE_PERCOM)/100))                AS OPECOM, ';
    {*******************************************************************************************}
    {* SE O PRIMEIRO DIGITO DA CLAS.FISCAL FOR < 5 ENTAO O NUMERO FICA NEGATIVO PARA SUBTRAÇÃO *}
    {* CALCULA A COMISSÃO DO PRODUTO                                                           *}
    {****************************************************************************************AF*}
    strSQL := strSQL + '  IF(LEFT(D.DET_CLAFIS,1) < 5, -(((D.DET_TOTITE - D.DET_DESESP) * I.ITE_COMVAR)/100), ';
    strSQL := strSQL + '                        (((D.DET_TOTITE - D.DET_DESESP) * I.ITE_COMVAR)/100))                AS ITECOM, ';
    {*******************************************************************************************}
    {* SE O PRIMEIRO DIGITO DA CLAS.FISCAL FOR < 5 ENTAO O NUMERO FICA NEGATIVO PARA SUBTRAÇÃO *}
    {* CALCULA A COMISSÃO DO FORNECEDOR                                                        *}
    {****************************************************************************************AF*}
    strSQL := strSQL + '  IF(LEFT(D.DET_CLAFIS,1) < 5, -(((D.DET_TOTITE - D.DET_DESESP) * F.FOR_PERCOM)/100), ';
    strSQL := strSQL + '                        (((D.DET_TOTITE - D.DET_DESESP) * F.FOR_PERCOM)/100))                AS FORCOM, ';

    {**********************}
    {* CALCULADO NA VENDA *}
    {*******************AF*}
    strSQL := strSQL + '  IF(LEFT(D.DET_CLAFIS,1) < 5, -D.DET_TOTCO2, D.DET_TOTCO2)                                  AS TOTCO2, ';
    {**********************************}
    {* CALCULA A COMISSÃO DO VENDEDOR *}
    {*******************************AF*}
    strSQL := strSQL + '  ((IF(LEFT(D.DET_CLAFIS,1) < 5, -(((D.DET_TOTITE - D.DET_DESESP) * O.OPE_PERCOM)/100), ';
    strSQL := strSQL + '                                  (((D.DET_TOTITE - D.DET_DESESP) * O.OPE_PERCOM)/100)) ';
    strSQL := strSQL + ' * ' + AnsiReplaceStr(FloatToStrF(VS_fltTaxRep,ffFixed,12,2),',','.') + ')/100)              AS OPECO2, ';
    {*********************************}
    {* CALCULA A COMISSÃO DO PRODUTO *}
    {******************************AF*}
    strSQL := strSQL + '  ((IF(LEFT(D.DET_CLAFIS,1) < 5, -(((D.DET_TOTITE - D.DET_DESESP) * I.ITE_COMVAR)/100), ';
    strSQL := strSQL + '                                  (((D.DET_TOTITE - D.DET_DESESP) * I.ITE_COMVAR)/100)) ';
    strSQL := strSQL + ' * ' + AnsiReplaceStr(FloatToStrF(VS_fltTaxRep,ffFixed,12,2),',','.') + ')/100)              AS ITECO2, ';
    {************************************}
    {* CALCULA A COMISSÃO DO FORNECEDOR *}
    {*********************************AF*}
    strSQL := strSQL + '  ((IF(LEFT(D.DET_CLAFIS,1) < 5, -(((D.DET_TOTITE - D.DET_DESESP) * F.FOR_PERCOM)/100), ';
    strSQL := strSQL + '                                  (((D.DET_TOTITE - D.DET_DESESP) * F.FOR_PERCOM)/100)) ';
    strSQL := strSQL + ' * ' + AnsiReplaceStr(FloatToStrF(VS_fltTaxRep,ffFixed,12,2),',','.') + ')/100)              AS FORCO2, ';

    strSQL := strSQL + '  D.DET_UNITAR AS DET_UNITAR, ';
    strSQL := strSQL + '  D.DET_UNIORI AS DET_UNIORI, ';
    strSQL := strSQL + '  D.DET_TOTITE AS DET_TOTITE, ';
    strSQL := strSQL + '  D.DET_TOTCUS AS DET_TOTCUS, ';
    strSQL := strSQL + '  D.DET_DESESP AS DET_DESESP, ';
    strSQL := strSQL + '  0.0000       AS MARCOM,     ';
    strSQL := strSQL + '  0.0000       AS DESCOM,      ';
    strSQL := strSQL + '  0.0000       AS MARCO2,     ';
    strSQL := strSQL + '  0.0000       AS DESCO2      ';

    strSQL := strSQL + 'FROM  ';

    strSQL := strSQL + '  MOVGER G, ';
    strSQL := strSQL + '  CADCLI C, ';
    strSQL := strSQL + '  CADOPE O, ';
    strSQL := strSQL + '  ITEGER I, ';
    strSQL := strSQL + '  MOVDET D  ';
    strSQL := strSQL + '  LEFT JOIN ';
    strSQL := strSQL + '  CADFOR F  ';
    strSQL := strSQL + '  ON F.FOR_CODFOR = D.DET_FORITE ';

    strSQL := strSQL + 'WHERE ';

    strSQL := strSQL + '  D.DET_CODCLI NOT IN (' + QuotedStr(VS_strCliFil) + ') AND '; {EDUARDO}
    strSQL := strSQL + '  G.AUTOINCREM = D.DET_SEQGER               AND ';
    strSQL := strSQL + '  I.ITE_CODITE = D.DET_CODITE               AND ';
    strSQL := strSQL + '  I.ITE_CODEMP = D.DET_CODEMP               AND ';
    strSQL := strSQL + '  C.CLI_CODCLI = D.DET_CODCLI               AND ';

    If edtVendedor.Text = '1' Then
      strSQL := strSQL + '  O.OPE_CODOPE = D.DET_CODVEN             AND '
    Else If edtVendedor.Text = '2' Then
      strSQL := strSQL + '  O.OPE_CODOPE = D.DET_CODVE2             AND '
    Else
      strSQL := strSQL + '  O.OPE_CODOPE = D.DET_CODDIG             AND ';

    strSQL := strSQL + '  D.DET_PROEMB <> "S"                       AND ';
    strSQL := strSQL + '  D.DET_TIP_FC = "C"                        AND ';
    strSQL := strSQL + '  D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN  AND ';
    strSQL := strSQL + '  ((LOCATE(D.DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(D.DET_CLAFIS, :CLADEV) > 0)) ';

    If Not fEmptyStr(strCodVen) Then
    Begin

      If edtVendedor.Text = '1' Then
        strSQL := strSQL + '  AND D.DET_CODVEN = :CODVEN '
      Else If edtVendedor.Text = '2' Then
        strSQL := strSQL + '  AND D.DET_CODVE2 = :CODVEN '
      Else
        strSQL := strSQL + '  AND D.DET_CODDIG = :CODDIG '


    End;

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + '  AND D.DET_CODEMP = :CODEMP ';


    {******************************}
    {* VERIFICAÇÃO DE CAIXA 1 E 2 *}
    {***************************AF*}
    If intGlobal = 1 Then
    Begin
      strSQL := AnsiReplaceStr(strSQL,'MOVDET','MOVDETX');
      strSQL := AnsiReplaceStr(strSQL,'MOVGER','MOVGERX');
    End
    Else If intGlobal = 2 Then
    Begin
      strSQL2 := AnsiReplaceStr(strSQL,  'MOVDET','MOVDETX');
      strSQL2 := AnsiReplaceStr(strSQL2, 'MOVGER','MOVGERX');

      strSQL  := strSQL + ' UNION ALL ' + strSQL2;
    End;

    With frmModuloSPR.qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strCreate + strSQL);

      ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);
      ParamByName('CLAFIS').AsString := VS_strClaVen;
      ParamByName('CLADEV').AsString := VS_strClaDev;

      If edtVendedor.Text <> '3' Then
      Begin
        If Not fEmptyStr(edtCodVendedor.Text) Then
          ParamByName('CODVEN').AsString := strCodVen;
      End
      Else
        If Not fEmptyStr(edtCodVendedor.Text) Then
          ParamByName('CODDIG').AsString := edtCodVendedor.Text;

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

      ExecSQL;
      Close;

      {************************************************}
      {* SE A OPÇÃO FOR MARGEM FAZ O CALCULO DO MESMO *}
      {*********************************************AF*}
      If Pos(edtOpcao.Text,'5_6_') > 0 Then
      Begin
        strSQL := '';
        strSQL := strSQL + 'SELECT ';
        strSQL := strSQL + '  * ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  TMP_COMVEN ';

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;

        strSQL := '';
        strSQL := strSQL + 'UPDATE TMP_COMVEN ';
        strSQL := strSQL + 'SET ';
        strSQL := strSQL + '  MARCOM = :VALMAR, ';
        strSQL := strSQL + '  DESCOM = :VALDES, ';
        strSQL := strSQL + '  MARCOM = :VALMA2, ';
        strSQL := strSQL + '  DESCOM = :VALDE2 ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  NUMDOC = :NUMDOC AND ';
        strSQL := strSQL + '  CODEMP = :CODEMP ';

        While Not Eof Do
        Begin
          Application.ProcessMessages;

          frmModuloSPR.qryGen007.Close;
          frmModuloSPR.qryGen007.SQL.Clear;
          frmModuloSPR.qryGen007.SQL.Add(strSQL);
          frmModuloSPR.qryGen007.ParamByName('NUMDOC').AsString := FieldByName('NUMDOC').AsString;
          frmModuloSPR.qryGen007.ParamByName('CODEMP').AsString := FieldByName('CODEMP').AsString;

          frmModuloSPR.qryGen007.ParamByName('VALMAR').AsFloat  := (fRetPerComMargem(fCalculaPrecoVenda(2,FieldByName('DET_TOTCUS').AsFloat, FieldByName('DET_TOTITE').AsFloat,0,0)) * (FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat)) / 100;
          frmModuloSPR.qryGen007.ParamByName('VALMA2').AsFloat  := (((fRetPerComMargem(fCalculaPrecoVenda(2,FieldByName('DET_TOTCUS').AsFloat, FieldByName('DET_TOTITE').AsFloat,0,0)) * (FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat)) / 100) * VS_fltTaxRep) / 100;
          frmModuloSPR.qryGen007.ParamByName('VALDES').AsFloat  := (fRetPerComMargem(((FieldByName('DET_UNIORI').AsFloat / FieldByName('DET_UNITAR').AsFloat) -1) * 100) * (FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat)) / 100;
          frmModuloSPR.qryGen007.ParamByName('VALDE2').AsFloat  := (((fRetPerComMargem(((FieldByName('DET_UNIORI').AsFloat / FieldByName('DET_UNITAR').AsFloat) -1) * 100) * (FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat)) / 100) * VS_fltTaxRep) / 100;

          frmModuloSPR.qryGen007.ExecSQL;
          frmModuloSPR.qryGen007.Close;

          Next;
        End;

      End;

      {***************************************}
      {* SELECIONA OS DADOS PARA O RELATORIO *}
      {************************************AF*}
      strSQL := '';
      strSQL := strSQL + 'SELECT ';

      strSQL := strSQL + '  DTAENT, ';
      strSQL := strSQL + '  ESPDOC, ';
      strSQL := strSQL + '  NUMDOC, ';
      strSQL := strSQL + '  CODEMP, ';
      strSQL := strSQL + '  CODVEN, ';
      strSQL := strSQL + '  CODVE2, ';
      strSQL := strSQL + '  CODDIG, ';
      strSQL := strSQL + '  NOMVEN, ';
      strSQL := strSQL + '  NOMCLI  ';

      strSQL := strSQL + ',  IFNULL(SUM(TOTITE),0) AS TOTITE, ';

      If edtOpcao.Text = '1' Then
      Begin

        If (edtVendedor.Text = '1') Or (edtVendedor.Text = '3') Then
        Begin
          strSQL := strSQL + '  IFNULL( IFNULL(SUM(TOTCOM),0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0 )         AS PERCOM, ';
          strSQL := strSQL + '  IFNULL(SUM(TOTCOM),0) AS TOTCOM '
        End
        Else
        Begin
          strSQL := strSQL + '  IFNULL( IFNULL(SUM(TOTCO2),0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0 )         AS PERCOM, ';
          strSQL := strSQL + '  IFNULL(SUM(TOTCO2),0) AS TOTCOM ';
        End;

      End

      Else If edtOpcao.Text = '2' Then
      Begin

        If (edtVendedor.Text = '1') Or (edtVendedor.Text = '3') Then
        Begin
          strSQL := strSQL + '  IFNULL( IFNULL( IF(CODVE2 IS NULL, SUM(OPECOM), SUM(OPECOM - OPECO2)) ,0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0 )         AS PERCOM, ';
          strSQL := strSQL + '  IFNULL( IF(CODVE2 IS NULL, SUM(OPECOM), SUM(OPECOM - OPECO2)) ,0) AS TOTCOM '
        End
        Else
        Begin
          strSQL := strSQL + '  IFNULL( IFNULL(SUM(OPECO2),0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0 )         AS PERCOM, ';
          strSQL := strSQL + '  IFNULL(SUM(OPECO2),0) AS TOTCOM ';
        End;


      End

      Else If edtOpcao.Text = '3' Then
      Begin

        If (edtVendedor.Text = '1') Or (edtVendedor.Text = '3') Then
        Begin
          strSQL := strSQL + '  IFNULL( IFNULL( IF(CODVE2 IS NULL, SUM(ITECOM), SUM(ITECOM - ITECO2)) ,0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0 )         AS PERCOM, ';
          strSQL := strSQL + '  IFNULL( IF(CODVE2 IS NULL, SUM(ITECOM), SUM(ITECOM - ITECO2)) ,0) AS TOTCOM '
        End
        Else
        Begin
          strSQL := strSQL + '  IFNULL( IFNULL(SUM(ITECO2),0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0 )         AS PERCOM, ';
          strSQL := strSQL + '  IFNULL(SUM(ITECO2),0) AS TOTCOM ';
        End;

      End

      Else If edtOpcao.Text = '4' Then
      Begin

        If (edtVendedor.Text = '1') Or (edtVendedor.Text = '3') Then
        Begin
          strSQL := strSQL + '  IFNULL( IFNULL( IF(CODVE2 IS NULL, SUM(FORCOM), SUM(FORCOM - FORCO2)) ,0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0 )         AS PERCOM, ';
          strSQL := strSQL + '  IFNULL( IF(CODVE2 IS NULL, SUM(FORCOM), SUM(FORCOM - FORCO2)) ,0) AS TOTCOM '
        End
        Else
        Begin
          strSQL := strSQL + '  IFNULL( IFNULL(SUM(FORCOM),0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0 )         AS PERCOM, ';
          strSQL := strSQL + '  IFNULL(SUM(FORCOM),0) AS TOTCOM ';
        End;

      End

      Else If edtOpcao.Text = '5' Then
      Begin

        If (edtVendedor.Text = '1') Or (edtVendedor.Text = '3') Then
        Begin
          strSQL := strSQL + '  IFNULL( IFNULL( IF(CODVE2 IS NULL, SUM(MARCOM), SUM(MARCOM - MARCO2)) ,0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0 )         AS PERCOM, ';
          strSQL := strSQL + '  IFNULL( IF(CODVE2 IS NULL, SUM(MARCOM), SUM(MARCOM - MARCO2)) ,0) AS TOTCOM '
        End
        Else
        Begin
          strSQL := strSQL + '  IFNULL( IFNULL(SUM(MARCOM),0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0 )         AS PERCOM, ';
          strSQL := strSQL + '  IFNULL(SUM(MARCOM),0) AS TOTCOM ';
        End;

      End

      Else If edtOpcao.Text = '6' Then
      Begin

        If (edtVendedor.Text = '1') Or (edtVendedor.Text = '3') Then
        Begin
          strSQL := strSQL + '  IFNULL( IFNULL( IF(CODVE2 IS NULL, SUM(DESCOM), SUM(DESCOM - DESCO2)) ,0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0 )         AS PERCOM, ';
          strSQL := strSQL + '  IFNULL( IF(CODVE2 IS NULL, SUM(DESCOM), SUM(DESCOM - DESCO2)) ,0) AS TOTCOM  '
        End
        Else
        Begin
          strSQL := strSQL + '  IFNULL( IFNULL(SUM(DESCOM),0) / ( IFNULL(SUM(TOTITE),0) / 100 ), 0 )         AS PERCOM, ';
          strSQL := strSQL + '  IFNULL(SUM(DESCOM),0) AS TOTCOM ';
        End;

      End;

      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  TMP_COMVEN ';

      If edtTipo.Text = 'S' Then
      Begin

        If edtVendedor.Text = '1' Then
        Begin
          strSQL := strSQL + 'GROUP BY ';
          strSQL := strSQL + '  CODVEN ';
          strSQL := strSQL + 'ORDER BY ';
          strSQL := strSQL + '  CODVEN ';
        End
        Else If edtVendedor.Text = '2' Then
        Begin
          strSQL := strSQL + 'GROUP BY ';
          strSQL := strSQL + '  CODVE2 ';
          strSQL := strSQL + 'ORDER BY ';
          strSQL := strSQL + '  CODVE2 ';
        End
        Else
        Begin
          strSQL := strSQL + 'GROUP BY ';
          strSQL := strSQL + '  CODDIG ';
          strSQL := strSQL + 'ORDER BY ';
          strSQL := strSQL + '  CODDIG ';
        End;


      End
      Else
      Begin

        strSQL := strSQL + 'GROUP BY ';
        strSQL := strSQL + '  NUMDOC ';
        strSQL := strSQL + 'ORDER BY ';

        If edtVendedor.Text = '1' Then
          strSQL := strSQL + '  CODVEN, NOMCL2, NUMDOC '
        Else If edtVendedor.Text = '2' Then
          strSQL := strSQL + '  CODVE2, NOMCL2, NUMDOC '
        Else
          strSQL := strSQL + '  CODDIG, NOMCL2, NUMDOC ';


        strSQL := strSQL + ' , DTAENT ';

      End;

      SQL.Clear;
      SQL.Add(strSQL);
      Open;
    End;

    If Not frmModuloSPR.qryRelatorio.IsEmpty Then
    Begin
      Try
        Application.CreateForm(TfrmQckFatComVendedor,frmQckFatComVendedor);

        frmQckFatComVendedor.intVenDig := StrToInt(edtVendedor.Text);

        If VS_strUsaDig <> 'S' Then
        Begin
          frmQckFatComVendedor.rllEmpresa.Top       := 74;
          frmQckFatComVendedor.rllOrdem.Top         := 93;
          frmQckFatComVendedor.rlbCabecalho.Height  := 114;
        End;

        If strTipImp = 'M' Then
          frmQckFatComVendedor.qckPagina.DefaultFilter := rldFiltro
        Else
          frmQckFatComVendedor.qckPagina.DefaultFilter := Nil;

        frmQckFatComVendedor.intOpcao := StrToInt(edtOpcao.Text);

        frmQckFatComVendedor.strOrdem := 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

        If Not fEmptyStr(edtCodVendedor.Text) Then
        Begin
          If edtVendedor.text <> '3' Then
            frmQckFatComVendedor.rllVendedor.Caption := 'VENDEDOR: ' + strCodVen + ' - ' + edtDesVendedor.Text + '    OPCAO DE VENDEDOR: ' + IIF(edtVendedor.Text = '1','VENDEDOR 1','VENDEDOR 2')
          Else
            frmQckFatComVendedor.rllVendedor.Caption := 'DIGITADOR: ' + strCodVen + ' - ' + edtDesVendedor.Text + '    OPCAO DE DIGITADOR ';
        End
        Else
        Begin
          If edtVendedor.text <> '3' Then
            frmQckFatComVendedor.rllVendedor.Caption := 'VENDEDOR: TODOS    OPCAO DE VENDEDOR: ' + IIF(edtVendedor.Text = '1','VENDEDOR 1','VENDEDOR 2')
          Else
            frmQckFatComVendedor.rllVendedor.Caption := 'DIGITADOR: TODOS   OPCAO DE DIGITADOR ';
        End;

        If Not fEmptyStr(edtCodEmpresa.Text) Then
          frmQckFatComVendedor.rllEmpresa.Caption := 'EMPRESA: ' + edtCodEmpresa.Text + ' - ' + edtDesEmpresa.Text
        Else
          frmQckFatComVendedor.rllEmpresa.Caption := 'EMPRESA: TODAS';

        If edtTipo.Text = 'A' Then
        Begin

          If edtVendedor.text <> '3' Then
            frmQckFatComVendedor.rllNomeRelatorio.Caption := 'COMISSAO POR VENDEDOR - ANALITICO'
          Else
            frmQckFatComVendedor.rllNomeRelatorio.Caption := 'COMISSAO POR DIGITADOR - ANALITICO';

          frmQckFatComVendedor.rlbTitulo.Visible        := True;
          frmQckFatComVendedor.rlbGrupo.Visible         := True;
          frmQckFatComVendedor.rlbSumarioSint.Visible   := False;
        End
        Else
        Begin
          If edtVendedor.text <> '3' Then
            frmQckFatComVendedor.rllNomeRelatorio.Caption := 'COMISSAO POR VENDEDOR - SINTETICO'
          Else
            frmQckFatComVendedor.rllNomeRelatorio.Caption := 'COMISSAO POR DIGITADOR - SINTETICO';
          frmQckFatComVendedor.rlbDetalhe.Visible       := True;
          frmQckFatComVendedor.rlbTituloSint.Visible    := True;
          frmQckFatComVendedor.rlbSumarioAnal.Visible   := False;
        End;

        If intGlobal = 0 Then
          frmQckFatComVendedor.rllNomeRelatorio.Caption := frmQckFatComVendedor.rllNomeRelatorio.Caption + ' [*]'
        Else If intGlobal = 1 Then
          frmQckFatComVendedor.rllNomeRelatorio.Caption := frmQckFatComVendedor.rllNomeRelatorio.Caption + ' [**]'
        Else
          frmQckFatComVendedor.rllNomeRelatorio.Caption := frmQckFatComVendedor.rllNomeRelatorio.Caption + ' [*/**]';

        If edtVendedor.Text = '2' Then
        Begin
          frmQckFatComVendedor.rlbGrupo.DataFields := 'CODVE2';
        End
        Else If edtVendedor.Text = '3' Then
        Begin
          frmQckFatComVendedor.rlbGrupo.DataFields   := 'CODDIG';
          frmQckFatComVendedor.rllNomVen.Caption     := 'DIGITADOR';
          frmQckFatComVendedor.rllNomVenSint.Caption := 'NOME DO DIGITADOR';
        End;

        If edtDestino.Text = 'V' Then
          frmQckFatComVendedor.qckPagina.PreviewModal
        Else
          frmQckFatComVendedor.qckPagina.Print;

      Except
        On E: Exception Do
        Begin
          fMensagem('', MSG_IMPINVALIDA, ['&Ok']);
        End;
      End;
      FreeAndNil(frmQckFatComVendedor);
    End
    Else
    Begin
      pTabelaVazia;
    End;
  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';

end;

procedure TfrmRelFatComVendedor.FormCreate(Sender: TObject);
begin
  inherited;

  If intCaixa = 2 Then
  Begin

    If fMensagem('', 'Opção: ', ['Individual', 'Global']) = 1 Then
      intGlobal := 1
    Else
      intGlobal := 2;

  End;

  If VS_strUsaDig <> 'S' Then
  Begin
    {pnlDigitador.Visible := False;
    lblEmpresa.Top       := 119;
    edtCodEmpresa.Top    := 133;
    edtDesEmpresa.Top    := 133;
    gpbOpcao.Top         := 164;
    gpbTipo.Top          := 164;
    gpbDestino.Top       := 215;
    gpbVendedor.Top      := 266;
    Self.Height          := 391;
    lstClaFis.Height     := 293;}
    lblvendedor.Caption  := '(1)Vend. (2)Vend. 2';
  End;

  pAtualizaClaFis;
  strCodVen := '';

end;

procedure TfrmRelFatComVendedor.FormShow(Sender: TObject);
begin
  inherited;
  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa(edtCodEmpresa.Text);
  If (Not VS_blnEmpGer) Then
    edtCodEmpresa.Enabled := False;

  If (Not blnLiberado) Then
  Begin
    edtCodVendedor.MaxLength := 10;
    edtCodVendedor.TamCampo  := 0;
    edtCodVendedor.CompZeros := False;
    edtCodVendedor.PasswordChar := '*';
    edtCodVendedor.TipoTexto := ttAlfanumerico;
  End;
end;

procedure TfrmRelFatComVendedor.pAtualizaClaFis;
  Var
    strClaFis: String;
Begin
  //'5102_5403_5405_5655_5656_6102_6108_6404_6405_6655_6656_'

  strClaFis := VS_strClaVen;

  While Not fEmptyStr(strClaFis) Do
  Begin
    Application.ProcessMessages;

    lstClaFis.Lines.Add(LeftStr(strClaFis,4));

    strClaFis := RightStr(strClaFis, Length(strClaFis)-5 );
  End;

End;

procedure TfrmRelFatComVendedor.edtVendedorChange(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtVendedor.Text) Then
    If edtVendedor.Text = '3' Then
      lblVenDig.Caption := 'Digitador'
    Else
      lblVenDig.Caption := 'Vendedor';
end;

end.

