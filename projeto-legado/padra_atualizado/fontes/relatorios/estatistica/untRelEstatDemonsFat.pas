unit untRelEstatDemonsFat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus, QColorLabel, ExtCtrls, BitBtnLockedIncrem, Buttons,
  Mask, MaskEditFocus, Uni, DateUtils, strUtils, DB, UniClientDataSet, Math,
  ComboBoxFocus, untTypesSistema, frxExportCSVTestabilidade, Datasnap.DBClient;

type
  TfrmRelEstatDemonsFat = class(TfrmPaiRelatorio)
    lbl1: TLabel;
    mskMesAno: TMaskEditFocus;
    lblEmpresa: TLabel;
    lbl5: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    edtCodVen: TEditFocus;
    edtDesVen: TEditFocus;
    rdgTipVen: TRadioGroup;
    frxReport: TfrxReport;
    cdsDiario: TUniClientDataSet;
    cdsDiarioINTDIA: TIntegerField;
    cdsDiarioSTRDIA: TStringField;
    cdsDiarioTOTVEN: TFloatField;
    cdsDiarioTOTCUS: TFloatField;
    cdsDiarioTOTPER: TFloatField;
    cdsDiarioTOTPED: TFloatField;
    cdsDiarioPEDPEN: TIntegerField;
    cdsDiarioPEDFAT: TIntegerField;
    cdsDiarioVALVEN: TFloatField;
    cdsDiarioCUSVEN: TFloatField;
    rdgTipCal: TRadioGroup;
    Label8: TLabel;
    cbbComCus: TComboBoxFocus;
    frxResumoVendedor: TfrxDBDataset;
    ckbResumoVendedor: TCheckBox;
    rdgEmpresa: TRadioGroup;
    rdgTipoCalculo: TRadioGroup;
    cdsMeta: TUniClientDataSet;
    cdsMetaINDEX: TIntegerField;
    cdsMetaDIAUTI: TFloatField;
    cdsMetaMESANO: TStringField;
    cdsMetaMETDIA: TFloatField;
    cdsMetaMETPRO: TFloatField;
    cdsMetaMETREA: TFloatField;
    cdsMetaRESULT: TFloatField;
    cdsMetaMARMES: TFloatField;
    cdsMetaMARREA: TFloatField;
    cdsMetaLITPRO: TFloatField;
    cdsMetaLITREA: TFloatField;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure edtCodVenExit(Sender: TObject);
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  private
    { Private declarations }
    procedure pGetPrazoMedio(dtaIni, dtaFin: TDate; out fltPMVVista, fltPMCTotal, fltPMCPrazo, fltPMVTotal, fltPMVPrazo: Double);
  public
    { Public declarations }
  end;

var
  frmRelEstatDemonsFat: TfrmRelEstatDemonsFat;

Const
  VEN_TODOS   = 0;
  VEN_INTERNO = 1;
  VEN_EXTERNO = 2;

  TIP_MARGEM = 0;
  TIP_MARKUP = 1; 

implementation

uses untTMetAno, untIMetAno, untConstantes, untFuncoesSimples, untFuncoes, TypesRel,
     untFuncoesRelatorios, untConsultas;

{$R *.dfm}

procedure TfrmRelEstatDemonsFat.btnImprimirClick(Sender: TObject);
  Var
    qryResumoVendedor,
    qryMediaDoc,
    qryRel: TUniQuery;
    objMetAno: IMetAno;
    objMetAnoCds: IMetAno; {criei esse cara somente para alimentar o cdsMeta igual é alimentando na untCadEmpresas}
    dtaIni, dtaFin: TDate;
    fltPMVVista, fltPMCTotal, fltPMCPrazo, fltPMVTotal, fltPMVPrazo: Double;
    blnEntBR: Boolean;
    strSQL, strCampoCusto: String;

  procedure pSetVar(strNome: String; varValue: Variant);
  begin
    frxReport.Script.Variables[strNome] := varValue;
  end;
