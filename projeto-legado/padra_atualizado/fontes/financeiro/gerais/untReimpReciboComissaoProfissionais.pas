unit untReimpReciboComissaoProfissionais;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, Grids, DBGridCitel, DBGrids, StdCtrls, Mask, MaskEditFocus,
  AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls, Uni, DB,
  frxClass, strUtils, frxDMPClass, UniClientDataSet, BitBtnLockedIncrem,
  frxExportCSVTestabilidade, EditFocus, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxCore, cxDateUtils, cxTextEdit, system.UITypes,
  cxMaskEdit, cxDropDownEdit, cxCalendar, QColorLabel, Datasnap.DBClient, DateUtils, untfuncoesGenerica;

type
  TfrmReimpReciboComissaoProfissionais = class(TfrmPaiSimples)
    pnlRegistros: TPanel;
    lblSelecione: TLabel;
    dbgDocumentos: TDBGridCitel;
    pnlFiltros: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    btnImprimir: TBitBtnLocked;
    Label4: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    btnConsultar: TBitBtnLocked;
    gpbDestino: TGroupBox;
    ColorLabel1: TColorLabel;
    edtDestino: TEditFocus;
    ColorLabel2: TColorLabel;
    Label1: TLabel;
    edtProfissional: TEditFocus;
    edtCodPro: TEditFocus;
    cdsRecibo: TUniClientDataSet;
    cdsReciboNOMREC: TStringField;
    cdsReciboVALREC: TFloatField;
    cdsReciboVALEXT: TStringField;
    cdsReciboHISREC: TStringField;
    cdsReciboDTAREC: TStringField;
    cdsReciboNOMASS: TStringField;
    cdsReciboNROVIA: TIntegerField;
    cdsReciboVALTOT: TFloatField;
    cdsReciboVALIMP: TFloatField;
    cdsReciboNOMLIB: TStringField;
    cdsReciboNROREC: TStringField;
    cdsReciboNUMPIS: TStringField;
    cdsReciboMARCA_: TStringField;
    cdsReciboHISREC_02: TStringField;
    cdsReciboMARDES: TStringField;
    cdsReciboHISREC_03: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnImprimirClick(Sender: TObject);
    procedure dbgDocumentosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure edtDestinoExit(Sender: TObject);
    procedure edtCodProKeyPress(Sender: TObject; var Key: Char);
    procedure dbgDocumentosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgDocumentosDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }

    FPais: TPais;
    qryRegistros: TUniQuery;
    dtsRegistros: TDataSource;
    qryConEmp : TUniQuery;
    VS_strTCoProInterna: String;
    strNomImp: String;
    strNomeFila : String;
    frxRecibo: TfrxReport;

    cdsGenRec: TUniClientDataSet;
    dtsGenRec: TDataSource;

    fltValTot: Double;
    fltTotGer: Double;
    FCdsComissaoAbatidas : TUniClientDataSet;
    FValorTotalComissao : Double;

    procedure pLimpaTela;

    function RetornaSQLFiltro: String;
    function fCarregaConsulta: Boolean;

    procedure pCarregaEmpresa;
    procedure pCarregaProfissional;
    procedure pImprimeRecibo;
    function fLoadReport: Boolean;
    procedure pMarcaDocumento(blnMarcar: Boolean);
    procedure pSelecionaDocumento;
    procedure ConfiguraImpressao;
    procedure pEnviaImpressao;
    procedure pImpressao_MODRPA_1;
    procedure pImpressao_MODRPA_Dif1;
    function pImprimeRecibo_MODRPA_1: Boolean;
    function pImprimeRecibo_MODRPA_Dif1: Boolean;
    procedure InsereRegistroBaixaComissao;
    procedure CriaTemporariaComissaoRecebida;


  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;

  public
    { Public declarations }
  end;

var
  frmReimpReciboComissaoProfissionais: TfrmReimpReciboComissaoProfissionais;
  strCodEmp : String;
  strTipImp: String;

function ValidarCampoDoRecibo(AImpress: TUniQuery; ACampo: String; AReciboValido: Boolean): Boolean;

implementation

uses untFuncoesSimples, untQckRcxCompTransf, untCfgRel, untPesqAux, untConsultas, untTypesSistema,
  untDigInformacoesRPA, untModuloCalculaComissaoProfissionais, untValorPorExtenso;

{$R *.dfm}

