unit untRcxReimpTransfer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, Grids, DBGridCitel, DBGrids, StdCtrls, Mask, MaskEditFocus,
  AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls, Uni, DB,
  frxClass, strUtils, frxDMPClass, UniClientDataSet, BitBtnLockedIncrem,
  frxExportCSVTestabilidade, EditFocus, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxCore, cxDateUtils, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, QColorLabel;

type
  TModalidadeTF = (mtfDinheiro,
                   mtfCartao,
                   mtfOrdemPagamento,
                   mtfPix,
                   mtfChequePre,
                   mtfChequeAvista,
                   mtfFinanciamento,
                   mtfOrdemPagamentoAutomatica);

type
  TfrmRcxReimpTransfer = class(TfrmPaiSimples)
    pnlRegistros: TPanel;
    lblSelecione: TLabel;
    dbgDocumentos: TDBGridCitel;
    pnlFiltros: TPanel;
    Label5: TLabel;
    lblDesDtaFin: TLabel;
    Label6: TLabel;
    btnImprimir: TBitBtnLocked;
    Label4: TLabel;
    shpEmp: TShape;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    btnConsultar: TBitBtnLocked;
    gpbDestino: TGroupBox;
    ColorLabel1: TColorLabel;
    edtDestino: TEditFocus;
    ColorLabel2: TColorLabel;
    rdgOrdenacao: TRadioGroup;
    Label1: TLabel;
    edtSequencialTransf: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnImprimirClick(Sender: TObject);
    procedure dbgDocumentosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure edtDestinoExit(Sender: TObject);
    procedure edtSequencialTransfExit(Sender: TObject);
  private
    { Private declarations }

    qryRegistros: TUniQuery;
    dtsRegistros: TDataSource;
    qryConEmp : TUniQuery;
    blnLiberado : Boolean;
    procedure pLimpaTela;

    function fCarregaTransferencias: Boolean;

    function RetornaSQLTransferenciasAgrupadas: String;

    procedure pCarregaEmpresa;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;

  public
    { Public declarations }

    class procedure LerMovBanBanTrf(Var AValorMovBan: Double;
                                    Var ACodigoPortador: String;
                                    AModalidadeTransferencia: TModalidadeTF;
                                    ADatasetImpressao: TDataset);
    class function RetornaDescricaoHistoricoModalidade(AModalidadeTransferencia: TModalidadeTF): String;

    class procedure pLeMovBan(Var fltValor: Double;
                              Var strCodPor: String;
                              strForma: String;
                              intSeqTrf: Integer;
                              dtaDtaCad: TDateTime;
                              ACodigoEmpresa: String);
  end;

var
  frmRcxReimpTransfer: TfrmRcxReimpTransfer;
  strCodEmp : String;
  strTipImp: String;

function fLoadReport(strTipImp: String): Boolean;

procedure pImprimeTransferencia(intSeqCon: Integer; strCodEmp: String; dtaDtaCad: TDateTime; intQtdImp: Integer;
                                strPorDin, strPorOrd, strPorAvi, strPorPre, strPorCre, strPorFin: String;
                                fltValDin, fltValOrd, fltValAvi, fltValPre, fltValCre, fltValFin: Double;
                                cdsCheAvi, cdsChePre, cdsCarCre: TUniClientDataSet;
                                blnLisChe, blnLisCar, blnReimpressao: Boolean;
                                strRecibo: String; strOpeTransf: String; strTipoImpressao: string = 'I';
                                strCodigoCaixa: String = ''; orderBy: Integer=0);

function ValidarCampoDoRecibo(AImpress: TUniQuery; ACampo: String; AReciboValido: Boolean): Boolean;

procedure pImprimeTransferenciaPar(strSeqRcx: String; intQtdImp: Integer;
                                   strPorGua, strPorDol, strPorEur, strPorPes, strPorRea, strPorOrd, strPorAvi,
                                   strPorPre, strPorCre, strPorFin: String;
                                   fltValGua, fltValDol, fltValEur, fltValPes, fltValRea, fltValOrd, fltValAvi,
                                   fltValPre, fltValCre, fltValFin: Double;
                                   cdsCheAvi, cdsChePre, cdsCarCre: TUniClientDataSet;
                                   blnLisChe, blnLisCar, blnReimpressao: Boolean;
                                   strRecibo: String; orderBy: Integer=0);

implementation

uses untFuncoesSimples, untQckRcxCompTransf, untCfgRel, untPesqAux, untConsultas, untTypesSistema,
  untRcxTransferenciaImpr;

{$R *.dfm}


function TfrmRcxReimpTransfer.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
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
      Else
      Begin
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

class procedure TfrmRcxReimpTransfer.LerMovBanBanTrf(var AValorMovBan: Double;
  var ACodigoPortador: String; AModalidadeTransferencia: TModalidadeTF;
  ADatasetImpressao: TDataset);
  Var
    LConsulta: TUniQuery;
Begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT B.CTB_CODPOR, ' +
                          '       SUM(B.CTB_VALLAN) AS CTB_VALLAN ' +
                          'FROM MOVBAN B ' +
                          'LEFT JOIN BANTRF T ON T.CTB_SEQLAN=B.CTB_SEQLAN ' +
                          'WHERE B.CTB_SEQTRF = :SEQTRF ' +
                          '  AND B.CTB_CODEMP IN ("' + ADatasetImpressao.FieldByName('RCX_CODEMP').AsString + '") ' +
                          '  AND B.CTB_DTALAN = :DTALAN ';

    Case AModalidadeTransferencia Of
      mtfDinheiro: LConsulta.SQL.Add('  AND T.RCX_DINREC > 0 ');
      mtfCartao: LConsulta.SQL.Add('  AND T.RCX_CARREC > 0 ');
      mtfOrdemPagamento: LConsulta.SQL.Add('  AND T.RCX_ORDREC > 0 ');
      mtfPix: LConsulta.SQL.Add('  AND T.RCX_ORDREC > 0 ');
      mtfChequePre: LConsulta.SQL.Add('  AND T.RCX_CHQPRE > 0 ');
      mtfChequeAVista: LConsulta.SQL.Add('  AND T.RCX_CHQAVI > 0 ');
      mtfFinanciamento: LConsulta.SQL.Add('  AND T.RCX_VALFIN > 0 ');
      mtfOrdemPagamentoAutomatica: LConsulta.SQL.Add('  AND T.RCX_ORDREC > 0 ');
    End;

    LConsulta.SQL.Add('GROUP BY CTB_CODPOR ');

    LConsulta.ParamByName('SEQTRF').AsInteger  := ADatasetImpressao.FieldByName('RCX_SEQCON').AsInteger;
    LConsulta.ParamByName('DTALAN').AsDateTime := ADatasetImpressao.FieldByName('CTB_DTALAN').AsDateTime;

    LConsulta.Open;

    If Not LConsulta.IsEmpty Then
    Begin
      AValorMovBan := fFormataFloat(LConsulta.FieldByName('CTB_VALLAN').AsFloat, 2);
      ACodigoPortador := LConsulta.FieldByName('CTB_CODPOR').AsString;
    End
    Else
      TfrmRcxReimpTransfer.pLeMovBan(AValorMovBan,
                                     ACodigoPortador,
                                     RetornaDescricaoHistoricoModalidade(AModalidadeTransferencia),
                                     ADatasetImpressao.FieldByName('RCX_SEQCON').AsInteger,
                                     ADatasetImpressao.FieldByName('CTB_DTALAN').AsDateTime,
                                     ADatasetImpressao.FieldByName('RCX_CODEMP').AsString);
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

procedure TfrmRcxReimpTransfer.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  With qryConEmp Do
  Begin
    edtNomEmp.Text := FieldByName('EMP_NOMEMP').AsString;
  End;
end;

procedure TfrmRcxReimpTransfer.pLimpaTela;
begin
  qryRegistros.Close;
  pCarregaEmpresa;
  pSetFocus(mskDtaIni);
end;

class function TfrmRcxReimpTransfer.RetornaDescricaoHistoricoModalidade(
  AModalidadeTransferencia: TModalidadeTF): String;
begin
  Result := EmptyStr;

  Case AModalidadeTransferencia Of
    mtfDinheiro: Result := 'TF CAIXA%%(DIN)';
    mtfCartao: Result := 'TF CAIXA%%(CAR)';
    mtfOrdemPagamento: Result := 'TF CAIXA%%(OP) ';
    mtfPix: Result := 'TF CAIXA%%(OP-PIX) ';
    mtfChequePre: Result := 'TF CAIXA%%(CHP)';
    mtfChequeAVista: Result := 'TF CAIXA%%(CHV)';
    mtfFinanciamento: Result := 'TF CAIXA%%(FIN)';
    mtfOrdemPagamentoAutomatica: Result := 'TF CAIXA%%(ORD) ';
  End;
end;