begin
  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;
  qryRel := fCriaQuery;
  qryResumoVendedor := fCriaQuery;
  qryMediaDoc := fCriaQuery;
  frxResumoVendedor.DataSet := qryResumoVendedor;
  objMetAno :=  TMetAno.Create(True);
  objMetAno.pSetaEmpOrigemCusto(rdgEmpresa.ItemIndex = 1, cbbComCus.Items.Strings[cbbComCus.ItemIndex]);
  objMetAnoCds := TMetAno.Create(True);
  objMetAnoCds.pSetaEmpOrigemCusto(rdgEmpresa.ItemIndex = 1, cbbComCus.Items.Strings[cbbComCus.ItemIndex]);
  cdsDiario.EmptyDataSet;
  Try
    inherited;

    If Not blnImprime Then
      Exit;

    dtaIni := StrToDate('01/' + mskMesAno.Text);
    dtaFin := IncDay(IncMonth(dtaIni), -1);

    if rdgTipoCalculo.ItemIndex = 0 then
      objMetAno.pCarregar(RightStr(mskMesAno.Text, 4), 0, 0, edtCodEmp.Text, False)
    else
      objMetAno.pCarregar(RightStr(mskMesAno.Text, 4), 0, 0, edtCodEmp.Text, False, nil, False, StrToInt(LeftStr(mskMesAno.Text,2)), StrToInt(LeftStr(mskMesAno.Text,2)), True, 0);

    objMetAno.pSetMes(StrToInt(LeftStr(mskMesAno.Text,2)));

    if rdgTipoCalculo.ItemIndex = 0 then
      objMetAnoCds.pCarregar(RightStr(mskMesAno.Text, 4), 0, 0, edtCodEmp.Text, False, cdsMeta, True)
    else
      objMetAnoCds.pCarregar(RightStr(mskMesAno.Text, 4), 0, 0, edtCodEmp.Text, False, cdsMeta, True, StrToInt(LeftStr(mskMesAno.Text,2)), StrToInt(LeftStr(mskMesAno.Text,2)), True, 0);

    objMetAnoCds.pSetMes(StrToInt(LeftStr(mskMesAno.Text,2)));

    If objMetAno.MetaAno = 0 Then
    Begin
      fMensagem('ATENÇÃO', 'Meta não cadastrada para o ' + IIF(rdgTipoCalculo.ItemIndex = 0, 'ano', 'mês') + ' escolhido. Favor calcular meta pelo cadastro de empresas!', ['&O k']);
      Exit;
    End;

    blnEntBR := fCfgSis('ENTBRF', varBoolean);

    frxReport.FindObject('ChildEntSaiMer').Visible := True;

    pSetVar('NOMREL'  , 'DEMONSTRATIVO DE FATURAMENTO');
    pSetVar('PERIODO' , 'REFERENTE AO PERÍODO DE ' + FormatDateTime('dd/mm/yyyy', dtaIni) + ' A ' + FormatDateTime('dd/mm/yyyy', dtaFin));
    pSetVar('EMPRESA' , 'EMPRESA:' + edtCodEmp.Text + ' - ' + edtDesEmp.Text);
    pSetVar('VENDEDOR', 'VENDEDOR: TODOS');
    pSetVar('CUSTO'   , 'CUSTO POR: ' + cbbComCus.Text);

    pSetVar('TIPCAL', IfThen(rdgTipCal.ItemIndex = TIP_MARGEM, 'Margem', 'Markup'));

    pSetVar('MES_OBJETIVO', objMetAno.MesAtual.fltMetaProjetada);
    pSetVar('MES_DIASUTEIS', objMetAno.MesAtual.fltDiasUteis);
    pSetVar('MES_REALIZADO', objMetAno.MesAtual.fltMetaRealizada);
    pSetVar('MES_DIASCORRIDOS', objMetAno.fGetDiasCorridos);

    With qryRel, SQL Do
    Begin
      Add('SELECT');
      Add('  SUM(IF(DET_CONPAG =  "01000", DET_VALRET + DET_VALIPI + IFNULL(MOVTRI.DET_VAEIPI,0) + DET_TOTITE - DET_DESESP + DET_TOTFRE + DET_DESACE' + fSqlValorReformaRef('MOVREF', 'MOVDET.AUTOINCREM') + ', 0)) AS TOTVIS,');
      Add('  SUM(IF(DET_CONPAG <> "01000", DET_VALRET + DET_VALIPI + IFNULL(MOVTRI.DET_VAEIPI,0) + DET_TOTITE - DET_DESESP + DET_TOTFRE + DET_DESACE' + fSqlValorReformaRef('MOVREF', 'MOVDET.AUTOINCREM') + ', 0)) AS TOTPRA');
      Add('FROM');
      Add('  MOVDET ');
      Add('  LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM');
      Add('WHERE');
      Add('  DET_TIP_FC = "F" AND ');
        If (rdgEmpresa.ItemIndex = 0) Then
          Add('  MOVDET.DET_CODEMP = :CODEMP AND')
        Else
          Add('  MOVTRI.DET_EMPORI = :CODEMP AND');
      Add('  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND');
      Add('  DET_PROEMB <> "S" AND');
      Add('  LOCATE(DET_CLAFIS, :VALRES) > 0 ');
      ParamByName('CODEMP').AsString := edtCodEmp.Text;
      ParamByName('DTAINI').AsDate   := dtaIni;
      ParamByName('DTAFIN').AsDate   := dtaFin;
      ParamByName('VALRES').AsString := VS_strClaCom;

      Open;
      pSetVar('ENT_VISTA', FieldByName('TOTVIS').AsFloat);
      pSetVar('ENT_PRAZO', FieldByName('TOTPRA').AsFloat);
      Close;

      Clear;
      Add(' SELECT ');
      Add('  SUM(IF(DET_CONPAG =  "01000", IF(DET_ESPDOC = "BR" OR LOCATE(DET_CLAFIS, ' + CLAFIS_BR + ') > 0, 0, 1) * IF(LEFT(DET_CLAFIS,1) < 5, -1, 1) * (DET_TOTITE-DET_DESESP-DET_DESCFF), 0)) TOTVIS,');
      Add('  SUM(IF(DET_CONPAG <> "01000", IF(DET_ESPDOC = "BR" OR LOCATE(DET_CLAFIS, ' + CLAFIS_BR + ') > 0, 0, 1) * IF(LEFT(DET_CLAFIS,1) < 5, -1, 1) * (DET_TOTITE-DET_DESESP-DET_DESCFF), 0)) TOTPRA');
      Add(' FROM ');
      Add('  MOVDET ');
      Add('  LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM');
      Add(' WHERE ');
      Add('  DET_TIP_FC = "C" AND ');
      Add( cnsFiltroFFDVTR );
        If (rdgEmpresa.ItemIndex = 0) Then
          Add('  MOVDET.DET_CODEMP = :CODEMP AND')
        Else
          Add('  MOVTRI.DET_EMPORI = :CODEMP AND');
      Add('  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND');
      Add('  DET_PROEMB <> "S" AND');
      Add('  DET_CODCLI NOT IN (' + VS_strCliFil + ') AND');
      Add('  ( LOCATE(DET_CLAFIS, :CLAFIS) > 0 ' + IfThen(blnEntBR, 'OR DET_ESPDOC = "BR"', '') + ' )');

      strSQL := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(qryRel.SQL.Text);

      Clear;
      Add(' SELECT ');
      Add('   SUM(TOTVIS) AS TOTVIS, ');
      Add('   SUM(TOTPRA) AS TOTPRA ');
      Add(' FROM ( '+strSQL+' ) AS TAB');

      ParamByName('CODEMP').AsString := edtCodEmp.Text;
      ParamByName('DTAINI').AsDate := dtaIni;
      ParamByName('DTAFIN').AsDate := dtaFin;
      ParamByName('CLAFIS').AsString := VS_strClaVen + '_'+ VS_strClaDev;

      If fCfgSis('ENTBRF', varBoolean) Then
        ParamByName('CLAFIS').AsString := ParamByName('CLAFIS').AsString + '_' + CLAFIS_BR;

      Open;
      pSetVar('SAI_VISTA', FieldByName('TOTVIS').AsFloat);
      pSetVar('SAI_PRAZO', FieldByName('TOTPRA').AsFloat);
      Close;

      pGetPrazoMedio(dtaIni, dtaFin, fltPMVVista, fltPMCTotal, fltPMCPrazo, fltPMVTotal, fltPMVPrazo);
      pSetVar('ENT_PMCTOTAL', fltPMCTotal);
      pSetVar('ENT_PMCPRAZO', fltPMCPrazo);
      pSetVar('SAI_PMVTOTAL', fltPMVTotal);
      pSetVar('SAI_PMVPRAZO', fltPMVPrazo);
      pSetVar('SAI_PMVVISTA', fltPMVVista);
      
      Clear;
      Add('  SELECT');
      Add('    OPE_INTEXT,');
      Add('    DET_CODCLI');
      Add('  FROM');
      Add('    MOVDET ');
      Add('  LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM');
      Add('    JOIN CADOPE ON OPE_CODOPE = DET_CODVEN');
      Add('  WHERE');
      Add('    DET_TIP_FC = "C" AND');
        If (rdgEmpresa.ItemIndex = 0) Then
          Add('  MOVDET.DET_CODEMP = :CODEMP AND')
        Else
          Add('  MOVTRI.DET_EMPORI = :CODEMP AND');
      Add('    DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND');
      Add('    DET_PROEMB <> "S" AND');
      Add('    DET_CODCLI NOT IN (' + VS_strCliFil + ') AND');
      Add('    ( LOCATE(DET_CLAFIS, :CLAFIS) > 0 ' + IfThen(blnEntBR, 'OR DET_ESPDOC = "BR"', '') + ' )');
      strSQL := Text;

      Clear;
      Add('SELECT');
      Add('  SUM(IF(OPE_INTEXT =  "I", QTD, 0)) AS CLIINT,');
      Add('  SUM(IF(OPE_INTEXT <> "I", QTD, 0)) AS CLIEXT');
      Add('FROM');
      Add('  (');
      Add('  SELECT');
      Add('    OPE_INTEXT,');
      Add('    1 AS QTD');
      Add('  FROM');
      Add('    (' + strSQL + ') TAB ');
      Add('  GROUP BY');
      Add('    DET_CODCLI');
      Add('  ) TAB');
      ParamByName('CODEMP').AsString := edtCodEmp.Text;
      ParamByName('DTAINI').AsDate := dtaIni;
      ParamByName('DTAFIN').AsDate := dtaFin;
      ParamByName('CLAFIS').AsString := VS_strClaVen + '_'+ VS_strClaDev;

      If fCfgSis('ENTBRF', varBoolean) Then
        ParamByName('CLAFIS').AsString := ParamByName('CLAFIS').AsString + '_' + CLAFIS_BR;

      Open;
      pSetVar('VEN_CLIINT', FieldByName('CLIINT').AsInteger);
      pSetVar('VEN_CLIREP', FieldByName('CLIEXT').AsInteger);
      Close;

      //TICKETS
      Clear;
      Add('SELECT');
      Add('  SUM(IF(OPE_INTEXT = "I", 1, 0)) AS TICINT,');
      Add('  SUM(IF(OPE_INTEXT <> "I", 1, 0)) AS TICEXT');
      Add('FROM');
      Add('  MOVGER ');
      Add('  JOIN CADOPE ON OPE_CODOPE = GER_CODVEN');
      Add('WHERE');
      Add('  GER_TIP_FC = "C" AND');
      Add('  GER_CODEMP = :CODEMP AND');
      Add('  GER_DTAENT BETWEEN :DTAINI AND :DTAFIN AND');
      Add('  GER_CODCLI NOT IN (' + VS_strCliFil + ') AND');
      Add('  ( LOCATE(GER_CLAFIS, :CLAFIS) > 0 '+ IfThen(blnEntBR, 'OR GER_ESPDOC = "BR"', '') +' )');
      strSQL := Text;

      Clear;
      Add('SELECT');
      Add('  SUM(TICINT) AS TICINT,');
      Add('  SUM(TICEXT) AS TICEXT');
      Add('FROM');
      Add('  ('+ strSQL +') TAB');

      ParamByName('CODEMP').AsString := edtCodEmp.Text;
      ParamByName('DTAINI').AsDate := dtaIni;
      ParamByName('DTAFIN').AsDate := dtaFin;
      ParamByName('CLAFIS').AsString := VS_strClaVen + '_'+ VS_strClaDev;

      If fCfgSis('ENTBRF', varBoolean) Then
        ParamByName('CLAFIS').AsString := ParamByName('CLAFIS').AsString + '_' + CLAFIS_BR;

      Open;
      pSetVar('VEN_TICKETINT', FieldByName('TICINT').AsFloat);
      pSetVar('VEN_TICKETREP', FieldByName('TICEXT').AsFloat);
      Close;
      //END TICKETS

      Clear;
      Add('SELECT');
      Add('  SUM(IF(OPE_INTEXT <> "I", 0, IF(DET_ESPDOC = "BR" OR LOCATE(DET_CLAFIS, ' + CLAFIS_BR + ') > 0, 0, 1) * IF(LEFT(DET_CLAFIS,1) < 5, -1, 1) * (DET_TOTITE - DET_DESESP - DET_DESCFF))) AS TOTINT,');
      Add('  SUM(IF(OPE_INTEXT <> "I", 0, IF(DET_ESPDOC = "BR" OR LOCATE(DET_CLAFIS, ' + CLAFIS_BR + ') > 0, 0, 1) * IF(LEFT(DET_CLAFIS,1) < 5, -1, 1) * (DET_TOTCOM))) AS COMINT,');
      Add('  SUM(IF(OPE_INTEXT =  "I", 0, IF(DET_ESPDOC = "BR" OR LOCATE(DET_CLAFIS, ' + CLAFIS_BR + ') > 0, 0, 1) * IF(LEFT(DET_CLAFIS,1) < 5, -1, 1) * (DET_TOTITE - DET_DESESP - DET_DESCFF))) AS TOTEXT,');
      Add('  SUM(IF(OPE_INTEXT =  "I", 0, IF(DET_ESPDOC = "BR" OR LOCATE(DET_CLAFIS, ' + CLAFIS_BR + ') > 0, 0, 1) * IF(LEFT(DET_CLAFIS,1) < 5, -1, 1) * (DET_TOTCOM))) AS COMEXT');
      Add('FROM');
      Add('  MOVDET D');
      Add('  LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = D.AUTOINCREM');
      Add('  JOIN CADOPE ON OPE_CODOPE = DET_CODVEN');
      Add('WHERE');
      Add('  DET_TIP_FC = "C" AND');
      Add( cnsFiltroFFDVTR );
        If (rdgEmpresa.ItemIndex = 0) Then
          Add('  D.DET_CODEMP = :CODEMP AND')
        Else
          Add('  MOVTRI.DET_EMPORI = :CODEMP AND');
      Add('  D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND');
      Add('  DET_PROEMB <> "S" AND');
      Add('  DET_CODCLI NOT IN (' + VS_strCliFil + ') AND');
      Add('  ( LOCATE(DET_CLAFIS, :CLAFIS) > 0 '+ IfThen(blnEntBR, 'OR DET_ESPDOC = "BR"', '') +' )');

      strSQL := Text;
      strSQL := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL);

      Clear;
      Add('SELECT');
      Add('  SUM(TOTINT) AS TOTINT,');
      Add('  SUM(COMINT) AS COMINT,');
      Add('  SUM(TOTEXT) AS TOTEXT,');
      Add('  SUM(COMEXT) AS COMEXT');
      Add('FROM');
      Add('  ('+ strSQL +') TAB');

      ParamByName('CODEMP').AsString := edtCodEmp.Text;
      ParamByName('DTAINI').AsDate := dtaIni;
      ParamByName('DTAFIN').AsDate := dtaFin;
      ParamByName('CLAFIS').AsString := VS_strClaVen + '_'+ VS_strClaDev;

      If fCfgSis('ENTBRF', varBoolean) Then
        ParamByName('CLAFIS').AsString := ParamByName('CLAFIS').AsString + '_' + CLAFIS_BR;

      Open;
      pSetVar('VEN_VALORINT', FieldByName('TOTINT').AsFloat);
      pSetVar('VEN_VALORREP', FieldByName('TOTEXT').AsFloat);
      pSetVar('VEN_COMINT',   FieldByName('COMINT').AsFloat);
      pSetVar('VEN_COMREP',   FieldByName('COMEXT').AsFloat);
      Close;

      // FRETE
      Clear;
      Add('SELECT');
      Add('  SUM(IF(OPE_INTEXT <> "I", 0, IF(LEFT(GER_CLAFIS,1) < 5, -1, 1) * (AUX_FRESUG))) AS FREINT,');
      Add('  SUM(IF(OPE_INTEXT =  "I", 0, IF(LEFT(GER_CLAFIS,1) < 5, -1, 1) * (AUX_FRESUG))) AS FREEXT');
      Add('FROM');
      Add('  MOVGER G');
      Add('  JOIN AUXMOV A ON A.AUX_SEQGER = G.AUTOINCREM');
      Add('  JOIN CADOPE ON OPE_CODOPE = GER_CODVEN');
      Add('WHERE');
      Add('  GER_TIP_FC = "C" AND');
      Add('  GER_CODEMP = :CODEMP AND');
      Add('  GER_DTAENT BETWEEN :DTAINI AND :DTAFIN AND');
      Add('  GER_CODCLI NOT IN (' + VS_strCliFil + ') AND');
      Add('  ( LOCATE(GER_CLAFIS, :CLAFIS) > 0 '+ IfThen(blnEntBR, 'OR GER_ESPDOC = "BR"', '') +' )');
      strSQL := Text;

      Clear;
      Add('SELECT');
      Add('  SUM(FREINT) AS FREINT,');
      Add('  SUM(FREEXT) AS FREEXT');
      Add('FROM');
      Add('  ('+ strSQL +') TAB');

      ParamByName('CODEMP').AsString := edtCodEmp.Text;
      ParamByName('DTAINI').AsDate := dtaIni;
      ParamByName('DTAFIN').AsDate := dtaFin;
      ParamByName('CLAFIS').AsString := VS_strClaVen + '_'+ VS_strClaDev;

      If fCfgSis('ENTBRF', varBoolean) Then
        ParamByName('CLAFIS').AsString := ParamByName('CLAFIS').AsString + '_' + CLAFIS_BR;

      Open;
      pSetVar('VEN_FRETEINT', FieldByName('FREINT').AsFloat);
      pSetVar('VEN_FRETEREP', FieldByName('FREEXT').AsFloat);
      Close;
      // END FRETE

      Clear;
      Add('  SELECT');
      Add('    DAY(DET_DTAENT) AS DIA,');
      Add('    IF(DET_ESPDOC = "BR" OR LOCATE(DET_CLAFIS, ' + CLAFIS_BR + ') > 0, 0, 1) * IF(LEFT(DET_CLAFIS,1) < 5, -1, 1) * (DET_TOTITE - DET_DESESP - DET_DESCFF) AS TOTVEN,');

      strCampoCusto := '  IFNULL(' + fRetornaComposicao(cbbComCus.Items.Strings[cbbComCus.ItemIndex]) + ',0) ';

      Add('     IF(LEFT(DET_CLAFIS,1) < 5, -1, 1) * ' + strCampoCusto + ' AS TOTCUS');

      Add('  FROM');
      Add('    MOVDET D');
      Add('     JOIN      MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM');
      Add('     LEFT JOIN MOVICD   ON ICD_SEQGER   = D.AUTOINCREM ');
      Add('  WHERE');
      Add('    DET_TIP_FC = "C" AND ');
      Add( cnsFiltroFFDVTR );
        If (rdgEmpresa.ItemIndex = 0) Then
          Add(' D.DET_CODEMP = :CODEMP AND')
        Else
          Add(' T.DET_EMPORI = :CODEMP AND');
      Add('    DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND');
      Add('    DET_PROEMB <> "S" AND');
      Add('    DET_CODCLI NOT IN (' + VS_strCliFil + ') AND');
      Add('    ( LOCATE(DET_CLAFIS, :CLAFIS) > 0 '+ IfThen(blnEntBR, 'OR DET_ESPDOC = "BR"', '') +' )');

      strSQL := Text;
      strSQL := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL);

      Clear;
      Add('SELECT');
      Add('  DIA,');
      Add('  SUM(TOTVEN) AS TOTVEN,');
      Add('  SUM(TOTCUS) AS TOTCUS');
      Add('FROM');
      Add('  (');
      Add(   strSQL);
      Add('  ) TAB');
      Add('GROUP BY');
      Add('  DIA');
      Add('ORDER BY');
      Add('  DIA');
      ParamByName('CODEMP').AsString := edtCodEmp.Text;
      ParamByName('DTAINI').AsDate := dtaIni;
      ParamByName('DTAFIN').AsDate := dtaFin;
      ParamByName('CLAFIS').AsString := VS_strClaVen + '_' + VS_strClaDev;

      If fCfgSis('ENTBRF', varBoolean) Then
        ParamByName('CLAFIS').AsString := ParamByName('CLAFIS').AsString + '_' + CLAFIS_BR;

      Open;
      {**************************}
      {* INICIA INSERÇÃO NO CDS *}
      {***********************AL*}
      First;
      While Not Eof Do
      Begin
        cdsDiario.Insert;
        cdsDiarioINTDIA.AsInteger := FieldByName('DIA').AsInteger;
        cdsDiarioSTRDIA.AsString  := FieldByName('DIA').AsString + '/' + String(arrMesAbr[MonthOf(dtaIni)]);
        cdsDiarioTOTVEN.AsFloat   := FieldByName('TOTVEN').AsFloat;
        cdsDiarioTOTCUS.AsFloat   := FieldByName('TOTCUS').AsFloat;
        cdsDiario.Post;
        Next;
      End;
      Close;

      Clear;
      Add('SELECT');
      Add('  DAY(VPG_DTACAD) AS DIA,');
      Add('  SUM(VPD_QTDITE * VPD_UNITAR) AS TOTPER');
      Add('FROM');
      Add('  MOVVPD');
      Add('  JOIN MOVVPG ON VPG_CODIGO = VPD_CODIGO');
      Add('             AND VPG_CODEMP = VPD_CODEMP');
      Add('  JOIN ITEGER ON ITE_CODITE = VPD_CODITE');
      Add('             AND ITE_CODEMP = VPD_CODEMP');
      Add('WHERE');
      Add('  VPG_DTACAD BETWEEN :DTAINI AND :DTAFIN AND');
      Add('  VPG_CODEMP = :CODEMP');
      Add('GROUP BY');
      Add('  DIA');
      Add('ORDER BY');
      Add('  DIA');
      ParamByName('DTAINI').AsDate := dtaIni;
      ParamByName('DTAFIN').AsDate := dtaFin;
      ParamByName('CODEMP').AsString := edtCodEmp.Text;

      Open;
      First;
      While Not Eof Do
      Begin
        If cdsDiario.Locate('INTDIA', FieldByName('DIA').AsInteger, []) Then
          cdsDiario.Edit
        Else
          cdsDiario.Insert;

        cdsDiarioINTDIA.AsInteger := FieldByName('DIA').AsInteger;
        cdsDiarioSTRDIA.AsString := FieldByName('DIA').AsString + '/' + String(arrMesAbr[MonthOf(dtaIni)]);
        cdsDiarioTOTPER.AsFloat := FieldByName('TOTPER').AsFloat;

        cdsDiario.Post;
        Next;
      End;
      Close;

      Clear;
      Add('SELECT');
      Add('  DAY(FDO_DTAENT) AS DIA,');
      Add('  SUM((FDO_QTDITE - FDO_QTDBAI) * ((FDO_TOTITE + FDO_VALIPI + FDO_VALRET + FDO_TOTFRE' + fSqlValorReformaFdoRef('D.AUTOINCREM') + ' - FDO_DESESP) / FDO_QTDITE)) AS TOTPED');
      Add('FROM');
      Add('  FATDOR D');
      Add('  INNER JOIN FATGOR G ON G.AUTOINCREM = D.FDO_SEQGER');
      Add('  INNER JOIN EXTDOR E ON E.FDO_SEQFDO = D.AUTOINCREM');
      Add('WHERE');
      Add('  FDO_DTAENT BETWEEN :DTAINI AND :DTAFIN AND');
      Add('  FDO_ESPDOC = "PD" AND');
      Add('  FDO_CODEMP = :CODEMP AND');
      Add('  FDO_JAFATU = 0 AND');
      Add('  IFNULL(FDO_INCFUT,"") = "" AND ');//NAO DEVE CONSIDERAR PEDIDOS DE BAIXA DE ENTREGA FUTURA
      Add('  ROUND(FDO_QTDBAI, 2) < ROUND(FDO_QTDITE, 2)');
      Add('GROUP BY');
      Add('  DIA');
      ParamByName('CODEMP').AsString := edtCodEmp.Text;
      ParamByName('DTAINI').AsDate := dtaIni;
      ParamByName('DTAFIN').AsDate := dtaFin;

      Open;
      First;
      While Not Eof Do
      Begin
        If cdsDiario.Locate('INTDIA', FieldByName('DIA').AsInteger, []) Then
          cdsDiario.Edit
        Else
          cdsDiario.Insert;

        cdsDiarioINTDIA.AsInteger := FieldByName('DIA').AsInteger;
        cdsDiarioSTRDIA.AsString  := FieldByName('DIA').AsString + '/' + String(arrMesAbr[MonthOf(dtaIni)]);
        cdsDiarioTOTPED.AsFloat   := FieldByName('TOTPED').AsFloat;
        cdsDiario.Post;
        Next;
      End;
      Close;

      Clear;
      Add('SELECT');
      Add('  DIA,');
      Add('  SUM(PEDFAT) AS PEDFAT');
      Add('FROM');
      Add('  (');
      Add('SELECT');
      Add('  DAY(FGO_DTAFAT) AS DIA,');
      Add('  1 AS PEDFAT');
      Add('FROM');
      Add('  FATDOR D');
      Add('  INNER JOIN FATGOR G ON G.AUTOINCREM = D.FDO_SEQGER');
      Add('  INNER JOIN EXTDOR E ON E.FDO_SEQFDO = D.AUTOINCREM');
      Add('WHERE');
      Add('  FGO_DTAFAT BETWEEN :DTAINI AND :DTAFIN AND');
      Add('  FGO_CODEMP = :CODEMP AND');
      Add('  FGO_ESPDOC = "PD" AND');
      Add('  FGO_JAFATU = 1 AND');
      Add('  IFNULL(FDO_INCFUT,"") = "" AND ');//NAO DEVE CONSIDERAR PEDIDOS DE BAIXA DE ENTREGA FUTURA
      Add('  (((IFNULL((SELECT COUNT(*) FROM FATDOR F');
      Add('                            WHERE (F.FDO_SEQGER = D.FDO_SEQGER) AND (FDO_QTDBAI > 0)), 0) > 0) AND (FGO_MOTBAI IS NULL))');
      Add('                               OR (FDO_JAFATU = 1 AND FGO_MOTBAI IS NULL))');
      Add('GROUP BY');
      Add('  DIA,');
      Add('  G.AUTOINCREM');
      Add('  ) TAB');
      Add('GROUP BY');
      Add('  DIA');
      ParamByName('CODEMP').AsString := edtCodEmp.Text;
      ParamByName('DTAINI').AsDate := dtaIni;
      ParamByName('DTAFIN').AsDate := dtaFin;

      Open;
      First;
      While Not Eof Do
      Begin
        If cdsDiario.Locate('INTDIA', FieldByName('DIA').AsInteger, []) Then
          cdsDiario.Edit
        Else
          cdsDiario.Insert;

        cdsDiarioINTDIA.AsInteger := FieldByName('DIA').AsInteger;
        cdsDiarioSTRDIA.AsString  := FieldByName('DIA').AsString + '/' + String(arrMesAbr[MonthOf(dtaIni)]);
        cdsDiarioPEDFAT.AsInteger := FieldByName('PEDFAT').AsInteger;
        cdsDiario.Post;
        Next;
      End;
      Close;

      Clear;
      Add('SELECT');
      Add('  DIA,');
      Add('  SUM(PEDPEN) AS PEDPEN');
      Add('FROM');
      Add('  (');
      Add('SELECT');
      Add('  DAY(FGO_DTAENT) AS DIA,');
      Add('  1 AS PEDPEN');
      Add('FROM');
      Add('  FATDOR D');
      Add('  INNER JOIN FATGOR G ON G.AUTOINCREM = D.FDO_SEQGER');
      Add('  INNER JOIN EXTDOR E ON E.FDO_SEQFDO = D.AUTOINCREM');
      Add('WHERE');
      Add('  FDO_DTAENT BETWEEN :DTAINI AND :DTAFIN AND');
      Add('  FDO_CODEMP = :CODEMP AND');
      Add('  FDO_ESPDOC = "PD" AND');
      Add('  FDO_JAFATU = 0 AND');
      Add('  IFNULL(FDO_INCFUT,"") = "" AND ');//NAO DEVE CONSIDERAR PEDIDOS DE BAIXA DE ENTREGA FUTURA
      Add('  ROUND(FDO_QTDBAI, 2) < ROUND(FDO_QTDITE, 2)');
      Add('GROUP BY');
      Add('  DIA,');
      Add('  G.AUTOINCREM');
      Add('  ) TAB');
      Add('GROUP BY');
      Add('  DIA');
      ParamByName('CODEMP').AsString := edtCodEmp.Text;
      ParamByName('DTAINI').AsDate := dtaIni;
      ParamByName('DTAFIN').AsDate := dtaFin;

      Open;
      First;
      While Not Eof Do
      Begin
        If cdsDiario.Locate('INTDIA', FieldByName('DIA').AsInteger, []) Then
          cdsDiario.Edit
        Else
          cdsDiario.Insert;

        cdsDiarioINTDIA.AsInteger := FieldByName('DIA').AsInteger;
        cdsDiarioSTRDIA.AsString  := FieldByName('DIA').AsString + '/' + String(arrMesAbr[MonthOf(dtaIni)]);
        cdsDiarioPEDPEN.AsInteger := FieldByName('PEDPEN').AsInteger;
        cdsDiario.Post;
        Next;
      End;
      Close;

      If (Not fEmptyStr(edtCodVen.Text)) Or (rdgTipVen.ItemIndex <> VEN_TODOS) Then
      Begin
        If Not fEmptyStr(edtCodVen.Text) Then
          pSetVar('VENDEDOR', 'VENDEDOR: ' + edtCodVen.Text + ' - ' + edtDesVen.Text)
        Else
          pSetVar('VENDEDOR', 'VENDEDOR: TODOS ' + IfThen(rdgTipVen.ItemIndex = VEN_INTERNO , 'INTERNOS', 'EXTERNOS'));

        Clear;
        Add('  SELECT');
        Add('    DAY(DET_DTAENT) AS DIA,');
        Add('    IF(DET_ESPDOC = "BR" OR LOCATE(DET_CLAFIS, ' + CLAFIS_BR + ') > 0, 0, 1) * IF(LEFT(DET_CLAFIS,1) < 5, -1, 1) * (DET_TOTITE - DET_DESESP - DET_DESCFF) AS TOTVEN,');
        Add('    IF(LEFT(DET_CLAFIS,1) < 5, -1, 1) * '+strCampoCusto+' AS TOTCUS');

        Add('  FROM');
        Add('    MOVDET D');

        Add('  LEFT JOIN CADOPE ON CADOPE.OPE_CODOPE = D.DET_CODVEN ');
        Add('  LEFT JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM');
        Add('  LEFT JOIN MOVICD ON MOVICD.ICD_SEQGER = D.AUTOINCREM');
        Add('    AND IF(IFNULL(MOVICD.ICD_FCPPRO, "") = "", D.DET_VALRET = 0, MOVICD.ICD_FCPPRO = "S") ');

        Add('  WHERE ');
        Add('    DET_TIP_FC = "C" AND ');
        Add( cnsFiltroFFDVTR );
        If (rdgEmpresa.ItemIndex = 0) Then
          Add('  D.DET_CODEMP = :CODEMP AND')
        Else
          Add('  T.DET_EMPORI = :CODEMP AND');
        Add('    DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND');
        Add('    DET_PROEMB <> "S" AND');
        Add('    DET_CODCLI NOT IN (' + VS_strCliFil + ') AND');
        Add('    ( LOCATE(DET_CLAFIS, :CLAFIS) > 0 '+ IfThen(blnEntBR, 'OR DET_ESPDOC = "BR"', '') +' ) AND');
        Add('    DET_CODVEN');

        If Not fEmptyStr(edtCodVen.Text) Then
          Add('    = :CODVEN')
        Else
        Begin
          Add('    = OPE_CODOPE AND');
          Add('    OPE_INTEXT = :INTEXT');
        End;

        strSQL := Text;
        strSQL := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL);

        Clear;
        Add('SELECT');
        Add('  DIA,');
        Add('  SUM(TOTVEN) AS TOTVEN,');
        Add('  SUM(TOTCUS) AS TOTCUS');
        Add('FROM');
        Add('  (');
        Add(   strSQL);
        Add('  ) TAB');
        Add('GROUP BY');
        Add('  DIA');
        Add('ORDER BY');
        Add('  DIA');
        ParamByName('CODEMP').AsString := edtCodEmp.Text;
        ParamByName('DTAINI').AsDate := dtaIni;
        ParamByName('DTAFIN').AsDate := dtaFin;
        ParamByName('CLAFIS').AsString := VS_strClaVen + '_'+ VS_strClaDev;
        If fCfgSis('ENTBRF', varBoolean) Then
          ParamByName('CLAFIS').AsString := ParamByName('CLAFIS').AsString + '_' + CLAFIS_BR;
        If Not fEmptyStr(edtCodVen.Text) Then
          ParamByName('CODVEN').AsString := edtCodVen.Text
        Else
          ParamByName('INTEXT').AsString := IfThen(rdgTipVen.ItemIndex = VEN_INTERNO, 'I', 'E');

        Open;
        First;
        While Not Eof Do
        Begin
          If cdsDiario.Locate('INTDIA', FieldByName('DIA').AsInteger, []) Then
            cdsDiario.Edit
          Else
            cdsDiario.Insert;

          cdsDiarioINTDIA.AsInteger := FieldByName('DIA').AsInteger;
          cdsDiarioSTRDIA.AsString  := FieldByName('DIA').AsString + '/' + String(arrMesAbr[MonthOf(dtaIni)]);
          cdsDiarioVALVEN.AsFloat   := FieldByName('TOTVEN').AsFloat;
          cdsDiarioCUSVEN.AsFloat   := FieldByName('TOTCUS').AsFloat;
          cdsDiario.Post;
          Next;
        End;
        Close;
      End;

      with qryMediaDoc, SQL Do
      begin
        Close;
        Clear;
        Add('SELECT');
        Add('  SUM(D.DET_QTDITE) / COUNT(DISTINCT D.DET_SEQGER) AS MEDQTD, ');
        Add('  COUNT(D.DET_CODITE) / COUNT(DISTINCT D.DET_SEQGER) AS MEDSKU ');
        Add('FROM');
        Add('  MOVDET D');
        Add('  LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = D.AUTOINCREM');
        Add('  JOIN CADOPE ON OPE_CODOPE = DET_CODVEN');
        Add('WHERE');
        Add('  DET_TIP_FC = "C" AND');
        If (rdgEmpresa.ItemIndex = 0) Then
          Add('  D.DET_CODEMP = :CODEMP AND')
        Else
          Add('  MOVTRI.DET_EMPORI = :CODEMP AND');
        Add('  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND');
        Add('  DET_PROEMB <> "S" AND');
        Add('  DET_CODCLI NOT IN (' + VS_strCliFil + ') AND');
        Add('  ( LOCATE(DET_CLAFIS, :CLAFIS) > 0 '+ IfThen(blnEntBR, 'OR DET_ESPDOC = "BR"', '') +' )');

        ParamByName('CODEMP').AsString := edtCodEmp.Text;
        ParamByName('DTAINI').AsDate := dtaIni;
        ParamByName('DTAFIN').AsDate := dtaFin;
        ParamByName('CLAFIS').AsString := VS_strClaVen + '_'+ VS_strClaDev;
        If fCfgSis('ENTBRF', varBoolean) Then
          ParamByName('CLAFIS').AsString := ParamByName('CLAFIS').AsString + '_' + CLAFIS_BR;

        Open;

        pSetVar('MED_MEDQTD', FieldByName('MEDQTD').AsFloat);
        pSetVar('MED_MEDSKU', FieldByName('MEDSKU').AsFloat);
      end;

      With qryResumoVendedor, SQL Do
      Begin
        Close;
        Clear;
        Add('SELECT');
        Add('  D.DET_SEQGER AS SEQGER,');
        Add('  IF(OPE_INTEXT <> "I","REP","VEN") AS VENREP,');
        Add('  OPE_CODOPE AS CODOPE,');
        Add('  OPE_NOMOPE AS NOMOPE,');
        Add('  IF(DET_ESPDOC = "BR" OR LOCATE(DET_CLAFIS, ' + CLAFIS_BR + ') > 0, 0, 1) * IF(LEFT(DET_CLAFIS,1) < 5, -1, 1) * (DET_TOTITE - DET_DESESP - DET_DESCFF) AS TOTVEN,');
        Add('  IF(LEFT(DET_CLAFIS,1) < 5, -1, 1) * (DET_TOTCOM) AS TOTCOM,');
        Add('  IF(LEFT(DET_CLAFIS,1) < 5, -1, 1) * ' + strCampoCusto + ' AS TOTCUS');
        Add('FROM');
        Add('  MOVDET D');
        Add('  LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = D.AUTOINCREM');
        Add('  LEFT JOIN MOVICD ON MOVICD.ICD_SEQGER = D.AUTOINCREM');
        Add('    AND IF(IFNULL(MOVICD.ICD_FCPPRO, "") = "", D.DET_VALRET = 0, MOVICD.ICD_FCPPRO = "S") ');
        Add('  JOIN CADOPE ON OPE_CODOPE = DET_CODVEN');
        Add('WHERE');
        If (Not ckbResumoVendedor.Checked) Then
          Add(' FALSE AND ');
        Add('  DET_TIP_FC = "C" AND ');
        Add( cnsFiltroFFDVTR );
        If (rdgEmpresa.ItemIndex = 0) Then
          Add('  D.DET_CODEMP = :CODEMP AND')
        Else
          Add('  MOVTRI.DET_EMPORI = :CODEMP AND');
        Add('  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN AND');
        Add('  DET_PROEMB <> "S" AND');
        Add('  DET_CODCLI NOT IN (' + VS_strCliFil + ') AND');
        Add('  ( LOCATE(DET_CLAFIS, :CLAFIS) > 0 '+ IfThen(blnEntBR, 'OR DET_ESPDOC = "BR"', '') +' )');

        strSQL := Text;
        strSQL := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL);

        Clear;
        Add('SELECT');
        Add('  VENREP,');
        Add('  CODOPE,');
        Add('  NOMOPE,');
        Add('  COUNT(DISTINCT SEQGER) AS TICKET, ');
        Add('  SUM(TOTVEN) AS TOTVEN,');
        Add('  SUM(TOTCUS) AS TOTCUS,');
        Add('  SUM(TOTCOM) AS TOTCOM');
        Add('FROM');
        Add('  ('+ strSQL +') TABAGP ');
        Add('GROUP BY CODOPE');

        strSQL := Text;

        Clear;
        Add('SELECT');
        Add('  TABFIN.*,');
        Add('  ROUND(IF(IFNULL(TICKET,0)=0,0,TOTVEN/TICKET),2) AS TICMED');
        Add('FROM');
        Add('  ('+ strSQL +') TABFIN ');
        Add('ORDER BY VENREP DESC, TOTVEN DESC');

        ParamByName('CODEMP').AsString := edtCodEmp.Text;
        ParamByName('DTAINI').AsDate := dtaIni;
        ParamByName('DTAFIN').AsDate := dtaFin;
        ParamByName('CLAFIS').AsString := VS_strClaVen + '_'+ VS_strClaDev;
        If fCfgSis('ENTBRF', varBoolean) Then
          ParamByName('CLAFIS').AsString := ParamByName('CLAFIS').AsString + '_' + CLAFIS_BR;

        Open;
      End;

      if cdsMeta.Active then
      begin
        cdsMeta.First;
        while not cdsMeta.Eof do
        begin
          pSetVar('MET_MES' + IfThen(cdsMeta.RecNo < 13, IntToStr(cdsMeta.RecNo), 'TOT'), cdsMeta.FieldByName('MESANO').AsString);
          pSetVar('MET_PRO' + IfThen(cdsMeta.RecNo < 13, IntToStr(cdsMeta.RecNo), 'TOT'), cdsMeta.FieldByName('LITPRO').AsFloat);
          pSetVar('MET_REA' + IfThen(cdsMeta.RecNo < 13, IntToStr(cdsMeta.RecNo), 'TOT'), cdsMeta.FieldByName('LITREA').AsFloat);
          cdsMeta.Next;
        end;
      end;

      frxReport.FindObject('ChildLitProRea').Visible := fCfgSis('ELPRDF', varBoolean);

      frxReport.PrintOptions.ShowDialog := fEmptyStr(frxReport.PrintOptions.Printer);

      If edtDestino.Text = 'V' Then
        pPreviewReport(Self.Name, Self.Caption, frxReport)
        
      Else If frxReport.PrepareReport Then
        pPrintReport(Self.Name, Self.Caption, strNomImp, frxReport);

      cdsMeta.EmptyDataSet;

    End;
  Finally
    pnlInfo.Caption := '';
    FreeAndNil(qryRel);
    FreeAndNil(qryResumoVendedor);
    FreeAndNil(qryMediaDoc);
  End;