function TfrmReimpReciboComissaoProfissionais.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = mskDtaIni) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
        If (Sender = mskDtaFin) Then
          Sender := mskDtaIni;
      End
      Else
      If Not fValidaDataStr(mskDtaIni.Text) Then
      Begin
        fMensagem('', 'O campo Data Inicial é inválido!', ['&O k']);
        Result := False;
        If (Sender = mskDtaFin) Then
          Sender := mskDtaIni;
      End

    End
    Else
    If (Sender = mskDtaFin) Then
    Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        If Not fValidaDataStr(mskDtaFin.Text) Then
        Begin
          fMensagem('', 'O campo Data Final é inválido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
          Begin
            fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
            Result := False;
          End;
        End;
    End
    Else If (Sender = edtCodEmp) Then
    Begin

    {*****************************************}
    {* VALIDA O CÓDIGO DA EMPRESA            *}
    {**************************************MV*}
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        edtNomEmp.Text := 'TODAS';
      End
      Else
      Begin
        If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('', 'Usuário sem permissão de acesso a essa Empresa!', ['&Ok']);
          Result := False;
        End;
        pCarregaEmpresa;
        If qryConEmp.FieldByName('EMP_CODEMP').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&O k']);
          Result := False;
        End;
      End;

    End
    Else If (Sender = edtCodPro) Then
    Begin

        If fEmptyStr(edtCodPro.Text) Then
        Begin
          fMensagem('', 'Profissional precisa ser preenchido!', ['&Ok']);
          Result := False;
        End

        Else
        Begin

          pCarregaProfissional;

          If fEmptyStr(edtProfissional.Text) Then
          Begin
            fMensagem('','Profissional não encontrado!',['&OK']);
            Result := False;
          End

        End;

    End
    else if (Sender = edtDestino) then
    begin
      if fEmptyStr(edtDestino.Text) then
      begin
        fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser preenchido!', ['&Ok']);
        pSetFocus(edtDestino);
        Abort; // porque senão pula para outro campo, por não ser untPaiRelatorio por herança
      end
      else If Pos(edtDestino.Text, 'VI') <= 0 then
      begin
        fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser V ou I!', ['&Ok']);
        pSetFocus(edtDestino);
        Abort; // porque senão pula para outro campo, por não ser untPaiRelatorio por herança
      end;
    end;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmReimpReciboComissaoProfissionais.InsereRegistroBaixaComissao;
var
  LQryComissoes : TUniQuery;
  LSQL : String;
begin
  FValorTotalComissao := 0.0;

  LSQL := EmptyStr;
  LSQL := LSQL + '  SELECT ' ;
  LSQL := LSQL + '    REC.CTR_NUMDUP, ' ;
  LSQL := LSQL + '    REC.CTR_ESPDOC, ' ;
  LSQL := LSQL + '    REC.CTR_CODCLI, ' ;
  LSQL := LSQL + '    COM.COM_SEQCTR, ' ;
  LSQL := LSQL + '    COM.COM_VALCTR AS CTR_VALORI, ' ;
  LSQL := LSQL + '    COM.COM_VALCOM AS CTR_VALREC ' ;
  LSQL := LSQL + '  FROM ACECOM_LOG COM ' ;
  LSQL := LSQL + '  INNER JOIN CADREC REC ON REC.CTR_CODEMP = COM.COM_EMPBAI ' ;
  LSQL := LSQL + '                AND REC.CTR_SEQCON = COM.COM_SEQCTR ' ;
  LSQL := LSQL + ' WHERE COM.COM_CODDIV = :CODPRO ' ;
  LSQL := LSQL + '   AND COM.COM_SEQCTR > 0 ' ;

  If Not fEmptyStr(edtCodEmp.Text) Then
    LSQL := LSQL + '  AND COM.COM_EMPBAI = :CODEMP ' ;

  If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And
     (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then

    LSQL := LSQL + '  AND COM.COM_DTABAI BETWEEN :DTAINI AND :DTAFIN ' ;

  LQryComissoes := fCriaQuery(nil);
  try
    LQryComissoes.Close;
    LQryComissoes.SQL.Text := LSQL;

    LQryComissoes.ParamByName('CODPRO').AsString := edtCodPro.Text;

    If Not fEmptyStr(edtCodEmp.Text) Then
      LQryComissoes.ParamByName('CODEMP').AsString := edtCodEmp.Text;

    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And
       (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
    Begin
      LQryComissoes.ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
      LQryComissoes.ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
    End;

    LQryComissoes.Open;

    LQryComissoes.First;
    while not LQryComissoes.Eof do
    begin

      FCdsComissaoAbatidas.Append;
      FCdsComissaoAbatidas.FieldByName('DUPLICATA').AsString := LQryComissoes.FieldByName('CTR_NUMDUP').AsString;
      FCdsComissaoAbatidas.FieldByName('ESPECIE').AsString   := LQryComissoes.FieldByName('CTR_ESPDOC').AsString;
      FCdsComissaoAbatidas.FieldByName('CLIENTE').AsString   := LQryComissoes.FieldByName('CTR_CODCLI').AsString;
      FCdsComissaoAbatidas.FieldByName('VALOR_ORIGINAL').AsFloat := fFormataFloat(LQryComissoes.FieldByName('CTR_VALORI').AsFloat, 2);
      FCdsComissaoAbatidas.FieldByName('VALOR_ABATIDO').AsFloat  := fFormataFloat(LQryComissoes.FieldByName('CTR_VALREC').AsFloat, 2);
      FCdsComissaoAbatidas.Post;

      FValorTotalComissao := FValorTotalComissao + fFormataFloat(LQryComissoes.FieldByName('CTR_VALREC').AsFloat, 2);
      LQryComissoes.Next;
    end;
  finally
    FreeAndNil(LQryComissoes);
  end;
end;

procedure TfrmReimpReciboComissaoProfissionais.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  edtNomEmp.Text := qryConEmp.FieldByName('EMP_NOMEMP').AsString;
end;

procedure TfrmReimpReciboComissaoProfissionais.pLimpaTela;
begin
  qryRegistros.Close;
  pCarregaEmpresa;
  pSetFocus(mskDtaIni);
end;

function TfrmReimpReciboComissaoProfissionais.RetornaSQLFiltro: String;
  Var
      strSQL : string;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT           ';
  strSQL := strSQL + '  "D" AS MARDES, ';
  strSQL := strSQL + '  COM_CODEMP,    ';
  strSQL := strSQL + '  CONCAT(COM_NUMDOC, "-", COM_ESPDOC, "-", COM_CODEMP) AS COM_NUMDOC,';
  {************************************************************}
  {*** O VR COM SOMANDO, MESMO QUANDO ERA DO TIPO DE DEBITO ***}
  {** REQ.29919 ********************************************BB*}
  strSQL := strSQL + '  IF(COM_CREDEB = "D", (COM_VRCOMI *(-1)), COM_VRCOMI) AS COM_VRCOMI,';
  strSQL := strSQL + '  COM_DTABAI, ';
  strSQL := strSQL + '  COM_DTACAD, ';
  strSQL := strSQL + '  COM_OBSERV, ';
  strSQL := strSQL + '  COM_VRVEND, ';
  strSQL := strSQL + '  DIV_NOMDIV, ';
  strSQL := strSQL + '  DIV_NUMPIS, ';
  strSQL := strSQL + '  CLI_NOMCLI  ';
  strSQL := strSQL + 'FROM          ';
  strSQL := strSQL + '  COMPRO B    ';
  strSQL := strSQL + '  JOIN CADDIV P ON P.DIV_CODDIV = B.COM_CODPRO ';
  strSQL := strSQL + '  LEFT JOIN CADCLI C ON C.CLI_CODCLI = B.COM_CODCLI ';
  strSQL := strSQL + 'WHERE         ';
  strSQL := strSQL + '  COM_CODPRO = :CODPRO ';

  If Not fEmptyStr(edtCodEmp.Text) Then
     strSQL := strSQL + ' AND COM_CODEMP = :CODEMP ';

  If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And
     (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
    strSQL := strSQL + ' AND COM_DTABAI BETWEEN :DTAINI AND :DTAFIN ';

  Result := strSQL;

end;

function TfrmReimpReciboComissaoProfissionais.fCarregaConsulta: Boolean;
begin

  strCodEmp := edtCodEmp.Text;
  If fEmptyStr(edtCodEmp.Text) Then
  begin
    strCodEmp := VS_strCodEmp;
  end;

  qryRegistros.Close;
  qryRegistros.SQL.Text := RetornaSQLFiltro;

  qryRegistros.ParamByName('CODPRO').AsString := edtCodPro.Text;

  If Not fEmptyStr(edtCodEmp.Text) Then
     qryRegistros.ParamByName('CODEMP').AsString := edtCodEmp.Text;

  If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And
     (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
  Begin
    qryRegistros.ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
    qryRegistros.ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
  End;

  qryRegistros.Open;

  cdsGenRec := fCriaClientDatset(qryRegistros);
  dtsGenRec.DataSet := cdsGenRec;
  dbgDocumentos.DataSource := dtsGenRec;

  Result := Not qryRegistros.IsEmpty;

  If Not Result Then
  Begin
     fMensagem('', 'Nenhuma recibo foi encontrado!', ['&OK']);
     cdsGenRec.EmptyDataSet;
  End
  Else
  Begin
     cdsGenRec.First;
     (cdsGenRec.FieldByName('COM_VRCOMI') As TFloatField).DisplayFormat := '#,##0.00';
  End;
end;

Function TfrmReimpReciboComissaoProfissionais.pImprimeRecibo_MODRPA_1(): Boolean;
Begin
      Result := False;

      cdsGenRec.first;

      If (fCfgSis('MODRPA') = '1') Then
      Begin
        While Not cdsGenRec.Eof Do
        Begin
          if (cdsGenRec.FieldByName('MARDES').AsString = 'M') then
          begin
            cdsRecibo.Append;
            cdsReciboNOMREC.AsString  := fRetNomeEmpresaSelec(cdsGenRec.FieldByName('COM_CODEMP').AsString);
            If VS_strTCoProInterna <> '3' Then
            Begin
              cdsReciboVALREC.AsFloat   := fStrToFloat(FloatToStrF(IIF(fCfgSis('PESGSO', varDouble) > 0,
                                           cdsGenRec.FieldByName('COM_VRCOMI').AsFloat - (fCfgSis('PESGSO', varDouble) * cdsGenRec.FieldByName('COM_VRCOMI').AsFloat / 100),
                                           cdsGenRec.FieldByName('COM_VRCOMI').AsFloat),ffFixed, 12, 2));

              cdsReciboVALEXT.AsString  := UpperCase(fRetExtensoNumero(cdsReciboVALREC.AsString));
              cdsReciboHISREC.AsString  := 'COMISSAO REF. FATURAMENTO ' + cdsGenRec.FieldByName('COM_NUMDOC').AsString + '  ' + cdsGenRec.FieldByName('COM_DTACAD').AsString + ' - ' + 'R$ ' + FormatFloat('#,##0.00', cdsReciboVALREC.AsFloat) + IIF(cdsGenRec.FieldByName('CLI_NOMCLI').IsNull, '', ' DE ' + cdsGenRec.FieldByName('CLI_NOMCLI').AsString) +
                                           IIF(fCfgSis('PESGSO', varDouble) > 0, ' DEDUZIDO ' + FormatFloat(',0.00%', fCfgSis('PESGSO', varDouble)) + ' A TITULO DE SEGURIDADE SOCIAL.', '');
              cdsReciboHISREC_02.AsString  := 'COMISSAO REF. FATURAMENTO ' + cdsGenRec.FieldByName('COM_NUMDOC').AsString + '  ' + cdsGenRec.FieldByName('COM_DTACAD').AsString + ' - ' + 'R$ ' + FormatFloat('#,##0.00', cdsReciboVALREC.AsFloat) + IIF(cdsGenRec.FieldByName('CLI_NOMCLI').IsNull, '', ' DE ' + cdsGenRec.FieldByName('CLI_NOMCLI').AsString);
            End
            Else
            Begin
              cdsReciboVALREC.AsFloat   := fFormataFloat(cdsGenRec.FieldByName('COM_VRCOMI').AsFloat, 2);
              cdsReciboVALEXT.AsString  := '';
              cdsReciboHISREC.AsString  := 'COMISSAO REF. FATURAMENTO ' + cdsGenRec.FieldByName('COM_NUMDOC').AsString + '  ' + cdsGenRec.FieldByName('COM_DTACAD').AsString + ' - ' + FormatFloat('#,##0.00', cdsReciboVALREC.AsFloat) + IIF(cdsGenRec.FieldByName('CLI_NOMCLI').IsNull, '', ' DE ' + cdsGenRec.FieldByName('CLI_NOMCLI').AsString);
            End;
            cdsReciboHISREC_03.AsString := 'COMISSAO ' + cdsGenRec.FieldByName('COM_OBSERV').AsString + ' '  + cdsGenRec.FieldByName('COM_NUMDOC').AsString + '  ' + cdsGenRec.FieldByName('COM_DTACAD').AsString + ' - ' + 'R$ ' + FormatFloat('#,##0.00', cdsGenRec.FieldByName('COM_VRVEND').AsFloat) + ' - ' +
            'R$ ' + FormatFloat('#,##0.00', cdsReciboVALREC.AsFloat) + IIF(cdsGenRec.FieldByName('CLI_NOMCLI').IsNull, '', ' DE ' + cdsGenRec.FieldByName('CLI_NOMCLI').AsString);
            cdsReciboDTAREC.AsString  := fRetDataExtenso(cdsGenRec.FieldByName('COM_DTABAI').AsDateTime, True);
            cdsReciboNOMASS.AsString  := cdsGenRec.FieldByName('DIV_NOMDIV').AsString;
            cdsReciboNROVIA.AsInteger := 1;
            cdsReciboMARCA_.AsString  := '-';
            fltValTot := fStrToFloat(FloatToStrF(fltValTot + cdsReciboVALREC.AsFloat, ffFixed, 12,2));
            cdsRecibo.Post;
          end;
          cdsGenRec.Next;
        End;

        InsereRegistroBaixaComissao;

        Result := True;
      End

End;

Function TfrmReimpReciboComissaoProfissionais.pImprimeRecibo_MODRPA_Dif1() : Boolean;
Begin
    Result := False;

    pCriarFormularios(TfrmDigInformacoesRPA, frmDigInformacoesRPA);
    If frmDigInformacoesRPA.ShowModal = mrOK Then
    Begin

      cdsRecibo.Append;
      cdsReciboNROREC.AsString  := fRetSequencial('SEQRPA') + '/' + Copy(IntToStr(YearOf(Date)), 3, 2);
      cdsReciboNOMREC.AsString  := fRetNomeEmpresaSelec(cdsGenRec.FieldByName('COM_CODEMP').AsString);
      cdsReciboHISREC.AsString  := frmDigInformacoesRPA.mmoHisRec.Lines.Text;
      cdsReciboDTAREC.AsString  := fRetDataExtenso(cdsGenRec.FieldByName('COM_DTABAI').AsDateTime, True);
      cdsReciboNOMASS.AsString  := cdsGenRec.FieldByName('DIV_NOMDIV').AsString;
      cdsReciboNROVIA.AsInteger := 1;
      cdsReciboNOMLIB.AsString  := frmDigInformacoesRPA.edtNomOpe.Text;

      If VS_strTCoProInterna <> '3' Then
        cdsReciboNUMPIS.AsString  := cdsGenRec.FieldByName('DIV_NUMPIS').AsString
      Else
        cdsReciboNUMPIS.AsString  := '';

      cdsRecibo.Post;

      cdsRecibo.First;
      fltTotGer := 0;
      While Not cdsGenRec.Eof Do
      Begin

        if (cdsGenRec.FieldByName('MARDES').AsString = 'M') then
        begin
          cdsRecibo.Edit;
          cdsReciboVALTOT.AsFloat  := cdsReciboVALTOT.AsFloat + fFormataFloat(cdsGenRec.FieldByName('COM_VRCOMI').AsFloat, 2);

          fltTotGer := fltTotGer + cdsGenRec.FieldByName('COM_VRCOMI').AsFloat;

          cdsRecibo.Post;
        end;

        cdsGenRec.Next;

      End;
      {**********************************}
      {* ALTERADA A ROTINA POIS HOUVE   *}
      {* DIFERENÇA DE R$ 0,03 NO VALOR  *}
      {* DO IMPOSTO VISTO NA FIGUEIREDO *}
      {*******************************JU*}
      cdsRecibo.Edit;
      If VS_strTCoProInterna <> '3' Then
      Begin
        cdsReciboVALIMP.AsFloat := fFormataFloat(IIF(fCfgSis('PESGSO', varDouble) > 0, fltTotGer * (fCfgSis('PESGSO', varDouble) / 100), 0), 2);
        cdsReciboVALREC.AsFloat := cdsReciboVALTOT.AsFloat - cdsReciboVALIMP.AsFloat;
        cdsReciboVALEXT.AsString := UpperCase(fRetExtensoNumero(cdsReciboVALREC.AsString));
      End
      Else
      Begin
        cdsReciboVALIMP.AsFloat := fFormataFloat(0, 2);
        cdsReciboVALREC.AsFloat := cdsReciboVALTOT.AsFloat - cdsReciboVALIMP.AsFloat;
        cdsReciboVALEXT.AsString := '';
      End;
      cdsRecibo.Post;

      Result := True;
    End;

End;

procedure TfrmReimpReciboComissaoProfissionais.pImpressao_MODRPA_1();
Begin

      cdsRecibo.First;

      pCriarFormularios(TfrmModuloCalculaComissaoProfissionais,frmModuloCalculaComissaoProfissionais);
      frmModuloCalculaComissaoProfissionais.frxRelatorio.DataSet := cdsRecibo;
      frmModuloCalculaComissaoProfissionais.frxReportsBaixas.DataSet := FCdsComissaoAbatidas;

      If Not Assigned(frxRecibo) Then
         frxRecibo := TfrxReport.Create(Self);

      If Not fLoadReport Then
      Begin
        If (strTipImp = 'M') Then
          frxRecibo := frmModuloCalculaComissaoProfissionais.frxReciboM
        Else
          frxRecibo := frmModuloCalculaComissaoProfissionais.frxReciboJ;
      End;

      frxRecibo.Script.Variables['VALREC'] := FormatFloat('#,##0.00', fltValTot);
      frxRecibo.Script.Variables['ValorTotalComissao'] := FormatFloat('#,##0.00', FValorTotalComissao);
      If VS_strTCoProInterna <> '3' Then
      Begin
        frxRecibo.Script.Variables['VALEXT'] := UpperCase(fRetExtensoNumero(FormatFloat('#,##0.00', fltValTot)));
        frxRecibo.Script.Variables['MOEDA']  := 'R$';
        frxRecibo.Script.Variables['PONTO']  := '';
        frxRecibo.Script.Variables['(']      := '(';
        frxRecibo.Script.Variables[')']      := ')';
        frxRecibo.Script.Variables['ValorTotalComissaoExtenso'] := UpperCase(fRetExtensoNumero(FormatFloat('#,##0.00', FValorTotalComissao)));
      End
      Else
      Begin
        frxRecibo.Script.Variables['VALEXT'] := '';
        frxRecibo.Script.Variables['MOEDA']  := '';
        frxRecibo.Script.Variables['PONTO']  := 'Ptos.';
        frxRecibo.Script.Variables['(']      := '';
        frxRecibo.Script.Variables[')']      := '';
        frxRecibo.Script.Variables['ValorTotalComissaoExtenso'] := '';
      End;

End;

procedure TfrmReimpReciboComissaoProfissionais.pImpressao_MODRPA_Dif1();
Begin

   cdsRecibo.First;

   pCriarFormularios(TfrmModuloCalculaComissaoProfissionais,frmModuloCalculaComissaoProfissionais);
   frmModuloCalculaComissaoProfissionais.frxRelatorio.DataSet := cdsRecibo;

   If Not Assigned(frxRecibo) Then
      frxRecibo := TfrxReport.Create(Self);

   If Not fLoadReport Then
   Begin
     If (strTipImp = 'M') Then
       frxRecibo := frmModuloCalculaComissaoProfissionais.frxRPAM
     Else
       frxRecibo := frmModuloCalculaComissaoProfissionais.frxRPAJ;
   End;

End;

procedure TfrmReimpReciboComissaoProfissionais.pEnviaImpressao();
Begin

    frxRecibo.Script.Variables['NOMEMP'] := fRetNomeEmpresa;
    frxRecibo.Script.Variables['ENDEMP'] := fCampoTabela('EMP_ENDERE', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp]) + ', '  +
                                            fCampoTabela('EMP_ENDNUM', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp]) + ' - ' +
                                            fCampoTabela('EMP_BAIRRO', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp]) + ' - ' +
                                            fRetNomCidade(fCampoTabela('EMP_CODCID', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp], False), 0) + '/' +
                                            fRetNomCidade(fCampoTabela('EMP_CODCID', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp], False), 1);
    frxRecibo.Script.Variables['CGCEMP'] := fFormataCpfCgc(fCampoTabela('EMP_C_G_C_', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp]), FPais);
    frxRecibo.Script.Variables['IESEMP'] := fCampoTabela('EMP_I_E_S_', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp]);

    frxRecibo.Script.Variables['DTAINI'] := mskDtaIni.Text;
    frxRecibo.Script.Variables['DTAFIN'] := mskDtaFin.Text;

    frxRecibo.Script.Variables['CIDEMP'] := fRetNomCidade(fCampoTabela('EMP_CODCID', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp], False), 0) + '/' +
                                            fRetNomCidade(fCampoTabela('EMP_CODCID', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp], False), 1);
    frxRecibo.Script.Variables['OPELIB'] := fRetNomeOperador(strLoginUsuarioLogado);

    If VS_strTCoProInterna <> '3' Then
    Begin
      frxRecibo.Script.Variables['PERIMP'] := fCfgSis('PESGSO');
      frxRecibo.Script.Variables['INSINSS']:= 'Nº INSCRIÇÃO NO INSS';
      frxRecibo.Script.Variables['RETINSS']:= 'RETENÇÃO DE INSS';
      frxRecibo.Script.Variables['MOEDA']  := 'R$';
      frxRecibo.Script.Variables['PONTO']  := '';
      frxRecibo.Script.Variables['(']      := '(';
      frxRecibo.Script.Variables[')']      := ')';
      frxRecibo.Script.Variables['%']      := '%';

      If strTipImp = 'M' Then
      Begin
        frxRecibo.Script.Variables['..']   := '..';
        frxRecibo.Script.Variables['-']    := '-';
      End;

    End
    Else
    Begin
      frxRecibo.Script.Variables['PERIMP'] := '';
      frxRecibo.Script.Variables['INSINSS']:= '';
      frxRecibo.Script.Variables['RETINSS']:= '';
      frxRecibo.Script.Variables['MOEDA']  := '';
      frxRecibo.Script.Variables['PONTO']  := 'Ptos.';
      frxRecibo.Script.Variables['(']      := '';
      frxRecibo.Script.Variables[')']      := '';
      frxRecibo.Script.Variables['%']      := '';

      If strTipImp = 'M' Then
      Begin
        frxRecibo.Script.Variables['..']   := '';
        frxRecibo.Script.Variables['-']    := '';
      End;
    End;

    frxRecibo.PrintOptions.ShowDialog := fEmptyStr(strNomeFila);
    if Not fEmptyStr(strNomeFila) then
       frxRecibo.PrintOptions.Printer := AnsiReplaceText(strNomeFila, '\\' + fRetNomeRede + '\', '');

    frxRecibo.PrepareReport;
    if (edtDestino.Text = 'V') then
      pPreviewReport(Self.Name, Self.Caption, frxRecibo)
    Else
      pPrintReport(Self.Name, Self.Caption, strNomeFila, frxRecibo);

    If Assigned(frxRecibo) Then
       pFreeAndNil(frxRecibo);

    If Assigned(frmModuloCalculaComissaoProfissionais) Then
       pFreeAndNil(frmModuloCalculaComissaoProfissionais);

End;

procedure TfrmReimpReciboComissaoProfissionais.ConfiguraImpressao();
Begin
  pCarregaConfImpr(qryCfgRel, 'frmReimpReciboComissaoProfissionais');
  fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False);
  strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
  strTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