function TfrmRcxReimpTransfer.RetornaSQLTransferenciasAgrupadas: String;
begin
  Result := '';
  Result := Result + 'SELECT                                   ';
  Result := Result + '  RCX_CODEMP,                            ';
  Result := Result + '  RCX_DTACAD,                            ';
  Result := Result + '  RCX_HORCAD,                            ';
  Result := Result + '  RCX_DESCRI,                            ';
  Result := Result + '  RCX_CODCAX,                            ';
  Result := Result + '  RCX_VALDOC,                            ';
  Result := Result + '  RTF_CODOPE,                            ';
  Result := Result + '  RTF_RECIBO,                            ';
  Result := Result + '  RCX_SEQCON                             ';
  Result := Result + 'FROM                                     ';
  Result := Result + '  (SELECT                                ';
  Result := Result + '    RCX_CODEMP,                          ';
  Result := Result + '    RCX_DTACAD,                          ';
  Result := Result + '    RCX_HORCAD,                          ';
  Result := Result + '    RCX_DESCRI,                          ';
  Result := Result + '    RCX_CODCAX,                          ';
  Result := Result + '    SUM(- 1 * RCX_VALDOC) AS RCX_VALDOC, ';
  Result := Result + '    RCX_SEQCON                           ';
  Result := Result + '  FROM CADRCXX WHERE                     ';
  Result := Result + '    RCX_ESPDOC = "TF"                    ';
  Result := Result + '    AND RCX_TFCANC = "N"                 ';
  Result := Result + '    AND RCX_CODEMP IN (' + fRetStrToSQLIn(strCodEmp) + ') ';

  If Not fEmptyStr(edtSequencialTransf.Text)Then
  Begin
      Result := Result + '    AND RCX_SEQCON = :SEQCON                   ';
  End
  Else
  Begin
  If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And
     (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
    Result := Result + '    AND RCX_DTACAD BETWEEN :DTAINI AND :DTAFIN ';
   End;

  Result := Result + '  GROUP BY RCX_CODEMP,                   ';
  Result := Result + '    RCX_SEQCON) AS RCXTMP                ';
  Result := Result + 'INNER JOIN CADRTF                        ';
  Result := Result + '  ON RTF_RCXCON  = RCX_SEQCON            ';
  Result := Result + '  AND RTF_CODEMP = RCX_CODEMP            ';
  Result := Result + '  GROUP BY RCX_CODEMP,                   ';
  Result := Result + '  RCX_SEQCON                             ';
end;

function TfrmRcxReimpTransfer.fCarregaTransferencias: Boolean;
begin
  strCodEmp := edtCodEmp.Text;
  If fEmptyStr(edtCodEmp.Text) Then
  begin
    strCodEmp := VS_strCodEmp;
    if blnLiberado then
      strCodEmp := strEmpAcessoUsuarioLogado;
  end;

  qryRegistros.Close;
  qryRegistros.SQL.Text := RetornaSQLTransferenciasAgrupadas;

  If Not fEmptyStr(edtSequencialTransf.Text)Then
  Begin
    qryRegistros.ParamByName('SEQCON').AsInteger := StrToInt(edtSequencialTransf.Text);
  End

  Else
  Begin
    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And
        (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
    Begin
      qryRegistros.ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
      qryRegistros.ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
    End;

  End;

  qryRegistros.Open;

  TFloatField(qryRegistros.FieldByName('RCX_VALDOC')).DisplayFormat := '##,#0.00';

  Result := Not qryRegistros.IsEmpty;
  If Not Result Then
    fMensagem('', 'Nenhuma transferência foi encontrada!', ['&OK']);
end;


Function fCarregaCheques(blnAPrazo: Boolean; orderBy:Integer): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE      ';
  strSQL := strSQL + '   CHQ_CODBCO AS BANCO,   ';
  strSQL := strSQL + '   CHQ_NUMAGE AS AGENCIA, ';
  strSQL := strSQL + '   CHQ_CONCOR AS CONTA,   ';
  strSQL := strSQL + '   CHQ_NUMCHQ AS NUMERO,  ';
  strSQL := strSQL + '   CHQ_CODCLI AS CODCLI,  ';
  strSQL := strSQL + '   CHQ_NOMEMI AS NOMEMI,  ';
  strSQL := strSQL + '   CHQ_VALCHQ AS VALOR,   ';
  strSQL := strSQL + '   CHQ_DTACAD AS DTACAD,                      ';
  strSQL := strSQL + '   CHQ_DTAVEN AS DTAVEN,                      ';
  strSQL := strSQL + '   DATEDIFF(CHQ_DTAVEN, CHQ_DTACAD) AS QTDDIA ';
  strSQL := strSQL + ' FROM CADCHQ ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   CHQ_SEQTRF = :SEQCON AND ';
  strSQL := strSQL + '   LOCATE(CHQ_CODEMP, :CODEMP) AND ';

  If blnAPrazo Then
    strSQL := strSQL + '   CHQ_DTAVEN >  CHQ_DTACAD '
  Else
    strSQL := strSQL + '   CHQ_DTAVEN <= CHQ_DTACAD ';

  if orderBy = 0 Then
    strSQL := strSQL + ' ORDER BY DTACAD, CODCLI, AUTOINCREM '
  Else
    strSQL := strSQL + ' ORDER BY VALOR ';

  Result := strSQL;
End;

Function fCarregaCartoes(orderBy:Integer) : String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE    ';
  strSQL := strSQL + '  MCA_CODCLI AS CODCLI, ';
  strSQL := strSQL + '  CLI_NOMCLI AS NOMEMI, ';
  strSQL := strSQL + '  SUM(MCA_VALSTA) AS VALOR, ';
  strSQL := strSQL + '  MCA_DTACAD AS DTACAD, ';
  strSQL := strSQL + '  MCA_DTAVEN AS DTAVEN, ';
  strSQL := strSQL + '  MCA_CODCAR AS CODCAR, ';
  strSQL := strSQL + '  MCA_NUMCCD AS NUMCCD, ';
  strSQL := strSQL + '  MCA_DOCUME AS DOCUME, ';
  strSQL := strSQL + '  CAR_TIPCAR AS TIPCAR, '; //MF: 295418 - 07/08/23

  strSQL := strSQL + '  (                                                    ';
  strSQL := strSQL + '    SELECT                                             ';
  strSQL := strSQL + '      RCX_CODOPE                                       ';
  strSQL := strSQL + '    FROM                                               ';
  strSQL := strSQL + '      CADRCXX                                          ';
  strSQL := strSQL + '    WHERE                                              ';
  strSQL := strSQL + '      RCX_SEQCON = MCA_SEQCON AND                      ';
  strSQL := strSQL + '      RCX_CARREC <> 0 AND                              ';
  strSQL := strSQL + '      RCX_CODEMP IN (:CODEMPIN) LIMIT 1                ';
  strSQL := strSQL + '  ) AS RCX_CODOPE,                                     ';

  strSQL := strSQL + '  (                                                    ';
  strSQL := strSQL + '    SELECT                                             ';
  strSQL := strSQL + '      COUNT(*)                                         ';
  strSQL := strSQL + '    FROM                                               ';
  strSQL := strSQL + '      CADRCXX                                          ';
  strSQL := strSQL + '    WHERE                                              ';
  strSQL := strSQL + '      RCX_SEQCON = MCA_SEQCON AND                      ';
  strSQL := strSQL + '      RCX_CARREC <> 0 AND                              ';
  strSQL := strSQL + '      RCX_CODEMP IN (:CODEMPIN)                        ';
  strSQL := strSQL + '  ) AS VALRCX                                          ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVCAR ';
  strSQL := strSQL + '  JOIN CADCAR ON (CAR_CODCAR=MCA_CODCAR) ';
  strSQL := strSQL + '  JOIN CADCLI ON (CLI_CODCLI=MCA_CODCLI) ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  MCA_EMPRCX IN (:CODEMPIN) AND ';
  strSQL := strSQL + '  MCA_SEQTRF = :SEQCON     ';

  strSQL := strSQL + ' GROUP BY ';
  strSQL := strSQL + '   MCA_SEQCON, MCA_NUMDUP, MCA_CODCLI, MCA_CODEMP ';

  strSQL := strSQL + 'HAVING  ';
  strSQL := strSQL + '  VALRCX > 0 ';

  if orderBy = 0 Then
    strSQL := strSQL + ' ORDER BY DTACAD, CODCLI, MOVCAR.AUTOINCREM '
  Else
    strSQL := strSQL + ' ORDER BY VALOR ';



  Result := strSQL;
End;

class procedure TfrmRcxReimpTransfer.pLeMovBan(Var fltValor: Double;
                                               Var strCodPor: String;
                                               strForma: String;
                                               intSeqTrf: Integer;
                                               dtaDtaCad: TDateTime;
                                               ACodigoEmpresa: String);
  Var
    qryMovBan: TUniQuery;
Begin
  qryMovBan := fCriaQuery;

  qryMovBan.SQL.Clear;

  qryMovBan.SQL.Add('SELECT                          ');
  qryMovBan.SQL.Add('  CTB_CODPOR,                   ');
  qryMovBan.SQL.Add('  SUM(CTB_VALLAN) AS CTB_VALLAN ');
  qryMovBan.SQL.Add('FROM MOVBAN                     ');
  qryMovBan.SQL.Add('WHERE                           ');
  qryMovBan.SQL.Add('  CTB_SEQTRF = :SEQTRF AND      ');
  qryMovBan.SQL.Add('  CTB_CODEMP IN ("' + ACodigoEmpresa + '") AND ');
  qryMovBan.SQL.Add('  CTB_DTALAN = :DTALAN AND      ');
  qryMovBan.SQL.Add('  CTB_HIST01 LIKE :HIST01       ');
  qryMovBan.SQL.Add('GROUP BY CTB_CODPOR             ');

  qryMovBan.ParamByName('SEQTRF').AsInteger  := intSeqTrf;
  qryMovBan.ParamByName('HIST01').AsString   := strForma + '%';
  qryMovBan.ParamByName('DTALAN').AsDateTime := dtaDtaCad;

  qryMovBan.Open;

  If Not qryMovBan.IsEmpty Then
  Begin
    fltValor  := qryMovBan.FieldByName('CTB_VALLAN').AsFloat;
    strCodPor := qryMovBan.FieldByName('CTB_CODPOR').AsString;
  End;

  qryMovBan.Close;

  FreeAndNil(qryMovBan);
End;

//MF: 295418 - 08/08/23
function fValorCartaoCreDeb(cdsCarCre: TUniQuery; strCreDeb: String): Double;
var
  fltValCar: Double;
begin
  fltValCar := 0;
  If (Not cdsCarCre.IsEmpty) Then
  Begin
    cdsCarCre.Filter := 'TIPCAR = ' + QuotedStr(strCreDeb);
    cdsCarCre.Filtered := True;
    cdsCarCre.First;
    While Not cdsCarCre.EOF Do
    Begin
      fltValCar := fltValCar + cdsCarCre.FieldByName('VALOR').AsFloat;
      cdsCarCre.Next;
    End;
    cdsCarCre.Filtered := False;
  End;

  Result := fltValCar;
end;

{**************************************}
{* IMPRIME A CONFIRMAÇÃO DA TRANSF.   *}
{***********************************AF*}
procedure pImprimeTransferencia(intSeqCon: Integer; strCodEmp: String; dtaDtaCad: TDateTime; intQtdImp: Integer;
                                strPorDin, strPorOrd, strPorAvi, strPorPre, strPorCre, strPorFin: String;
                                fltValDin, fltValOrd, fltValAvi, fltValPre, fltValCre, fltValFin: Double;
                                cdsCheAvi, cdsChePre, cdsCarCre: TUniClientDataSet;
                                blnLisChe, blnLisCar, blnReimpressao: Boolean;
                                strRecibo: String; strOpeTransf: String; strTipoImpressao: string = 'I';
                                strCodigoCaixa: String = ''; orderBy: Integer=0);
  Var
    strNomeFila: String;
    strTipImp  : String;
    intCont    : Integer;
    frxRel     : TfrxReport;
    qryImpress,
    qryCheAvi,
    qryChePre,
    qryCarCre,
    qryCfgRel,
    qryDadosEmp: TUniQuery;
    Fr340CEpson: String;
    LReciboValido: Boolean;
    blnImprimePersonalizado: Boolean;
    frmRcxTransferenciaImpr: TfrmRcxTransferenciaImpr;

    LValorPix: Double;

    LRegistrosImpressos: Integer;

    Procedure pAbreCheAvi(intSeqCom: Integer);
    Begin
      qryCheAvi := fCriaQuery;
      With qryCheAvi Do
      Begin
        SQL.Text := fCarregaCheques(False,orderBy);
        ParamByName('CODEMP').AsString  := strCodEmp;
        ParamByName('SEQCON').AsInteger := intSeqCom;
        Open;
      End;
    End;

    Procedure pAbreChePre(intSeqCom: Integer);
    Begin
      qryChePre := fCriaQuery;
      With qryChePre Do
      Begin
        SQL.Text := fCarregaCheques(True, orderBy);
        ParamByName('CODEMP').AsString  := strCodEmp;
        ParamByName('SEQCON').AsInteger := intSeqCom;
        Open;
      End;
    End;

    Procedure pAbreCarCre(intSeqCom: Integer);
    Begin
      qryCarCre := fCriaQuery;
      With qryCarCre Do
      Begin
        SQL.Text := StringReplace(fCarregaCartoes(orderBy), ':CODEMPIN', fRetStrToSQLIn(strCodEmp), [rfReplaceAll]);
        ParamByName('SEQCON').AsInteger := intSeqCom;
        Open;
      End;
    End;

    Procedure pAbreTabelas;
    Begin

      pAbreCheAvi(qryImpress.FieldByName('RCX_SEQCON').AsInteger);

      pAbreChePre(qryImpress.FieldByName('RCX_SEQCON').AsInteger);

      pAbreCarCre(qryImpress.FieldByName('RCX_SEQCON').AsInteger);

      TfrmRcxReimpTransfer.LerMovBanBanTrf(fltValDin, strPorDin, mtfDinheiro, qryImpress);
      TfrmRcxReimpTransfer.LerMovBanBanTrf(fltValAvi, strPorAvi, mtfChequeAvista, qryImpress);
      TfrmRcxReimpTransfer.LerMovBanBanTrf(fltValPre, strPorPre, mtfChequePre, qryImpress);
      TfrmRcxReimpTransfer.LerMovBanBanTrf(fltValCre, strPorCre, mtfCartao, qryImpress);
      TfrmRcxReimpTransfer.LerMovBanBanTrf(fltValOrd, strPorOrd, mtfOrdemPagamento, qryImpress);
      TfrmRcxReimpTransfer.LerMovBanBanTrf(fltValFin, strPorFin, mtfFinanciamento, qryImpress);
      TfrmRcxReimpTransfer.LerMovBanBanTrf(LValorPix, strPorOrd, mtfPix, qryImpress);
      TfrmRcxReimpTransfer.LerMovBanBanTrf(fltValOrd, strPorOrd, mtfOrdemPagamentoAutomatica, qryImpress);
    End;

    function RetornaLayout40CEpson: String;
    begin
      Result := ExtractFilePath(Application.ExeName) + 'Fr3\' + 'TRANSFERENCIA_40C_EPSON.fr3';

      If Not FileExists(Result) Then
        Result := '';
    end;

begin

  Try
    qryImpress := fCriaQuery;
    qryCfgRel := fCriaQuery;
    qryDadosEmp := fCriaQuery;

    qryImpress.SQL.Add('SELECT                         ');
    qryImpress.SQL.Add('  MOVBAN.*,                    ');
    qryImpress.SQL.Add('  RCX_SEQCON,                  ');
    qryImpress.SQL.Add('  RCX_DTACAD,                  ');
    qryImpress.SQL.Add('  RCX_HORCAD,                  ');
    qryImpress.SQL.Add('  RCX_CODEMP,                  ');
    qryImpress.SQL.Add('  RCX_CODCAX,                  ');
    qryImpress.SQL.Add('  RTF_CODOPE,                  ');
    qryImpress.SQL.Add('  RTF_RECIBO,                  ');
    qryImpress.SQL.Add('  RCX_DINREC,                  ');
    qryImpress.SQL.Add('  RCX_CHQAVI,                  ');
    qryImpress.SQL.Add('  RCX_CHQPRE,                  ');
    qryImpress.SQL.Add('  RCX_CARREC,                  ');
    qryImpress.SQL.Add('  RCX_ORDREC,                  ');
    qryImpress.SQL.Add('  RCX_IDEFEC,                  ');
    qryImpress.SQL.Add('  E.EMP_CODEMP AS CODEMPTRF,   ');
    qryImpress.SQL.Add('  E.EMP_NOMEMP AS NOMEMPTRF,   ');
    qryImpress.SQL.Add('  E.EMP_FONE01 AS FONEMPTRF,   ');
    qryImpress.SQL.Add('  C.CID_NOMCID AS CIDEMPTRF,   ');
    qryImpress.SQL.Add('  C.CID_ESTADO AS ESTEMPTRF    ');
    qryImpress.SQL.Add('FROM                           ');
    qryImpress.SQL.Add('  (SELECT                      ');
    qryImpress.SQL.Add('    RCX_SEQCON,                ');
    qryImpress.SQL.Add('    RCX_DTACAD,                ');
    qryImpress.SQL.Add('    RCX_HORCAD,                ');
    qryImpress.SQL.Add('    RCX_CODEMP,                ');
    qryImpress.SQL.Add('    RCX_CODCAX,                ');
    qryImpress.SQL.Add('    RCX_IDEFEC,                ');
    qryImpress.SQL.Add('    SUM(RCX_DINREC * (-1)) AS RCX_DINREC,');
    qryImpress.SQL.Add('    SUM(RCX_CHQAVI * (-1)) AS RCX_CHQAVI,');
    qryImpress.SQL.Add('    SUM(RCX_CHQPRE * (-1)) AS RCX_CHQPRE,');
    qryImpress.SQL.Add('    SUM(RCX_CARREC * (-1)) AS RCX_CARREC,');
    qryImpress.SQL.Add('    SUM(RCX_ORDREC * (-1)) AS RCX_ORDREC ');
    qryImpress.SQL.Add('  FROM                         ');
    qryImpress.SQL.Add('    CADRCXX                    ');
    qryImpress.SQL.Add('  WHERE                        ');
    qryImpress.SQL.Add('    RCX_SEQCON = :SEQCON       ');
    qryImpress.SQL.Add('    AND RCX_DTACAD = :DTACAD   ');
    qryImpress.SQL.Add('    AND RCX_CODEMP IN (' + fRetStrToSQLIn(strCodEmp) + ') ');
    qryImpress.SQL.Add('    AND RCX_ESPDOC = "TF"      ');
    qryImpress.SQL.Add('    AND RCX_TFCANC = "N"       ');
    qryImpress.SQL.Add('  GROUP BY                     ');
    qryImpress.SQL.Add('    RCX_SEQCON, RCX_CODEMP) RCX  ');
    qryImpress.SQL.Add('INNER JOIN CADRTF              ');
    qryImpress.SQL.Add('  ON RTF_RCXCON = RCX_SEQCON   ');
    qryImpress.SQL.Add('  AND RTF_CODEMP = RCX_CODEMP  ');
    qryImpress.SQL.Add('INNER JOIN MOVBAN              ');
    qryImpress.SQL.Add('  ON CTB_SEQTRF = RTF_RCXCON   ');
    qryImpress.SQL.Add('  AND CTB_CODEMP = RTF_CODEMP  ');
    qryImpress.SQL.Add('INNER JOIN CADEMP E            ');
    qryImpress.SQL.Add('  ON E.EMP_CODEMP=RCX.RCX_CODEMP ');
    qryImpress.SQL.Add('INNER JOIN CADCID C            ');
    qryImpress.SQL.Add('  ON C.CID_CODCID=E.EMP_CODCID ');

    qryImpress.ParamByName('SEQCON').AsInteger  := intSeqCon;
    qryImpress.ParamByName('DTACAD').AsDateTime := dtaDtaCad;
    qryImpress.Open;

    //VALIDANDO O RECIBO, POIS EXISTEM OS MESMOS SEQCONS PARA A MESMA EMRPESA
    If qryImpress.RecordCount > 1 Then
    Begin
      LReciboValido := False;
      While Not qryImpress.Eof Do
      Begin
        LReciboValido := True;
        LReciboValido := ValidarCampoDoRecibo(qryImpress, 'RCX_DINREC', LReciboValido);
        LReciboValido := ValidarCampoDoRecibo(qryImpress, 'RCX_CHQAVI', LReciboValido);
        LReciboValido := ValidarCampoDoRecibo(qryImpress, 'RCX_CHQPRE', LReciboValido);
        LReciboValido := ValidarCampoDoRecibo(qryImpress, 'RCX_CARREC', LReciboValido);
        LReciboValido := ValidarCampoDoRecibo(qryImpress, 'RCX_ORDREC', LReciboValido);

        If LReciboValido Then
          Break;

        qryImpress.Next;
      End;

      If Not LReciboValido Then
        qryImpress.First;
    End;

    Try
      pCarregaConfImpr(qryCfgRel, 'frmRcxResumoCaixaTRANSFERENCIA');
      if strTipoImpressao = 'I' then
        fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False);
      pCriarFormularios(TfrmQckRcxCompTransf,frmQckRcxCompTransf);

      blnImprimePersonalizado := fLoadReport(strTipImp);

      frmQckRcxCompTransf.strCodEmp := VS_strCodEmp;

      if Not fEmptyStr(strOpeTransf) then
      begin
        frmQckRcxCompTransf.strCodOpe := strOpeTransf;
        frmQckRcxCompTransf.strNomOpe := fRetNomeOperador(strOpeTransf);
      end
      else
      begin
        frmQckRcxCompTransf.strCodOpe := qryImpress.FieldByName('RTF_CODOPE').AsString;
        frmQckRcxCompTransf.strNomOpe := fRetNomeOperador(qryImpress.FieldByName('RTF_CODOPE').AsString);
      end;

      frmQckRcxCompTransf.intSeqCon := qryImpress.FieldByName('RCX_SEQCON').AsInteger;

      If Not fEmptyStr(strRecibo) Then
        frmQckRcxCompTransf.strDados  := strRecibo
      Else
        frmQckRcxCompTransf.strDados  := qryImpress.FieldByName('RTF_RECIBO').AsString;

      frmQckRcxCompTransf.strRecibo := fMontaReciboPer(qryImpress.FieldByName('RTF_RECIBO').AsString);

      frmQckRcxCompTransf.dtaDatCad := qryImpress.FieldByName('RCX_DTACAD').AsDateTime;
      frmQckRcxCompTransf.horHorCad := qryImpress.FieldByName('RCX_HORCAD').AsDateTime;

      frmQckRcxCompTransf.strCaixa := '';
      If Not strCodigoCaixa.IsEmpty Then
         frmQckRcxCompTransf.strCaixa := strCodigoCaixa + '-' + fCampoTabela('CAX_DESCRI', 'CADCAX', ['CAX_CODCAX', 'CAX_CODEMP'], [strCodigoCaixa, qryImpress.FieldByName('RCX_CODEMP').AsString]);

      frmQckRcxCompTransf.CodigoEmpresaTrf := qryImpress.FieldByName('CODEMPTRF').AsString;
      frmQckRcxCompTransf.NomeEmpresaTrf := qryImpress.FieldByName('NOMEMPTRF').AsString;
      frmQckRcxCompTransf.FoneEmpresaTrf := qryImpress.FieldByName('FONEMPTRF').AsString;
      frmQckRcxCompTransf.CidadeEmpresaTrf := qryImpress.FieldByName('CIDEMPTRF').AsString;
      frmQckRcxCompTransf.UfEmpresaTrf := qryImpress.FieldByName('ESTEMPTRF').AsString;

      If fCfgSis('COLTRF') = '1' Then
      Begin
        Fr340CEpson := RetornaLayout40CEpson;

        If Not fEmptyStr(Fr340CEpson) Then
        begin
          frxRel := frmQckRcxCompTransf.frxQckRcxCompTransf40Col_Epson;
          frxRel.LoadFromFile(Fr340CEpson);
        end
        else
        begin
          If SameText(strTipImp, 'M') Then
            frxRel := frmQckRcxCompTransf.frxQckRcxCompTransf40Col_M
          Else
            frxRel := frmQckRcxCompTransf.frxQckRcxCompTransf40Col_J;
        end;

        For intCont := 1 To fCfgSis('QTDSAL', varInteger) Do
          If SameText(strTipImp, 'M') Then
            TfrxDMPMemoView(frxRel.FindObject('rllSalto')).Lines.Add('')
          Else
            TfrxMemoView(frxRel.FindObject('rllSalto')).Lines.Add('');

        If blnImprimePersonalizado Then
        Begin
          With qryDadosEmp Do
          Begin
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
            ParamByName('CODEMP').AsString := VS_strCodEmp;
            Open;

            If Assigned(frxRel.FindObject('memNOMEMP')) Then
              TfrxMemoView(frxRel.FindObject('memNOMEMP')).Memo.Text := FieldByName('NOMEMP').AsString;

            If Assigned(frxRel.FindObject('memFONE01')) Then
              TfrxMemoView(frxRel.FindObject('memFONE01')).Memo.Text := FieldByName('FONE01').AsString;

            If Assigned(frxRel.FindObject('memCIDEMP')) Then
              TfrxMemoView(frxRel.FindObject('memCIDEMP')).Memo.Text := fTiraCaracEspeciais(FieldByName('NOMCID').AsString) + '-' + fTiraCaracEspeciais(FieldByName('ESTADO').AsString);

            //MF: 295418 - 07/08/23 - INICIO
            If (Assigned(frxRel.FindObject('memDatasets'))) Then
            Begin

              If (blnReimpressao) Then
              Begin
                pCriarFormularios(TfrmRcxTransferenciaImpr, frmRcxTransferenciaImpr);
                frmRcxTransferenciaImpr.chkImpTf.Checked := True;
                frmRcxTransferenciaImpr.chkImpTf.Enabled := False;

                If frmRcxTransferenciaImpr.ShowModal = mrOk Then
                Begin
                  blnLisChe := frmRcxTransferenciaImpr.chkImpChq.Checked;
                  blnLisCar := frmRcxTransferenciaImpr.chkImpCar.Checked;
                  orderBy   := frmRcxTransferenciaImpr.rdgOrdenacao.ItemIndex;
                End;
                pFreeAndNil(frmRcxTransferenciaImpr);
              End;

              pAbreTabelas;
              frmQckRcxCompTransf.frxDBCheAvi.DataSet := qryCheAvi;
              frmQckRcxCompTransf.frxDBChePre.DataSet := qryChePre;
              frmQckRcxCompTransf.frxDBCarCre.DataSet := qryCarCre;

              If Assigned(frxRel.FindObject('ChildDinheiro')) Then
                 TfrxChild(frxRel.FindObject('ChildDinheiro')).Visible    := fltValDin > 0;

              If Assigned(frxRel.FindObject('ChildCheAviCabec')) Then
                 TfrxChild(frxRel.FindObject('ChildCheAviCabec')).Visible := fltValAvi > 0;

              If Assigned(frxRel.FindObject('ChildCheAvi')) Then
                 TfrxChild(frxRel.FindObject('ChildCheAvi')).Visible      := blnLisChe And (fltValAvi > 0);

              If Assigned(frxRel.FindObject('ChildChePreCabec')) Then
                 TfrxChild(frxRel.FindObject('ChildChePreCabec')).Visible := fltValPre > 0;

              If Assigned(frxRel.FindObject('ChildChePre')) Then
                 TfrxChild(frxRel.FindObject('ChildChePre')).Visible      := blnLisChe And (fltValPre > 0);

              If Assigned(frxRel.FindObject('ChildCarCreCabec')) Then
                 TfrxChild(frxRel.FindObject('ChildCarCreCabec')).Visible := fValorCartaoCreDeb(qryCarCre, 'C') > 0;

              If Assigned(frxRel.FindObject('ChildCarDebCabec')) Then
                 TfrxChild(frxRel.FindObject('ChildCarDebCabec')).Visible := fValorCartaoCreDeb(qryCarCre, 'D') > 0;

              If Assigned(frxRel.FindObject('ChildCarCre')) Then
                 TfrxChild(frxRel.FindObject('ChildCarCre')).Visible      := blnLisCar And (fltValCre > 0);

              If Assigned(frxRel.FindObject('ChildOrdemPagto')) Then
                 TfrxChild(frxRel.FindObject('ChildOrdemPagto')).Visible  := (fltValOrd > 0) And (LValorPix = 0);

              If Assigned(frxRel.FindObject('ChildOrdemPagtoPix')) Then
                 TfrxChild(frxRel.FindObject('ChildOrdemPagtoPix')).Visible  := LValorPix > 0;

              If Assigned(frxRel.FindObject('ChildFinanc')) Then
                 TfrxChild(frxRel.FindObject('ChildFinanc')).Visible      := fltValFin > 0;

              frxRel.Script.Variables['PORDINHEI'] := 'PORTADOR: ' + strPorDin + '-' + fRetNomPortador(strPorDin);
              frxRel.Script.Variables['VALDINHEI'] := 'VALOR: ' + FormatFloat('#,##0.00', fltValDin);

              frxRel.Script.Variables['PORORDPAG'] := 'PORTADOR: ' + strPorOrd + '-' + fRetNomPortador(strPorOrd);
              frxRel.Script.Variables['VALORDPAG'] := 'VALOR: ' + FormatFloat('#,##0.00', fltValOrd);

              frxRel.Script.Variables['VALORDPIX'] := 'VALOR: ' + FormatFloat('#,##0.00', LValorPix);

              frxRel.Script.Variables['PORCHEAVI'] := 'PORTADOR: ' + strPorAvi + '-' + fRetNomPortador(strPorAvi);
              frxRel.Script.Variables['VALCHEAVI'] := 'VALOR: ' + FormatFloat('#,##0.00', fltValAvi);

              frxRel.Script.Variables['PORCHEPRE'] := 'PORTADOR: ' + strPorPre + '-' + fRetNomPortador(strPorPre);
              frxRel.Script.Variables['VALCHEPRE'] := 'VALOR: ' + FormatFloat('#,##0.00', fltValPre);

              frxRel.Script.Variables['PORCARCRE'] := 'PORTADOR: ' + strPorCre + '-' + fRetNomPortador(strPorCre);
              frxRel.Script.Variables['VALCARCRE'] := 'VALOR: ' + FormatFloat('#,##0.00', fValorCartaoCreDeb(qryCarCre, 'C'));//fltValCre);

              frxRel.Script.Variables['PORCARDEB'] := 'PORTADOR: ' + strPorCre + '-' + fRetNomPortador(strPorCre);
              frxRel.Script.Variables['VALCARDEB'] := 'VALOR: ' + FormatFloat('#,##0.00', fValorCartaoCreDeb(qryCarCre, 'D'));

              frxRel.Script.Variables['PORFIN'] := 'PORTADOR: ' + strPorFin + '-' + fRetNomPortador(strPorFin);
              frxRel.Script.Variables['VALFIN'] := 'VALOR: ' + FormatFloat('#,##0.00', fltValFin);
            End;
            //MF: 295418 - 07/08/23 - FIM
          End;

          If Assigned(frxRel.FindObject('memOPERAD')) Then
          Begin
            if Not fEmptyStr(strOpeTransf) then
            begin
              TfrxMemoView(frxRel.FindObject('memOPERAD')).Memo.Text := strOpeTransf + '-' + fRetNomeOperador(strOpeTransf);
            end
            else
            begin
              TfrxMemoView(frxRel.FindObject('memOPERAD')).Memo.Text := qryImpress.FieldByName('RTF_CODOPE').AsString + '-' + fRetNomeOperador(qryImpress.FieldByName('RTF_CODOPE').AsString);
            end;
          End;

          If Assigned(frxRel.FindObject('memSEQCON')) Then
            TfrxMemoView(frxRel.FindObject('memSEQCON')).Memo.Text := IntToStr(qryImpress.FieldByName('RCX_SEQCON').AsInteger);

          If Assigned(frxRel.FindObject('memRESULT')) Then
          Begin
            If Not fEmptyStr(strRecibo) Then
              TfrxMemoView(frxRel.FindObject('memRESULT')).Memo.Text  := strRecibo
            Else
              TfrxMemoView(frxRel.FindObject('memRESULT')).Memo.Text  := qryImpress.FieldByName('RTF_RECIBO').AsString;
          End;

          If Assigned(frxRel.FindObject('memDTACAD')) Then
            TfrxMemoView(frxRel.FindObject('memDTACAD')).Memo.Text := DateToStr(qryImpress.FieldByName('RCX_DTACAD').AsDateTime);

          If Assigned(frxRel.FindObject('memHORCAD')) Then
            TfrxMemoView(frxRel.FindObject('memHORCAD')).Memo.Text := TimeToStr(qryImpress.FieldByName('RCX_HORCAD').AsDateTime);

          If Assigned(frxRel.FindObject('memCAIXA')) Then
          Begin
            TfrxMemoView(frxRel.FindObject('memCAIXA')).Memo.Text := '';
            If Not strCodigoCaixa.IsEmpty Then
              TfrxMemoView(frxRel.FindObject('memCAIXA')).Memo.Text := strCodigoCaixa + '-' + fCampoTabela('CAX_DESCRI', 'CADCAX',  ['CAX_CODCAX', 'CAX_CODEMP'], [strCodigoCaixa, qryImpress.FieldByName('RCX_CODEMP').AsString]);
          End;

        End;

      End Else
      Begin
        frmQckRcxCompTransf.frxDotMatrixExport.PageBreaks := True;

        If SameText(strTipImp, 'M') Then
          frxRel := frmQckRcxCompTransf.frxReport80M
        Else
        Begin
          frxRel := frmQckRcxCompTransf.frxReport80J;

          If Assigned(frxRel.FindObject('mmoZebraAvi')) Then
             TfrxMemoView(frxRel.FindObject('mmoZebraAvi')).Highlight.Color := fCfgSis('CORZEB');

          If Assigned(frxRel.FindObject('mmoZebraPre')) Then
             TfrxMemoView(frxRel.FindObject('mmoZebraPre')).Highlight.Color := fCfgSis('CORZEB');

          If Assigned(frxRel.FindObject('mmoZebraCre')) Then
             TfrxMemoView(frxRel.FindObject('mmoZebraCre')).Highlight.Color := fCfgSis('CORZEB');
        End;

        pAbreTabelas;

        frmQckRcxCompTransf.frxDBCheAvi.DataSet := qryCheAvi;
        frmQckRcxCompTransf.frxDBChePre.DataSet := qryChePre;
        frmQckRcxCompTransf.frxDBCarCre.DataSet := qryCarCre;

        If Assigned(frxRel.FindObject('ChildDinheiro')) Then
           TfrxChild(frxRel.FindObject('ChildDinheiro')).Visible    := fltValDin > 0;

        If Assigned(frxRel.FindObject('ChildCheAviCabec')) Then
           TfrxChild(frxRel.FindObject('ChildCheAviCabec')).Visible := fltValAvi > 0;

        If Assigned(frxRel.FindObject('ChildCheAvi')) Then
           TfrxChild(frxRel.FindObject('ChildCheAvi')).Visible      := blnLisChe And (fltValAvi > 0);

        If Assigned(frxRel.FindObject('ChildChePreCabec')) Then
           TfrxChild(frxRel.FindObject('ChildChePreCabec')).Visible := fltValPre > 0;

        If Assigned(frxRel.FindObject('ChildChePre')) Then
           TfrxChild(frxRel.FindObject('ChildChePre')).Visible      := blnLisChe And (fltValPre > 0);

        If Assigned(frxRel.FindObject('ChildCarCreCabec')) Then
           TfrxChild(frxRel.FindObject('ChildCarCreCabec')).Visible := fltValCre > 0;

        If Assigned(frxRel.FindObject('ChildCarCre')) Then
           TfrxChild(frxRel.FindObject('ChildCarCre')).Visible      := blnLisCar And (fltValCre > 0);

        If Assigned(frxRel.FindObject('ChildOrdemPagto')) Then
           TfrxChild(frxRel.FindObject('ChildOrdemPagto')).Visible  := (fltValOrd > 0) And (LValorPix = 0);

        If Assigned(frxRel.FindObject('ChildOrdemPagtoPix')) Then
           TfrxChild(frxRel.FindObject('ChildOrdemPagtoPix')).Visible  := LValorPix > 0;

        If Assigned(frxRel.FindObject('ChildFinanc')) Then
           TfrxChild(frxRel.FindObject('ChildFinanc')).Visible      := fltValFin > 0;

        If blnImprimePersonalizado Then
        Begin
          If Assigned(frxRel.FindObject('memCAIXA')) Then
          Begin
            TfrxMemoView(frxRel.FindObject('memCAIXA')).Memo.Text := '';
            If Not strCodigoCaixa.IsEmpty Then
              TfrxMemoView(frxRel.FindObject('memCAIXA')).Memo.Text := 'Caixa: ' + strCodigoCaixa + '-' + fCampoTabela('CAX_DESCRI', 'CADCAX',  ['CAX_CODCAX', 'CAX_CODEMP'], [strCodigoCaixa, qryImpress.FieldByName('RCX_CODEMP').AsString]);

          End;

          If Assigned(frxRel.FindObject('memNOMEMP')) Then
            TfrxMemoView(frxRel.FindObject('memNOMEMP')).Memo.Text := fRetNomeEmpresa(VS_strCodEmp);

          If Assigned(frxRel.FindObject('memNOMREL')) Then
            TfrxMemoView(frxRel.FindObject('memNOMREL')).Memo.Text  := 'COMPROVANTE DE TRANSFERENCIA DE CAIXA';

          If Assigned(frxRel.FindObject('memOPERADOR')) Then
          Begin
            if Not fEmptyStr(strOpeTransf) then
            begin
              TfrxMemoView(frxRel.FindObject('memOPERADOR')).Memo.Text := strOpeTransf + '-' + fRetNomeOperador(strOpeTransf);
            end
            else
            begin
              TfrxMemoView(frxRel.FindObject('memOPERADOR')).Memo.Text  := qryImpress.FieldByName('RTF_CODOPE').AsString + '-' + fRetNomeOperador(qryImpress.FieldByName('RTF_CODOPE').AsString);
            end;
          End;

          If Assigned(frxRel.FindObject('memDTADOC')) Then
            TfrxMemoView(frxRel.FindObject('memDTADOC')).Memo.Text  := DateToStr(qryImpress.FieldByName('RCX_DTACAD').AsDateTime);

          If Assigned(frxRel.FindObject('memHORDOC')) Then
            TfrxMemoView(frxRel.FindObject('memHORDOC')).Memo.Text  := TimeToStr(qryImpress.FieldByName('RCX_HORCAD').AsDateTime);

          If Assigned(frxRel.FindObject('memSEQCON')) Then
            TfrxMemoView(frxRel.FindObject('memSEQCON')).Memo.Text  := IntToStr(qryImpress.FieldByName('RCX_SEQCON').AsInteger);

          If Assigned(frxRel.FindObject('memEMPRESA')) Then
            TfrxMemoView(frxRel.FindObject('memEMPRESA')).Memo.Text  := strCodEmp  + '-' + fRetNomeEmpresa(strCodEmp);

          If Assigned(frxRel.FindObject('memNOMROD')) Then
            TfrxMemoView(frxRel.FindObject('memNOMROD')).Memo.Text  := '';

          If Assigned(frxRel.FindObject('memPORDINHEI')) Then
            TfrxMemoView(frxRel.FindObject('memPORDINHEI')).Memo.Text  := 'PORTADOR: ' + strPorDin + '-' + fRetNomPortador(strPorDin);
          If Assigned(frxRel.FindObject('memVALDINHEI')) Then
            TfrxMemoView(frxRel.FindObject('memVALDINHEI')).Memo.Text  := FormatFloat(',0.00', fltValDin);

          If Assigned(frxRel.FindObject('memPORORDPAG')) Then
            TfrxMemoView(frxRel.FindObject('memPORORDPAG')).Memo.Text  := 'PORTADOR: ' + strPorOrd + '-' + fRetNomPortador(strPorOrd);
          If Assigned(frxRel.FindObject('memVALORDPAG')) Then
            TfrxMemoView(frxRel.FindObject('memVALORDPAG')).Memo.Text  := FormatFloat(',0.00', fltValOrd);

          If Assigned(frxRel.FindObject('memVALORDPAGPIX')) Then
            TfrxMemoView(frxRel.FindObject('memVALORDPAGPIX')).Memo.Text  := FormatFloat(',0.00', LValorPix);

          If Assigned(frxRel.FindObject('memPORCHEAVI')) Then
            TfrxMemoView(frxRel.FindObject('memPORCHEAVI')).Memo.Text  := 'PORTADOR: ' + strPorAvi + '-' + fRetNomPortador(strPorAvi);
          If Assigned(frxRel.FindObject('memVALCHEAVI')) Then
            TfrxMemoView(frxRel.FindObject('memVALCHEAVI')).Memo.Text  := FormatFloat(',0.00', fltValAvi);

          If Assigned(frxRel.FindObject('memPORCHEPRE')) Then
            TfrxMemoView(frxRel.FindObject('memPORCHEPRE')).Memo.Text  := 'PORTADOR: ' + strPorPre + '-' + fRetNomPortador(strPorPre);
          If Assigned(frxRel.FindObject('memVALCHEPRE')) Then
            TfrxMemoView(frxRel.FindObject('memVALCHEPRE')).Memo.Text  := FormatFloat(',0.00', fltValPre);

          If Assigned(frxRel.FindObject('memPORCARCRE')) Then
            TfrxMemoView(frxRel.FindObject('memPORCARCRE')).Memo.Text  := 'PORTADOR: ' + strPorCre + '-' + fRetNomPortador(strPorCre);
          If Assigned(frxRel.FindObject('memVALCARCRE')) Then
            TfrxMemoView(frxRel.FindObject('memVALCARCRE')).Memo.Text  := FormatFloat(',0.00', fltValCre);

          If Assigned(frxRel.FindObject('memPORFIN')) Then
            TfrxMemoView(frxRel.FindObject('memPORFIN')).Memo.Text  := 'PORTADOR: ' + strPorFin + '-' + fRetNomPortador(strPorFin);
          If Assigned(frxRel.FindObject('memVALFIN')) Then
            TfrxMemoView(frxRel.FindObject('memVALFIN')).Memo.Text  := FormatFloat(',0.00', fltValFin);

          If Assigned(frxRel.FindObject('mmRegistrosImpressos')) Then
          begin
            LRegistrosImpressos := 0;

            If Assigned(frxRel.FindObject('ChildDinheiro')) And  TfrxChild(frxRel.FindObject('ChildDinheiro')).Visible Then
              Inc(LRegistrosImpressos);

            If Assigned(frxRel.FindObject('ChildOrdemPagto')) And  TfrxChild(frxRel.FindObject('ChildOrdemPagto')).Visible Then
              Inc(LRegistrosImpressos);

            If Assigned(frxRel.FindObject('ChildFinanc')) And  TfrxChild(frxRel.FindObject('ChildFinanc')).Visible Then
              Inc(LRegistrosImpressos);

            If Assigned(frxRel.FindObject('ChildOrdemPagtoPix')) And TfrxChild(frxRel.FindObject('ChildOrdemPagtoPix')).Visible Then
              Inc(LRegistrosImpressos);

            If Assigned(frxRel.FindObject('ChildCarCre')) And TfrxChild(frxRel.FindObject('ChildCarCre')).Visible And (qryCarCre.RecordCount > 0) Then
              Inc(LRegistrosImpressos, qryCarCre.RecordCount)
            Else If Assigned(frxRel.FindObject('ChildCarCreCabec')) And TfrxChild(frxRel.FindObject('ChildCarCreCabec')).Visible Then
              Inc(LRegistrosImpressos);

            If Assigned(frxRel.FindObject('ChildCheAvi')) And TfrxChild(frxRel.FindObject('ChildCheAvi')).Visible And (qryCheAvi.RecordCount > 0) Then
              Inc(LRegistrosImpressos, qryCheAvi.RecordCount)
            Else If Assigned(frxRel.FindObject('ChildCheAviCabec')) And TfrxChild(frxRel.FindObject('ChildCheAviCabec')).Visible Then
              Inc(LRegistrosImpressos);

            If Assigned(frxRel.FindObject('ChildChePre')) And TfrxChild(frxRel.FindObject('ChildChePre')).Visible And (qryChePre.RecordCount > 0)  Then
              Inc(LRegistrosImpressos, qryChePre.RecordCount)
            Else If Assigned(frxRel.FindObject('ChildChePreCabec')) And TfrxChild(frxRel.FindObject('ChildChePreCabec')).Visible Then
              Inc(LRegistrosImpressos);

            TfrxMemoView(frxRel.FindObject('mmRegistrosImpressos')).Memo.Text := 'REGISTROS IMPRESSOS: ' + IntToStr(LRegistrosImpressos);
          end;

        End
        Else
        Begin
          frxRel.Script.Variables['CAIXA'] := '';
          If Not strCodigoCaixa.IsEmpty Then
            frxRel.Script.Variables['CAIXA'] := 'Caixa: ' + strCodigoCaixa + '-' + fCampoTabela('CAX_DESCRI', 'CADCAX',  ['CAX_CODCAX', 'CAX_CODEMP'], [strCodigoCaixa, qryImpress.FieldByName('RCX_CODEMP').AsString]);

          frxRel.Script.Variables['NOMREL']    := 'COMPROVANTE DE TRANSFERENCIA DE CAIXA';

          if Not fEmptyStr(strOpeTransf) then
          begin
            frxRel.Script.Variables['OPERADOR'] := strOpeTransf + '-' + fRetNomeOperador(strOpeTransf);
          end
          else
          begin
            frxRel.Script.Variables['OPERADOR']  := qryImpress.FieldByName('RTF_CODOPE').AsString + '-' + fRetNomeOperador(qryImpress.FieldByName('RTF_CODOPE').AsString);
          end;

          frxRel.Script.Variables['DTADOC']    := qryImpress.FieldByName('RCX_DTACAD').AsDateTime;
          frxRel.Script.Variables['HORDOC']    := qryImpress.FieldByName('RCX_HORCAD').AsDateTime;
          frxRel.Script.Variables['SEQCON']    := qryImpress.FieldByName('RCX_SEQCON').AsInteger;

          frxRel.Script.Variables['EMPRESA']   := strCodEmp  + '-' + fRetNomeEmpresa(strCodEmp);
          frxRel.Script.Variables['NOMROD']    := '';

          frxRel.Script.Variables['PORDINHEI'] := 'PORTADOR: ' + strPorDin + '-' + fRetNomPortador(strPorDin);
          frxRel.Script.Variables['VALDINHEI'] := fltValDin;

          frxRel.Script.Variables['PORORDPAG'] := 'PORTADOR: ' + strPorOrd + '-' + fRetNomPortador(strPorOrd);
          frxRel.Script.Variables['VALORDPAG'] := fltValOrd;

          frxRel.Script.Variables['VALORDPAGPIX'] := LValorPix;

          frxRel.Script.Variables['PORCHEAVI'] := 'PORTADOR: ' + strPorAvi + '-' + fRetNomPortador(strPorAvi);
          frxRel.Script.Variables['VALCHEAVI'] := fltValAvi;

          frxRel.Script.Variables['PORCHEPRE'] := 'PORTADOR: ' + strPorPre + '-' + fRetNomPortador(strPorPre);
          frxRel.Script.Variables['VALCHEPRE'] := fltValPre;

          frxRel.Script.Variables['PORCARCRE'] := 'PORTADOR: ' + strPorCre + '-' + fRetNomPortador(strPorCre);
          frxRel.Script.Variables['VALCARCRE'] := fltValCre;

          frxRel.Script.Variables['PORFIN'] := 'PORTADOR: ' + strPorFin + '-' + fRetNomPortador(strPorFin);
          frxRel.Script.Variables['VALFIN'] := fltValFin;

          frxRel.Script.Variables['TRANSFERENCIA_FECHAMENTO'] := EmptyStr;
          If Not qryImpress.FieldByName('RCX_IDEFEC').AsString.IsEmpty Then
            frxRel.Script.Variables['TRANSFERENCIA_FECHAMENTO'] := 'DE FECHAMENTO ';
        End;

      End;

      if strTipoImpressao = 'I' then
      begin
        If (Not fEmptyStr(strNomeFila)) Then
        Begin
          frxRel.PrintOptions.Printer   := AnsiReplaceStr(strNomeFila,'\\' + fRetNomeRede + '\','');
          frxRel.PreviewOptions.Buttons := [pbPrint,pbExport,pbZoom,pbFind,pbOutline,pbPageSetup,pbTools,pbNavigator];
          frxRel.PrintOptions.ShowDialog := False;
        End
        Else
          frxRel.PrintOptions.ShowDialog := True;
      end;

      if strTipoImpressao = 'I' then
      begin
        If frxRel.PrepareReport Then
        Begin
          For intCont := 0 To intQtdImp - 1 Do
            pPrintReport('frmRcxResumoCaixaTRANSFERENCIA', 'Resumo de caixa (Transferência)', strNomeFila, frxRel);
        End;
      end
      else
        pPreviewReport('frmRcxResumoCaixaTRANSFERENCIA', 'Resumo de caixa (Transferência)', frxRel);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[pImprimeConfTranf]');
      End;
    End;


    If blnReimpressao Then
    Begin
      FreeAndNil(qryCheAvi);
      FreeAndNil(qryChePre);
      FreeAndNil(qryCarCre);
    End;

  Finally
    pFreeAndNil(frmQckRcxCompTransf);
    FreeAndNil(qryImpress);
    FreeAndNil(qryCfgRel);
    FreeAndNil(qryDadosEmp);
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

procedure pImprimeTransferenciaPar(strSeqRcx: String; intQtdImp: Integer;
                                   strPorGua, strPorDol, strPorEur, strPorPes, strPorRea, strPorOrd, strPorAvi,
                                   strPorPre, strPorCre, strPorFin: String;
                                   fltValGua, fltValDol, fltValEur, fltValPes, fltValRea, fltValOrd, fltValAvi,
                                   fltValPre, fltValCre, fltValFin: Double;
                                   cdsCheAvi, cdsChePre, cdsCarCre: TUniClientDataSet;
                                   blnLisChe, blnLisCar, blnReimpressao: Boolean;
                                   strRecibo: String; orderBy: Integer=0);
  Var
    strNomeFila: String;
    strTipImp  : String;
    intCont    : Integer;
    frxRel     : TfrxReport;
    qryImpress,
    qryCheAvi,
    qryChePre,
    qryCarCre,
    qryCfgRel: TUniQuery;

    Procedure pAbreCheAvi(intSeqCom: Integer);
    Begin
      qryCheAvi := fCriaQuery;
      With qryCheAvi Do
      Begin
        SQL.Text := fCarregaCheques(False, orderBy);
        ParamByName('CODEMP').AsString  := strCodEmp;
        ParamByName('SEQCON').AsInteger := intSeqCom;
        Open;
      End;
    End;

    Procedure pAbreChePre(intSeqCom: Integer);
    Begin
      qryChePre := fCriaQuery;
      With qryChePre Do
      Begin
        SQL.Text := fCarregaCheques(True,orderBy);
        ParamByName('CODEMP').AsString  := strCodEmp;
        ParamByName('SEQCON').AsInteger := intSeqCom;
        Open;
      End;
    End;

    Procedure pAbreCarCre(intSeqCom: Integer);
    Begin
      qryCarCre := fCriaQuery;
      With qryCarCre Do
      Begin
        SQL.Text := StringReplace(fCarregaCartoes(orderBy), ':CODEMPIN', fRetStrToSQLIn(strCodEmp), [rfReplaceAll]);
        ParamByName('SEQCON').AsInteger := intSeqCom;
        Open;
      End;
    End;

    Procedure pAbreTabelas;
    Begin

      pAbreCheAvi(qryImpress.FieldByName('RCX_SEQCON').AsInteger);

      pAbreChePre(qryImpress.FieldByName('RCX_SEQCON').AsInteger);

      pAbreCarCre(qryImpress.FieldByName('RCX_SEQCON').AsInteger);

      TfrmRcxReimpTransfer.pLeMovBan(fltValGua, strPorGua, 'TF CAIXA (GUA)', qryImpress.FieldByName('RCX_SEQCON').AsInteger, qryImpress.FieldByName('RCX_DTACAD').AsDateTime, qryImpress.FieldByName('RCX_CODEMP').AsString);
      TfrmRcxReimpTransfer.pLeMovBan(fltValDol, strPorDol, 'TF CAIXA (DOL)', qryImpress.FieldByName('RCX_SEQCON').AsInteger, qryImpress.FieldByName('RCX_DTACAD').AsDateTime, qryImpress.FieldByName('RCX_CODEMP').AsString);
      TfrmRcxReimpTransfer.pLeMovBan(fltValEur, strPorEur, 'TF CAIXA (EUR)', qryImpress.FieldByName('RCX_SEQCON').AsInteger, qryImpress.FieldByName('RCX_DTACAD').AsDateTime, qryImpress.FieldByName('RCX_CODEMP').AsString);
      TfrmRcxReimpTransfer.pLeMovBan(fltValPes, strPorPes, 'TF CAIXA (PES)', qryImpress.FieldByName('RCX_SEQCON').AsInteger, qryImpress.FieldByName('RCX_DTACAD').AsDateTime, qryImpress.FieldByName('RCX_CODEMP').AsString);
      TfrmRcxReimpTransfer.pLeMovBan(fltValRea, strPorRea, 'TF CAIXA (REA)', qryImpress.FieldByName('RCX_SEQCON').AsInteger, qryImpress.FieldByName('RCX_DTACAD').AsDateTime, qryImpress.FieldByName('RCX_CODEMP').AsString);
      TfrmRcxReimpTransfer.pLeMovBan(fltValAvi, strPorAvi, 'TF CAIXA (CHV)', qryImpress.FieldByName('RCX_SEQCON').AsInteger, qryImpress.FieldByName('RCX_DTACAD').AsDateTime, qryImpress.FieldByName('RCX_CODEMP').AsString);
      TfrmRcxReimpTransfer.pLeMovBan(fltValPre, strPorPre, 'TF CAIXA (CHP)', qryImpress.FieldByName('RCX_SEQCON').AsInteger, qryImpress.FieldByName('RCX_DTACAD').AsDateTime, qryImpress.FieldByName('RCX_CODEMP').AsString);
      TfrmRcxReimpTransfer.pLeMovBan(fltValCre, strPorCre, 'TF CAIXA (CAR)', qryImpress.FieldByName('RCX_SEQCON').AsInteger, qryImpress.FieldByName('RCX_DTACAD').AsDateTime, qryImpress.FieldByName('RCX_CODEMP').AsString);
      TfrmRcxReimpTransfer.pLeMovBan(fltValOrd, strPorOrd, 'TF CAIXA (OP) ', qryImpress.FieldByName('RCX_SEQCON').AsInteger, qryImpress.FieldByName('RCX_DTACAD').AsDateTime, qryImpress.FieldByName('RCX_CODEMP').AsString);
      TfrmRcxReimpTransfer.pLeMovBan(fltValFin, strPorFin, 'TF CAIXA (FIN)', qryImpress.FieldByName('RCX_SEQCON').AsInteger, qryImpress.FieldByName('RCX_DTACAD').AsDateTime, qryImpress.FieldByName('RCX_CODEMP').AsString);
    End;

begin

  Try
    qryImpress := fCriaQuery;
    qryCfgRel := fCriaQuery;

    With qryImpress Do
    Begin
      SQL.Add(' SELECT                                                  ');
      SQL.Add('   RCX_SEQCON,                                           ');
      SQL.Add('   RCX_DTACAD,                                           ');
      SQL.Add('   RCX_HORCAD,                                           ');
      SQL.Add('   RCX_CODOPE,                                           ');
      SQL.Add('   RTF_RECIBO                                            ');
      SQL.Add(' FROM                                                    ');
      SQL.Add('   CADRCXX                                               ');
      SQL.Add('   INNER JOIN CADRTF ON RTF_SEQRCX = CADRCXX.AUTOINCREM  ');
      SQL.Add(' WHERE                                                   ');
      SQL.Add('   CADRCXX.AUTOINCREM = :SEQRCX                          ');

      ParamByName('SEQRCX').AsString := strSeqRcx;
      Open;

      Try
        pCarregaConfImpr(qryCfgRel, 'frmRcxResumoCaixaTRANSFERENCIA');
        fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False);
        pCriarFormularios(TfrmQckRcxCompTransf,frmQckRcxCompTransf);

        frmQckRcxCompTransf.strCodOpe := FieldByName('RCX_CODOPE').AsString;
        frmQckRcxCompTransf.strNomOpe := fRetNomeOperador(FieldByName('RCX_CODOPE').AsString);
        frmQckRcxCompTransf.intSeqCon := FieldByName('RCX_SEQCON').AsInteger;

        If Not fEmptyStr(strRecibo) Then
          frmQckRcxCompTransf.strDados  := strRecibo
        Else
          frmQckRcxCompTransf.strDados  := FieldByName('RTF_RECIBO').AsString;

        frmQckRcxCompTransf.dtaDatCad := FieldByName('RCX_DTACAD').AsDateTime;
        frmQckRcxCompTransf.horHorCad := FieldByName('RCX_HORCAD').AsDateTime;

        If fCfgSis('COLTRF') = '1' Then
        Begin

          If SameText(strTipImp, 'M') Then
            frxRel := frmQckRcxCompTransf.frxQckRcxCompTransf40Col_M
          Else
            frxRel := frmQckRcxCompTransf.frxQckRcxCompTransf40Col_J;

          For intCont := 1 To fCfgSis('QTDSAL', varInteger) Do
            If SameText(strTipImp, 'M') Then
              TfrxDMPMemoView(frxRel.FindObject('rllSalto')).Lines.Add('')
            Else
              TfrxMemoView(frxRel.FindObject('rllSalto')).Lines.Add('');

        End Else
        Begin
          frmQckRcxCompTransf.frxDotMatrixExport.PageBreaks := True;

          If SameText(strTipImp, 'M') Then
            frxRel := frmQckRcxCompTransf.frxReport80M
          Else
          Begin
            frxRel := frmQckRcxCompTransf.frxReport80J;
            TfrxMemoView(frxRel.FindObject('mmoZebraAvi')).Highlight.Color := fCfgSis('CORZEB');
            TfrxMemoView(frxRel.FindObject('mmoZebraPre')).Highlight.Color := fCfgSis('CORZEB');
            TfrxMemoView(frxRel.FindObject('mmoZebraCre')).Highlight.Color := fCfgSis('CORZEB');
          End;

          If blnReimpressao Then
          Begin
            pAbreTabelas;

            frmQckRcxCompTransf.frxDBCheAvi.DataSet := qryCheAvi;
            frmQckRcxCompTransf.frxDBChePre.DataSet := qryChePre;
            frmQckRcxCompTransf.frxDBCarCre.DataSet := qryCarCre;
          End Else
          Begin

            If (fltValAvi > 0) And (cdsCheAvi.Active) Then
            Begin
              frmQckRcxCompTransf.frxDBCheAvi.DataSet := cdsCheAvi;
              cdsCheAvi.First;
            End Else
            Begin
              pAbreCheAvi(-1);
              frmQckRcxCompTransf.frxDBCheAvi.DataSet := qryCheAvi;
            End;

            If (fltValPre > 0) And (cdsChePre.Active) Then
            Begin
              frmQckRcxCompTransf.frxDBChePre.DataSet := cdsChePre;
              cdsChePre.First;
            End Else
            Begin
              pAbreChePre(-1);
              frmQckRcxCompTransf.frxDBChePre.DataSet := qryChePre;
            End;

            If (fltValCre > 0) And (cdsCarCre.Active) Then
            Begin
              frmQckRcxCompTransf.frxDBCarCre.DataSet := cdsCarCre;
              cdsCarCre.First;
            End Else
            Begin
              pAbreCarCre(-1);
              frmQckRcxCompTransf.frxDBCarCre.DataSet := qryCarCre;
            End;

          End;

          //TfrxChild(frxRel.FindObject('ChildDinheiro')).Visible    := fltValDin > 0;
          TfrxChild(frxRel.FindObject('ChildCheAviCabec')).Visible := fltValAvi > 0;
          TfrxChild(frxRel.FindObject('ChildCheAvi')).Visible      := blnLisChe And (fltValAvi > 0);
          TfrxChild(frxRel.FindObject('ChildChePreCabec')).Visible := fltValPre > 0;
          TfrxChild(frxRel.FindObject('ChildChePre')).Visible      := blnLisChe And (fltValPre > 0);
          TfrxChild(frxRel.FindObject('ChildCarCreCabec')).Visible := fltValCre > 0;
          TfrxChild(frxRel.FindObject('ChildCarCre')).Visible      := blnLisCar And (fltValCre > 0);
          TfrxChild(frxRel.FindObject('ChildOrdemPagto')).Visible  := (fltValOrd > 0);
          TfrxChild(frxRel.FindObject('ChildFinanc')).Visible      := fltValFin > 0;

          frxRel.Script.Variables['NOMREL']    := 'COMPROVANTE DE TRANSFERENCIA DE CAIXA';
          frxRel.Script.Variables['OPERADOR']  := FieldByName('RCX_CODOPE').AsString + '-' + fRetNomeOperador(FieldByName('RCX_CODOPE').AsString);
          frxRel.Script.Variables['DTADOC']    := FieldByName('RCX_DTACAD').AsDateTime;
          frxRel.Script.Variables['HORDOC']    := FieldByName('RCX_HORCAD').AsDateTime;
          frxRel.Script.Variables['SEQCON']    := FieldByName('RCX_SEQCON').AsInteger;

          frxRel.Script.Variables['EMPRESA']   := strCodEmp + '-' + fRetNomeEmpresa(strCodEmp);
          frxRel.Script.Variables['NOMROD']    := '';

          //frxRel.Script.Variables['PORDINHEI'] := 'PORTADOR: ' + strPorDin + '-' + fRetNomPortador(strPorDin);
          //frxRel.Script.Variables['VALDINHEI'] := fltValDin;

          frxRel.Script.Variables['PORORDPAG'] := 'PORTADOR: ' + strPorOrd + '-' + fRetNomPortador(strPorOrd);
          frxRel.Script.Variables['VALORDPAG'] := fltValOrd;

          frxRel.Script.Variables['PORCHEAVI'] := 'PORTADOR: ' + strPorAvi + '-' + fRetNomPortador(strPorAvi);
          frxRel.Script.Variables['VALCHEAVI'] := fltValAvi;

          frxRel.Script.Variables['PORCHEPRE'] := 'PORTADOR: ' + strPorPre + '-' + fRetNomPortador(strPorPre);
          frxRel.Script.Variables['VALCHEPRE'] := fltValPre;

          frxRel.Script.Variables['PORCARCRE'] := 'PORTADOR: ' + strPorCre + '-' + fRetNomPortador(strPorCre);
          frxRel.Script.Variables['VALCARCRE'] := fltValCre;

          frxRel.Script.Variables['PORFIN'] := 'PORTADOR: ' + strPorFin + '-' + fRetNomPortador(strPorFin);
          frxRel.Script.Variables['VALFIN'] := fltValFin;

        End;

        If (Not fEmptyStr(strNomeFila)) Then
        Begin
          frxRel.PrintOptions.Printer   := AnsiReplaceStr(strNomeFila,'\\' + fRetNomeRede + '\','');
          frxRel.PreviewOptions.Buttons := [pbPrint,pbExport,pbZoom,pbFind,pbOutline,pbPageSetup,pbTools,pbNavigator];
          frxRel.PrintOptions.ShowDialog := False;
        End
        Else
          frxRel.PrintOptions.ShowDialog := True;

        If frxRel.PrepareReport Then
        Begin
          For intCont := 0 To intQtdImp - 1 Do
            pPrintReport('frmRcxResumoCaixaTRANSFERENCIA', 'Recibo de Transferência', strNomeFila, frxRel);
        End;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[pImprimeConfTranf]');
        End;
      End;

    End;

    If blnReimpressao Then
    Begin
      FreeAndNil(qryCheAvi);
      FreeAndNil(qryChePre);
      FreeAndNil(qryCarCre);
    End;

  Finally
    pFreeAndNil(frmQckRcxCompTransf);
    FreeAndNil(qryImpress);
    FreeAndNil(qryCfgRel);
  End;

End;

procedure TfrmRcxReimpTransfer.FormCreate(Sender: TObject);
begin
  inherited;
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryRegistros := fCriaQuery(Self);
  dtsRegistros := TDataSource.Create(Self);
  dtsRegistros.DataSet := qryRegistros;
  dbgDocumentos.DataSource := dtsRegistros;
  pCarregaEmpresa;

end;

procedure TfrmRcxReimpTransfer.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) And ((ActiveControl) = dbgDocumentos) Then
    pLimpaTela;
end;

procedure TfrmRcxReimpTransfer.FormShow(Sender: TObject);
begin
  inherited;
  blnLiberado := fVerificaAcessoSistema('RECTRE');

  shpEmp.Brush.Color  := clRed;

  If (Not blnLiberado) Then
    edtCodEmp.Enabled := False
  Else
    shpEmp.Brush.Color  := clGreen;
end;

procedure TfrmRcxReimpTransfer.btnConsultarClick(Sender: TObject);
begin
  inherited;
    If fEmptyStr(edtSequencialTransf.Text)Then
    Begin
      if not fValidaCampos(mskDtaIni, false) then
        exit;
      if not fValidaCampos(mskDtaFin, false) then
        exit;
      if fVerificaCampos then
      begin
        fCarregaTransferencias;
        if not qryRegistros.IsEmpty then
          pSetFocus(dbgDocumentos);
      end;
   End
   Else
   Begin
    fCarregaTransferencias;
    if not qryRegistros.IsEmpty then
          pSetFocus(dbgDocumentos);
   End;
end;

procedure TfrmRcxReimpTransfer.btnImprimirClick(Sender: TObject);
begin

  inherited;

    //Case rdgOrdenacao.ItemIndex Of
    //0:  i:=0;
    //1:  orderByCheques:=1;
    //End;

  if not qryRegistros.Active Then
  begin
    fMensagem('', 'É necessário selecionar ao menos um registro!', ['&OK']);
    Exit;
  end;

  If (qryRegistros.IsEmpty) then
  begin
    fMensagem('', 'É necessário selecionar ao menos um registro!', ['&OK']);
    Exit;
  end;

  If (fMensagem('', 'Confirma ' + IIF(edtDestino.Text = 'I', 'Impressão', 'Visualização') + '?', ['','']) = 1) Then
  Begin
    pImprimeTransferencia(qryRegistros.FieldByName('RCX_SEQCON').AsInteger,
                          qryRegistros.FieldByName('RCX_CODEMP').AsString,
                          qryRegistros.FieldByName('RCX_DTACAD').AsDateTime,
                          fCfgSis('QTDVTR'),
                          '',
                          '',
                          '',
                          '',
                          '',
                          '',
                          0,
                          0,
                          0,
                          0,
                          0,
                          0,
                          Nil,
                          Nil,
                          Nil,
                          True,
                          True,
                          True,
                          '',
                          '',
                          edtDestino.Text,
                          qryRegistros.FieldByName('RCX_CODCAX').AsString,
                          rdgOrdenacao.ItemIndex);
  End;

end;

procedure TfrmRcxReimpTransfer.dbgDocumentosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Return Then
    btnImprimir.Click;
end;

procedure TfrmRcxReimpTransfer.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtCodEmp, true);
end;