end;

procedure TfrmRelEstatDemonsFat.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstatDemonsFat.edtCodVenExit(Sender: TObject);
begin
  inherited;
  rdgTipVen.Enabled := fEmptyStr(edtCodVen.Text);

  If Not rdgTipVen.Enabled Then
    rdgTipVen.ItemIndex := 0;
end;

procedure TfrmRelEstatDemonsFat.edtCodVenKeyPress(Sender: TObject; var Key: Char);
  Var
    arrVen : TConsultasArray;
begin
  inherited;

  If fPesqOperador(Self, edtCodVen, edtDesVen, Nil, Key, arrVen) Then
  Begin
    If fValidaCampos(edtCodVen, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstatDemonsFat.FormCreate(Sender: TObject);
begin
  inherited;
  cdsDiario.CreateDataSet;

  cdsMeta.CreateDataSet;
  cdsMeta.IndexFieldNames := 'INDEX';

  pCarregaComposicaoCusto(cbbComCus);  
end;

procedure TfrmRelEstatDemonsFat.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) And (ActiveControl Is TRadioButton) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmRelEstatDemonsFat.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(mskMesAno);

  mskMesAno.Text := FormatDateTime('mm/yyyy', VS_Date);
  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa;

  rdgTipCal.ItemIndex := IfThen(Pos(fCfgSis('MARMKP'), '1_5_') > 0, 0, 1);