End;

procedure TfrmReimpReciboComissaoProfissionais.CriaTemporariaComissaoRecebida;
begin
  if Assigned(FCdsComissaoAbatidas) then
    FreeAndNil(FCdsComissaoAbatidas);

  FCdsComissaoAbatidas := TUniClientDataSet.Create(Owner);
  FCdsComissaoAbatidas.AggregatesActive := True;

  With FCdsComissaoAbatidas.FieldDefs.AddFieldDef do
  begin
    Name := 'DUPLICATA';
    DataType := ftString;
    Size := 012;
  end;

  With FCdsComissaoAbatidas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ESPECIE';
    DataType := ftString;
    Size := 006;
    Required := False;
  End;

  With FCdsComissaoAbatidas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CLIENTE';
    DataType := ftString;
    Size := 012;
    Required := False;
  End;

  With FCdsComissaoAbatidas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALOR_ORIGINAL';
    DataType := ftFloat;
    Required := False;
  End;

  With FCdsComissaoAbatidas.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALOR_ABATIDO';
    DataType := ftFloat;
    Required := False;
  End;

  if Not FCdsComissaoAbatidas.Active then
    FCdsComissaoAbatidas.CreateDataSet;

  FCdsComissaoAbatidas.EmptyDataSet;

end;