procedure TfrmRcxReimpTransfer.edtCodEmpKeyPress(Sender: TObject;
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

procedure TfrmRcxReimpTransfer.edtDestinoExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtDestino, true);
end;

procedure TfrmRcxReimpTransfer.edtSequencialTransfExit(Sender: TObject);
begin
  inherited;
   If (Not fEmptyStr(edtSequencialTransf.Text)) Then
  Begin
    edtCodEmp.Enabled := False;
    mskDtaIni.Enabled := False;
    mskDtaFin.Enabled := False;
    mskDtaIni.Clear;
    mskDtaFin.Clear;
    edtNomEmp.Clear;
    pSetFocus(btnConsultar);
  End
  Else
  Begin
    edtCodEmp.Enabled := True;
    mskDtaIni.Enabled := True;
    mskDtaFin.Enabled := True;
    pSetFocus(edtCodEmp);
  End;
end;

function fLoadReport(strTipImp: String): Boolean;
 Var
   mmsLoad: TStream;
   FLayImp: TUniQuery;
Begin
  Result := False;
  FLayImp:= fCriaQuery(nil);
  Try
    With FLayImp, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT * FROM ');
      Add('  LAYIMP');
      Add('WHERE');
      Add('  LAY_TIPLAY = :TIPLAY AND  ');
      Add('  LAY_CODEMP = :CODEMP AND  ');
      Add('  LAY_CODLAY = :CODLAY      ');

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('CODLAY').AsString := 'CMPTF'+IntToStr(fCfgSis('COLTRF', varInteger));

      If(strTipImp = 'M') Then
        ParamByName('TIPLAY').AsString := 'M'
      Else
        ParamByName('TIPLAY').AsString := 'L';

      Add('ORDER BY');
      Add('  LAY_DTAALT DESC,');
      Add('  LAY_HORALT DESC ');
      Add('LIMIT 1');
      Open;

      If Not IsEmpty Then
      Begin
        Result := True;
        mmsLoad := CreateBlobStream(FieldByName('LAY_RELFR3'), bmRead);
        If fCfgSis('COLTRF', varInteger) = 1 Then
        Begin
          If (strTipImp = 'M') Then
          Begin
            frmQckRcxCompTransf.frxQckRcxCompTransf40Col_M.LoadFromStream(mmsLoad);
            frmQckRcxCompTransf.frxQckRcxCompTransf40Col_M.Variables.Clear;
          End
          Else
          Begin
            frmQckRcxCompTransf.frxQckRcxCompTransf40Col_J.LoadFromStream(mmsLoad);
            frmQckRcxCompTransf.frxQckRcxCompTransf40Col_J.Variables.Clear;
          End;
        End
        Else If fCfgSis('COLTRF', varInteger) = 2 Then
        Begin
          If (strTipImp = 'M') Then
          Begin
            frmQckRcxCompTransf.frxReport80M.LoadFromStream(mmsLoad);
            frmQckRcxCompTransf.frxReport80M.Variables.Clear;
          End
          Else
          Begin
            frmQckRcxCompTransf.frxReport80J.LoadFromStream(mmsLoad);
            frmQckRcxCompTransf.frxReport80J.Variables.Clear;
          End;;
        End;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fLoadReport]');
    End;
  End;
  FreeAndNil(mmsLoad);
  FreeAndNil(FLayImp);
End;

end.