end;

procedure TfrmRelEstatDemonsFat.pGetPrazoMedio(dtaIni, dtaFin: TDate; out fltPMVVista, fltPMCTotal, fltPMCPrazo, fltPMVTotal, fltPMVPrazo: Double);
  Var
    qryPM, qryCondPag: TUniQuery;
    strFil: String;

  function fGetPM(strClaVen, strFiltro: String): Double;
    Var
      fltMedia, fltParci, fltTotal: Double;
  Begin
    qryPM.Filtered := False;
    qryPM.Filter   := strFiltro;
    qryPM.Filtered := True;

    fltParci := 0;
    fltTotal := 0;

    qryPM.First;
    While Not qryPM.Eof Do
    Begin

      {****************************************************************}
      {* caso use condicao de pagamento (cadastro), verifica se       *}
      {* a condicao influencia no calculo do prazo medio (CND_INFANA) *}
      {* Obs: As condicoes de pagamento foram carregadas em uma query *}
      {* para uso do locate, oque e' mais indicado em processamentos  *}
      {* ao inves de ficar executando um select no banco toda hora... *}
      {*************************************************************JC*}
      If (fCfgSis('USACND', varBoolean)) And
         (Not fEmptyStr(qryPM.FieldByName('GER_CODCND').AsString)) And
         (qryCondPag.Locate('CND_CODIGO', qryPM.FieldByName('GER_CODCND').AsString, [])) And
         (qryCondPag.FieldByName('CND_INFANA').AsString = 'N')  Then
      Begin
        qryPM.Next;
        Continue;
      End;

      If Pos(qryPM.FieldByName('GER_CLAFIS').AsString, strClaVen) > 0 Then
      Begin
        fltMedia := IfThen(qryPM.FieldByName('AUX_PRZMED').AsFloat = 0,
                          fCalcMediaPagto(qryPM.FieldByName('GER_CONPAG').AsString),
                          qryPM.FieldByName('AUX_PRZMED').AsFloat);
        fltParci := fltParci + (fltMedia * qryPM.FieldByName('GER_VLRCON').AsFloat);
        fltTotal := fltTotal + qryPM.FieldByName('GER_VLRCON').AsFloat;
      End;

      qryPM.Next;
    End;

    If fFormataFloat(fltTotal, 2) = 0 Then
      Result := 0
    Else
      Result := fltParci / fltTotal;
  End;
begin
  qryPM := fCriaQuery;
  qryCondPag := fCriaQuery;

  Try                        
    If fCfgSis('USACND', varBoolean) Then
    Begin
      qryCondPag.SQL.Text := 'SELECT CND_CODIGO, CND_INFANA FROM CADCND';
      qryCondPag.Open;
    End;

    With qryPM, SQL Do
    Begin
      Add('SELECT ');
      Add('  GER_CODCLI,');
      Add('  GER_CODEMP,');
      Add('  GER_CLAFIS,');
      Add('  GER_CONPAG,');
      Add('  GER_CODCND,');
      Add('  GER_VLRCON,');
      Add('  GER_TIP_FC,');
      Add('  GER_ESPDOC,');
      Add('  AUX_PRZMED ');
      Add('FROM');
      Add('  MOVGER INNER JOIN AUXMOV ON MOVGER.AUTOINCREM = AUXMOV.AUX_SEQGER ');
      Add('WHERE');
      Add('  GER_DTAENT BETWEEN :DTAINI AND :DTAFIN AND');
      Add('  IF(GER_TIP_FC = "F", TRUE, GER_CODCLI NOT IN (' + VS_strCliFil + ')) AND ');
      Add('  GER_CODEMP = :CODEMP');
      ParamByName('DTAINI').AsDate := dtaIni;
      ParamByName('DTAFIN').AsDate := dtaFin;
      ParamByName('CODEMP').AsString := edtCodEmp.Text;
      Open;
    End;

    fltPMVVista := 0;
    {************************************
      Prazo médio de documentos a vista será sempre 0
    *************************************
    strFil := 'GER_TIP_FC =  '+ QuotedStr('C')  +' AND '+
              'GER_ESPDOC <> '+ QuotedStr('DV') +' AND '+
              'GER_ESPDOC <> '+ QuotedStr('TR') +' AND '+
              'CND_DESMGE > 0';
    fltPMVVista := fGetPM(VS_strClaVen, strFil);}

    strFil := 'GER_TIP_FC =  '+ QuotedStr('C')  +' AND '+
              'GER_ESPDOC <> '+ QuotedStr('DV') +' AND '+
              'GER_ESPDOC <> '+ QuotedStr('TR') +' AND '+
              'GER_CONPAG <> '+ QuotedStr('01000');
    fltPMVPrazo := fGetPM(VS_strClaVen, strFil);

    strFil := 'GER_TIP_FC =  '+ QuotedStr('F') +' AND '+
              'GER_CONPAG <> '+ QuotedStr('01000');
    fltPMCPrazo := fGetPM(VS_strClaCom, strFil);

    strFil := 'GER_TIP_FC =  '+ QuotedStr('C')  +' AND '+
              'GER_ESPDOC <> '+ QuotedStr('DV') +' AND '+
              'GER_ESPDOC <> '+ QuotedStr('TR');
    fltPMVTotal := fGetPM(VS_strClaVen, strFil);

    strFil := 'GER_TIP_FC =  '+ QuotedStr('F');
    fltPMCTotal := fGetPM(VS_strClaCom, strFil);

  Finally
    FreeAndNil(qryPM);
    FreeAndNil(qryCondPag);
  End;
end;

function TfrmRelEstatDemonsFat.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
  Var
    strMensagem: String;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If (Sender = mskMesAno) Then
    Begin
      If StrToDateDef('01/'+mskMesAno.Text, 0) = 0 Then
        strMensagem := 'Digite um Mês / Ano válido!';
    End
    Else If (Sender = edtCodEmp) Then
    Begin

      If Not fEmptyStr(edtCodEmp.Text) Then
      Begin
        edtDesEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);
        If fEmptyStr(edtDesEmp.Text) Then
          strMensagem := 'Esta Empresa não está cadastrada!'
        Else If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
          strMensagem := 'Usuário sem permissão de acesso a essa Empresa!';
      End
      Else
        strMensagem := 'O campo Empresa deve ser preenchido!';

    End
    Else If (Sender = edtCodVen) Then
    Begin

      If Not fEmptyStr(edtCodVen.Text) Then
      Begin
        edtDesVen.Text := fRetNomVendRep(edtCodVen.Text);
        If fEmptyStr(edtDesVen.Text) Then
          strMensagem := 'Este Vendedor não está cadastrado!';;
      End
      Else
        edtDesVen.Text := 'TODOS';

    End;
  End;

  If Not fEmptyStr(strMensagem) Then
  Begin
    fMensagem('', strMensagem, ['&O k']);
    Result := False;
  End;

  If Not Result Then
    pSetFocus(Sender);
End;

end.