procedure TfrmReimpReciboComissaoProfissionais.pImprimeRecibo();
begin

  Try

    if Not cdsRecibo.Active then
       cdsRecibo.CreateDataSet;

    cdsRecibo.EmptyDataSet;

    CriaTemporariaComissaoRecebida;

    fltValTot := 0;

    If pImprimeRecibo_MODRPA_1() Then
    Begin
       ConfiguraImpressao();
       pImpressao_MODRPA_1();
       pEnviaImpressao();
    End
    Else
    if pImprimeRecibo_MODRPA_Dif1() then
    Begin
       ConfiguraImpressao();
       pImpressao_MODRPA_Dif1();
       pEnviaImpressao();
    End;

    pnlInfo.Caption := '';
    pnlInfo.Repaint;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;

end;

function ValidarCampoDoRecibo(AImpress: TUniQuery; ACampo: String; AReciboValido: Boolean): Boolean;
Begin
  If Not AReciboValido Then
    Exit(False);

  If AImpress.FieldByName(ACampo).AsFloat = 0.00 Then
    Exit(True);

  Result := Pos(FormatFloat('0.00', AImpress.FieldByName(ACampo).AsFloat),
                AImpress.FieldByName('RTF_RECIBO').AsString) > 0;
End;

procedure TfrmReimpReciboComissaoProfissionais.FormCreate(Sender: TObject);
begin
  inherited;
  VS_strTCoProInterna := fCfgSis('TCOPRO');
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryRegistros := fCriaQuery(Self);
  dtsRegistros := TDataSource.Create(Self);
  dtsRegistros.DataSet := qryRegistros;

  dtsGenRec := TDataSource.Create(Self);
  pCarregaEmpresa;
end;

procedure TfrmReimpReciboComissaoProfissionais.FormDestroy(Sender: TObject);
begin
  if Assigned(FCdsComissaoAbatidas) then
    FreeAndNil(FCdsComissaoAbatidas);

  inherited;
end;

procedure TfrmReimpReciboComissaoProfissionais.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
     If ((ActiveControl) = dbgDocumentos) Then
         pLimpaTela;
end;

procedure TfrmReimpReciboComissaoProfissionais.btnConsultarClick(Sender: TObject);
begin
  inherited;
  if not fValidaCampos(mskDtaIni, false) then
    exit;
  if not fValidaCampos(mskDtaFin, false) then
    exit;
  if fVerificaCampos then
  begin
    fCarregaConsulta;
    if not qryRegistros.IsEmpty then
      pSetFocus(dbgDocumentos);
  end;
end;

procedure TfrmReimpReciboComissaoProfissionais.btnImprimirClick(Sender: TObject);
 Var
     blntemReg : Boolean;
begin
  inherited;

  blntemReg := true;
  cdsGenRec.disablecontrols;
  cdsGenRec.Filter := ' MARDES = ''M'' ';
  cdsGenRec.Filtered := True;

  if (not cdsGenRec.Active) then
  begin
    fMensagem('', 'É necessário selecionar ao menos um registro!', ['&OK']);
    blntemReg := False;
  end;

  if (cdsGenRec.IsEmpty) then
  begin
    fMensagem('', 'É necessário selecionar ao menos um registro!', ['&OK']);
    blntemReg := False;
  end;

  cdsGenRec.Filtered := False;
  cdsGenRec.enablecontrols;

  If (blntemReg) Then
  Begin
     If (fMensagem('', 'Confirma ' + IIF(edtDestino.Text = 'I', 'Impressão', 'Visualização') + '?', ['','']) = 1) Then
         pImprimeRecibo();
  End;

end;

procedure TfrmReimpReciboComissaoProfissionais.dbgDocumentosDblClick(
  Sender: TObject);
begin
  inherited;
  pSelecionaDocumento();
end;

procedure TfrmReimpReciboComissaoProfissionais.dbgDocumentosDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

    {*****************************************}
    {* CASO A TABELA ESTEJA FECHADA, SAI     *}
    {**************************************MV*}
    If Not cdsGenRec.Active Then
      Exit;

    If (cdsGenRec.FindField('MARDES') = Nil) Then
      Exit;

    If cdsGenRec.FieldByName('MARDES').AsString = 'M' Then
    Begin
      dbgDocumentos.Canvas.Font.Color := clBlue;

      If dbgDocumentos.Canvas.Brush.Color = clHighLight Then
         dbgDocumentos.Canvas.Font.Color := clLime//;clHighlightText;
    End;


  dbgDocumentos.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmReimpReciboComissaoProfissionais.dbgDocumentosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Return Then
     pSelecionaDocumento(); //btnImprimir.Click;
end;

procedure TfrmReimpReciboComissaoProfissionais.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtCodEmp, true);
end;

procedure TfrmReimpReciboComissaoProfissionais.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, true) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmReimpReciboComissaoProfissionais.edtCodProKeyPress(Sender: TObject; var Key: Char);
 Var
     arrDiversos : TConsultasArray;
begin
  inherited;
  {*****************************}
  {* NOVA CONSULTA DE DIVERSOS *}
  {**************************DP*}
  If fPesqDiversos(Self, edtCodPro, edtProfissional, Nil, Key, arrDiversos) Then
  Begin
    If fValidaCampos(edtCodPro, True) Then
      SelectNext((ActiveControl), True, True);
  End;
end;

procedure TfrmReimpReciboComissaoProfissionais.edtDestinoExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtDestino, true);
end;

function TfrmReimpReciboComissaoProfissionais.fLoadReport: Boolean;
 Var
   mmsLoad: TStream;
   FLayImp: TUniQuery;
Begin
  Result := False;
  FLayImp:= fCriaQuery(nil);
  Try
      FLayImp.Close;
      FLayImp.Sql.Clear;
      FLayImp.Sql.Add('SELECT * FROM ');
      FLayImp.Sql.Add('  LAYIMP');
      FLayImp.Sql.Add('WHERE');
      FLayImp.Sql.Add('  LAY_TIPLAY = :TIPLAY AND  ');
      FLayImp.Sql.Add('  LAY_CODEMP = :CODEMP AND  ');
      FLayImp.Sql.Add('  LAY_CODLAY = :CODLAY      ');

      FLayImp.ParamByName('CODEMP').AsString := VS_strCodEmp;
      FLayImp.ParamByName('CODLAY').AsString := 'MDRPA'+IntToStr(fCfgSis('MODRPA', varInteger));

      If(strTipImp = 'M') Then
         FLayImp.ParamByName('TIPLAY').AsString := 'M'
      Else
         FLayImp.ParamByName('TIPLAY').AsString := 'L';

      FLayImp.Sql.Add('ORDER BY');
      FLayImp.Sql.Add('  LAY_DTAALT DESC,');
      FLayImp.Sql.Add('  LAY_HORALT DESC ');
      FLayImp.Sql.Add('LIMIT 1');
      FLayImp.Open;

      If Not FLayImp.IsEmpty Then
      Begin
        Result := True;
        mmsLoad := FLayImp.CreateBlobStream(FLayImp.FieldByName('LAY_RELFR3'), bmRead);
        frxRecibo.LoadFromStream(mmsLoad);
        frxRecibo.Variables.Clear;
      End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fLoadReport]');
    End;
  End;
  pFreeAndNil(mmsLoad);
  pFreeAndNil(FLayImp);
End;

procedure TfrmReimpReciboComissaoProfissionais.pCarregaProfissional;
Begin
  edtProfissional.Text := fRetNomProfissional(edtCodPro.Text);
End;

procedure TfrmReimpReciboComissaoProfissionais.pSelecionaDocumento;
  Var
    intRecNo: Integer;
begin

  intRecNo := cdsGenRec.RecNo;

  If cdsGenRec.FieldByName('MARDES').AsString <> 'M' Then
    pMarcaDocumento(True)
  Else
    pMarcaDocumento(False);

  cdsGenRec.RecNo := intRecNo;

end;

procedure TfrmReimpReciboComissaoProfissionais.pMarcaDocumento(blnMarcar: Boolean);
begin

    If (Not cdsGenRec.Active) Then
        Exit;

    If (cdsGenRec.RecordCount <= 0) Then
        Exit;

    cdsGenRec.Edit;

    If blnMarcar Then
       cdsGenRec.FieldByName('MARDES').AsString := 'M'
    Else
       cdsGenRec.FieldByName('MARDES').AsString := 'D';

    cdsGenRec.Post;

end;

end.
