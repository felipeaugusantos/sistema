unit untGeraArqSerasa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Mask, MaskEditFocus, AppEvnts,
  Menus, Buttons, ExtCtrls, Uni, QColorLabel, BitBtnLockedIncrem, untTypesSistema,
  frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,DateUtils, CxProgressBar;

type
  TfrmGeraArqSerasa = class(TfrmPai)
    pnlFundo: TPanel;
    lblDtaFin: TLabel;
    lblDtaIni: TLabel;
    pnlTopo: TPanel;
    mskDtaIni1: TMaskEditFocus;
    mskDtaFin1: TMaskEditFocus;
    edtCodEmp: TEditFocus;
    lblCodEmp: TLabel;
    edtNomEmp: TEditFocus;
    edtEspDoc: TEditFocus;
    Label1: TLabel;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    Label2: TLabel;
    btnGerar: TBitBtnLocked;
    rdgTipDta: TRadioGroup;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    qryCadEmp: TUniQuery;
    qryCadPor: TUniQuery;
    qryArqSer: TUniQuery;

    procedure pCarregaCadEmp;
    procedure pCarregaCadPor;

    function fInsereTemporaria(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fClienteDesde(strCnpjCpf: String): TDateTime;
  public
    { Public declarations }
    intOpcao : Integer;
    strNomAdm: String;

    procedure pGeraDupSerasa;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmGeraArqSerasa: TfrmGeraArqSerasa;

implementation

uses untFuncoesSimples, untConsultas,
   DB, untGeraArqSerasaSel, StrUtils, untGravando;

{$R *.dfm}

procedure TfrmGeraArqSerasa.FormShow(Sender: TObject);
begin
  inherited;
  mskDtaIni.Text  := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text  := FormatDateTime('dd/mm/yyyy',VS_Date);
  pSetFocus(mskDtaIni);
end;

function TfrmGeraArqSerasa.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := true;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
      If(StrToDate(mskDtaIni.Text) < IncYear(VS_Date, -1)) And Not(ActiveControl.Name = btnGerar.Name) And mskDtaIni.Focused Then
      Begin
        Result := fMensagem('', 'Data inferior a ' + DateToStr(IncYear(VS_Date, -1)) + ' (1 ano). Deseja continuar?',
        ['&Sim', '&Não']) = 1;
      End;

      If(StrToDate(mskDtaFin.Text) < IncYear(VS_Date, -1)) And Not(ActiveControl.Name = btnGerar.Name) And mskDtaFin.Focused Then
      Begin
        Result := fMensagem('', 'Data inferior a ' + DateToStr(IncYear(VS_Date, -1)) + ' (1 ano). Deseja continuar?',
        ['&Sim', '&Não']) = 1;
      End;
      If (Sender = mskDtaIni) then
      begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
            fMensagem('','O período não deve ficar em branco!',['&O K'])
          Else
            fMensagem('','A data inicial deve ser preenchida!',['&O K']);
          Result := False;
        End
        Else
        If not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
           if strtodate(mskdtafin.text) < strtodate(mskdtaini.text) then
           begin
              fMensagem('','A data Final não pode ser menor que a data Inicial!',['&O K']);
              Result := False;
           end;
        End;
      End
      Else
      If (Sender = mskDtaFin) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('','A data final deve ser preenchida!',['&O K']);
          Result := False;
        End;
      End
      Else If (Sender = edtCodPor) Then
      begin
        If Not fEmptyStr(edtCodPor.Text) Then
        begin
          pCarregaCadPor;
          If Not CarregaPortador(edtCodPor.Text) Then
             Result := False
          Else
          If (qryCadPor.IsEmpty) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&Ok']);
            Result := False;
          End
          {*REQ*145940**********RP*}
          Else If Not fEmptyStr(edtCodEmp.Text) And Not fEmpresaTemAcessoPortador(edtCodPor.Text, edtCodEmp.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End;
        end;
      end;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmGeraArqSerasa.pGeraDupSerasa;
Var
  strSQL: String;
  frmGravando : TfrmGravando;
begin

  If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Or
     (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
  Begin
    fMensagem('','Data inicial e data final devem ser informadas!', ['&Ok']);
    pSetFocus(mskDtaIni);
    Exit;
  End;
  {********************************}
  {* SELECT PUXANDO AS INFORMACOES*}
  {* DE CADREC DE ACORDO COM      *}
  {* O FILTRO INFORMADO PELO      *}
  {* USUARIO                      *}
  {*****************************PH*}
  strSQL := '';
  strSQL := strSQL + 'SELECT                                           ';
  strSQL := strSQL + '  CTR_NUMDUP,                                    ';
  strSQL := strSQL + '  CTR_PARCEL,                                    ';
  strSQL := strSQL + '  CTR_ESPDOC,                                    ';
  strSQL := strSQL + '  CTR_DTACAD,                                    ';
  strSQL := strSQL + '  CTR_DTAREC,                                    ';
  strSQL := strSQL + '  CAST(IF(IFNULL(CTR_DTAREC, "") = "", CTR_DTACAD, CTR_DTAREC) AS DATE) AS DTAREF,';
  strSQL := strSQL + '  CTR_VALORI AS CTR_VALDUP,                      ';
  strSQL := strSQL + '  CTR_CODEMP,                                    ';
  strSQL := strSQL + '  CTR_CODCLI,                                    ';
  strSQL := strSQL + '  CLI_NOMCLI,                                    ';
  strSQL := strSQL + '  CTR_CODPOR,                                    ';
  strSQL := strSQL + '  POR_NOMPOR,                                    ';
  strSQL := strSQL + '  CTR_NOSNUM,                                    ';
  strSQL := strSQL + '  CTR_HIST01,                                    ';
  strSQL := strSQL + '  CTR_HIST02,                                    ';
  strSQL := strSQL + '  CTR_OBSAG1,                                    ';
  strSQL := strSQL + '  CTR_OBSAG2,                                    ';
  strSQL := strSQL + '  CTR_OBSAG3,                                    ';
  strSQL := strSQL + '  CTR_CODVEL,                                    ';
  strSQL := strSQL + '  CTR_DTAVEN,                                    ';
  strSQL := strSQL + '  "D" AS CTR_MARCAD,                             ';
  strSQL := strSQL + '  "N" AS CTR_PROTES,                             ';
  strSQL := strSQL + '  CTR_DTASER,                                    ';
  strSQL := strSQL + '  CTR_SEQBAI,                                    ';
  strSQL := strSQL + '  CLI_CGCCPF,                                    ';
  strSQL := strSQL + '  REPLACE(REPLACE(REPLACE(CLI_C_G_C_, ".", ""), "/", ""), "-", "") AS CLI_C_G_C_, ';
  strSQL := strSQL + '  CLI_DTACAD,                                    ';
  strSQL := strSQL + '  CLI_STATUS,                                    ';
  strSQL := strSQL + '  "NÃO" AS CTR_CANCEL,                           ';
  strSQL := strSQL + '  IF(DET_DOCDEV IS NULL, "NÃO", "SIM") AS DET_DEVOLV, ';
  strSQL := strSQL + '  IF(DET_DOCDEV IS NULL, NULL, DET_DTAENT) AS DET_DTADEV ';
  strSQL := strSQL + 'FROM                                             ';
  strSQL := strSQL + '  CADREC ';
  strSQL := strSQL + '  JOIN CADCLI ON (CTR_CODCLI = CLI_CODCLI)        ';
  strSQL := strSQL + '  LEFT JOIN CADPOR ON (CTR_CODPOR = POR_CODPOR)   ';
  strSQL := strSQL + '  LEFT JOIN MOVDET ON CTR_CODCLI = DET_CODCLI AND ';
  strSQL := strSQL + '       CTR_NUMDUP = DET_DOCDEV AND                ';
  strSQL := strSQL + '       CTR_ESPDOC = DET_ESPDEV AND                ';
  strSQL := strSQL + '       CTR_CODEMP = DET_EMPDEV                    ';
  strSQL := strSQL + '  LEFT JOIN CADCBI ON                             ';
  strSQL := strSQL + '       CTR_NUMDUP = CBI_NUMDUP AND                ';
  strSQL := strSQL + '       CTR_PARCEL = CBI_PARCEL AND                ';
  strSQL := strSQL + '       CTR_ESPDOC = CBI_ESPDOC AND                ';
  strSQL := strSQL + '       CTR_CODEMP = CBI_CODEMP AND                ';
  strSQL := strSQL + '       CTR_CODCLI = CBI_CODCLI AND                ';
  strSQL := strSQL + '       CBI_CODBCO = "'+ LeftStr(strNomAdm, 3) + '" ';
  strSQL := strSQL + 'WHERE                                             ';

  If rdgTipDta.ItemIndex = 0 Then
    strSQL := strSQL + '  IF(IFNULL(CTR_DTAREC, "") = "", CTR_DTACAD, CTR_DTAREC) BETWEEN :DTAINI AND :DTAFIM  '
  Else
    strSQL := strSQL + '  CTR_DTAVEN BETWEEN :DTAINI AND :DTAFIM  ';

  If (intOpcao = 1) Then
  Begin
    If strNomAdm = 'BOA VISTA' Then
    Begin
      strSQL := strSQL + ' AND ((CTR_DTABOA IS NULL AND CTR_DTAREC IS NULL AND CBI_CODBCO IS NULL) ';
      strSQL := strSQL + ' OR   (CTR_DTAREC IS NOT NULL AND CTR_DTABO2 IS NULL AND CBI_CODBCO IS NULL)) ';
    End
    Else
    Begin
      strSQL := strSQL + ' AND ((CTR_DTASER IS NULL AND CTR_DTAREC IS NULL AND CBI_CODBCO IS NULL) ';
      strSQL := strSQL + ' OR   (CTR_DTAREC IS NOT NULL AND CTR_DTASER IS NOT NULL AND CTR_DTASE2 IS NULL AND CBI_CODBCO IS NULL)) ';
    End;
  End
  Else
  Begin
    If strNomAdm = 'BOA VISTA' Then
      strSQL := strSQL + ' AND ((CTR_DTABOA IS NOT NULL OR CTR_DTABO2 IS NOT NULL) AND CTR_BOAEXC IS NULL AND CBI_CODBCO IS NULL) '
    Else
      strSQL := strSQL + ' AND (CTR_DTASER IS NOT NULL AND CTR_SEREXC IS NULL AND CBI_CODBCO IS NULL) ';
  End;

  strSQL := strSQL + ' AND CLI_CGCCPF = 1                              ';
  strSQL := strSQL + ' AND CTR_SEQBAI = 0                              ';

  //Não mostrar os créditos
  strSQL := strSQL + ' AND CTR_VALORI > 0                              ';

  If Trim(edtCodEmp.Text) <> '' Then
    strSQL := strSQL + ' AND CTR_CODEMP = :CODEMP                      ';

  If Trim(edtEspDoc.Text) <> '' Then
    strSQL := strSQL + ' AND CTR_ESPDOC = :ESPDOC                      ';

  If Trim(edtCodPor.Text) <> '' Then
    strSQL := strSQL + ' AND CTR_CODPOR = :CODPOR                      ';

  If intOpcao = 2 Then
  Begin
    If strNomAdm = 'BOA VISTA' Then
      strSQL := strSQL + ' UNION ALL ' +  AnsiReplaceStr(AnsiReplaceStr(strSQL, 'CADREC', 'DEL_CADREC'),'"NÃO" AS CTR_CANCEL', '"SIM" AS CTR_CANCEL')
    Else
      strSQL := strSQL + ' AND DET_DOCDEV IS NOT NULL UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(strSQL, 'CADREC', 'DEL_CADREC'),'"NÃO" AS CTR_CANCEL', '"SIM" AS CTR_CANCEL');
  End;

  strSQL := 'SELECT * FROM (' + strSQL + ') AS TAB GROUP BY CTR_NUMDUP, CTR_PARCEL, CTR_ESPDOC, CTR_CODEMP, CTR_CODCLI ';

  {*************************************************************}
  {* CRIA TABELA TEMPORARIA COM O RESULTADO PARA MELHOR OPERAR *}
  {**********************************************************PH*}

  With qryArqSer Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('CREATE TEMPORARY TABLE TMP_GERSER ' + strSQL + ' AND FALSE');
    ExecSQL;

    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIM').AsDate := StrToDate(mskDtaFin.Text);

    If Trim(edtCodEmp.Text) <> '' Then
      ParamByName('CODEMP').AsString := edtCodEmp.Text;

    If Trim(edtEspDoc.Text) <> '' Then
      ParamByName('ESPDOC').AsString := edtEspDoc.Text;

    If (Not fEmptyStr(edtCodPor.Text)) Then
      ParamByName('CODPOR').AsString := edtCodPor.Text;

    Open;

    Try
      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.fExecutarAcao := fInsereTemporaria;
      frmGravando.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;

    pFreeAndNil(frmGravando);

    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM TMP_GERSER ORDER BY CTR_DTAVEN');
    Open;

    (FieldByName('CTR_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';

    If Not IsEmpty Then
    Begin
      Try
        pCriarFormularios(TfrmGeraArqSerasaSel, frmGeraArqSerasaSel);
        frmGeraArqSerasaSel.intOpcao       := intOpcao;
        frmGeraArqSerasaSel.qryArqSer      := qryArqSer;
        frmGeraArqSerasaSel.dtaDtaIni      := StrToDate(mskDtaIni.Text);
        frmGeraArqSerasaSel.dtaDtaFin      := StrToDate(mskDtaFin.Text);
        frmGeraArqSerasaSel.strCodBco      := Copy(strNomAdm, 1, 3);
        frmGeraArqSerasaSel.pnlTopo.Caption := 'Seleção de registros para o ' + strNomAdm;
        frmGeraArqSerasaSel.ShowModal;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, 'TfrmGeraArqSerasa.pGeraDupSerasa');
      End;
      pFreeAndNil(frmGeraArqSerasaSel);
    End
    Else
      fMensagem('','Não há duplicatas para serem enviadas!', ['&OK']);

  End;
end;

procedure TfrmGeraArqSerasa.btnGerarClick(Sender: TObject);
begin
  inherited;

  intOpcao := fMensagem(Application.Title,'Selecione INCLUSÃO para enviar ao ' + strNomAdm + ' duplicatas para cobrança/liquidação ou EXCLUSÃO para informar ao ' + strNomAdm + ' duplicatas que  devem ser canceladas.',['Inclusão','Exclusão']);

  if not fValidaCampos(mskDtaIni) then
    Exit;

  if not fValidaCampos(mskDtaFin) then
    Exit;

  If Not fVerificaCampos Then
    Exit;

  If fTabelaExiste('TMP_GERSER') Then
    fDropTable('TMP_GERSER');


  {***********************************************************}
  {* DESABILITA O BOTÃO PARA O USUARIO NÃO CLICAR DUAS VEZES *}
  {********************************************************PH*}

  btnGerar.Enabled := False;
  pGeraDupSerasa;
  btnGerar.Enabled := True;
end;


procedure TfrmGeraArqSerasa.edtCodEmpKeyPress(Sender: TObject;
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
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGeraArqSerasa.edtCodEmpExit(Sender: TObject);
begin
  inherited;

  If (fEmptyStr(edtCodEmp.Text)) Then
  Begin
    edtNomEmp.Text := 'TODAS';
  End
  Else
  Begin
    pCarregaCadEmp;
    If (qryCadEmp.IsEmpty) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
      pSetFocus(edtCodEmp);
    End;
  End;

end;

procedure TfrmGeraArqSerasa.pCarregaCadEmp;
begin
  qryCadEmp.SQL.Clear;
  qryCadEmp.SQL.Add('SELECT * FROM CADEMP WHERE EMP_CODEMP = :CODEMP');
  qryCadEmp.ParamByName('CODEMP').AsString := edtCodEmp.Text;
  qryCadEmp.Open;

  edtNomEmp.Text := qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
end;

procedure TfrmGeraArqSerasa.pCarregaCadPor;
begin
  qryCadPor.SQL.Clear;
  qryCadPor.SQL.Add('SELECT * FROM CADPOR WHERE POR_CODPOR = :CODPOR');
  qryCadPor.ParamByName('CODPOR').AsString := edtCodPor.Text;
  qryCadPor.Open;

  edtDesPor.Text := qryCadPor.FieldByName('POR_NOMPOR').AsString;
end;

procedure TfrmGeraArqSerasa.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadEmp := fCriaQuery(Self);
  qryCadPor := fCriaQuery(Self);
  qryArqSer := fCriaQuery(Self);

  strNomAdm := 'SERASA';
end;

procedure TfrmGeraArqSerasa.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryCadEmp);
  FreeAndNil(qryCadPor);
  FreeAndNil(qryArqSer);
end;

procedure TfrmGeraArqSerasa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If ActiveControl Is TRadioButton Then
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmGeraArqSerasa.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
End;

procedure TfrmGeraArqSerasa.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples,
                     Self,
                     edtCodPor,
                     TEditFocus(edtDesPor),
                     nil,
                     Key,
                     arrSel,
                     True,
                     'Consulta de Portadores',
                     '',
                     False,
                     False,
                     '',
                     False,
                     True) then
    Begin
      if fValidaCampos(edtCodPor) then
        Self.SelectNext((Sender As TWinControl), True, True);
    End;
  End;
end;

function TfrmGeraArqSerasa.fClienteDesde(strCnpjCpf: String): TDateTime;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;

  Result := 0;

  Try
    qryAux.SQL.Add('SELECT MIN(CLI_DTACAD) DTACAD FROM CADCLI WHERE CLI_C_G_C_ = :_C_G_C_');
    qryAux.ParamByName('_C_G_C_').AsString := strCnpjCpf;
    qryAux.Open;

    If qryAux.FieldByName('DTACAD').AsDateTime > 0 Then
      Result := qryAux.FieldByName('DTACAD').AsDateTime;

  Finally
    FreeAndNil(qryAux);
  End;

end;

function TfrmGeraArqSerasa.fInsereTemporaria(pgbStatus: TcxProgressBar = Nil): Boolean;
var
  qryArqTmp: TUniQuery;

  function fInsertTemporaria: String;
  Begin
    Result := 'INSERT INTO TMP_GERSER (CTR_NUMDUP, CTR_PARCEL, CTR_ESPDOC, CTR_DTACAD, CTR_DTAREC, ';
    Result := Result + '   DTAREF, CTR_VALDUP, CTR_CODEMP, CTR_CODCLI, CLI_NOMCLI, CTR_CODPOR, ';
    Result := Result + '   POR_NOMPOR, CTR_NOSNUM, CTR_HIST01, CTR_HIST02, CTR_OBSAG1, ';
    Result := Result + '   CTR_OBSAG2, CTR_OBSAG3, CTR_CODVEL, CTR_DTAVEN, CTR_MARCAD, ';
    Result := Result + '   CTR_PROTES, CTR_DTASER, CTR_SEQBAI, CLI_CGCCPF, CLI_C_G_C_, ';
    Result := Result + '   CLI_DTACAD, CLI_STATUS, CTR_CANCEL, DET_DEVOLV, DET_DTADEV)  ';
    Result := Result + '   VALUES ';
    Result := Result + '   (:NUMDUP, :PARCEL, :ESPDOC, :DTACAD, :DTAREC, :DTAREF, :VALDUP, ';
    Result := Result + '    :CODEMP, :CODCLI, :NOMCLI, :CODPOR, :NOMPOR, :NOSNUM, :HIST01, ';
    Result := Result + '    :HIST02, :OBSAG1, :OBSAG2, :OBSAG3, :CODVEL, :DTAVEN, :MARCAD, ';
    Result := Result + '    :PROTES, :DTASER, :SEQBAI, :CGCCPF, :C_G_C_, :DTACAC, :STATUS, ';
    Result := Result + '    :CANCEL, :DEVOLV, :DTADEV) ';
  End;

  procedure pAdicionaRegistroTemporaria;
  Begin
    With qryArqTmp Do
    Begin
      Close;
      ParamByName('NUMDUP').AsString  := qryArqSer.FieldByName('CTR_NUMDUP').AsString;
      ParamByName('PARCEL').AsString  := qryArqSer.FieldByName('CTR_PARCEL').AsString;
      ParamByName('ESPDOC').AsString  := qryArqSer.FieldByName('CTR_ESPDOC').AsString;
      ParamByName('DTACAD').Value     := qryArqSer.FieldByName('CTR_DTACAD').Value;
      ParamByName('DTAREC').Value     := qryArqSer.FieldByName('CTR_DTAREC').Value;
      ParamByName('DTAREF').Value     := qryArqSer.FieldByName('DTAREF').Value;
      ParamByName('VALDUP').AsFloat   := qryArqSer.FieldByName('CTR_VALDUP').AsFloat;
      ParamByName('CODEMP').AsString  := qryArqSer.FieldByName('CTR_CODEMP').AsString;
      ParamByName('CODCLI').AsString  := qryArqSer.FieldByName('CTR_CODCLI').AsString;
      ParamByName('NOMCLI').AsString  := qryArqSer.FieldByName('CLI_NOMCLI').AsString;
      ParamByName('CODPOR').AsString  := qryArqSer.FieldByName('CTR_CODPOR').AsString;
      ParamByName('NOMPOR').AsString  := qryArqSer.FieldByName('POR_NOMPOR').AsString;
      ParamByName('NOSNUM').Value     := qryArqSer.FieldByName('CTR_NOSNUM').Value;
      ParamByName('HIST01').AsString  := qryArqSer.FieldByName('CTR_HIST01').AsString;
      ParamByName('HIST02').AsString  := qryArqSer.FieldByName('CTR_HIST02').AsString;
      ParamByName('OBSAG1').Value     := qryArqSer.FieldByName('CTR_OBSAG1').Value;
      ParamByName('OBSAG2').Value     := qryArqSer.FieldByName('CTR_OBSAG2').Value;
      ParamByName('OBSAG3').Value     := qryArqSer.FieldByName('CTR_OBSAG3').Value;
      ParamByName('CODVEL').Value     := qryArqSer.FieldByName('CTR_CODVEL').Value;
      ParamByName('DTAVEN').Value     := qryArqSer.FieldByName('CTR_DTAVEN').Value;
      ParamByName('MARCAD').AsString  := qryArqSer.FieldByName('CTR_MARCAD').AsString;
      ParamByName('PROTES').AsString  := qryArqSer.FieldByName('CTR_PROTES').AsString;
      ParamByName('DTASER').Value     := qryArqSer.FieldByName('CTR_DTASER').Value;
      ParamByName('SEQBAI').AsInteger := qryArqSer.FieldByName('CTR_SEQBAI').AsInteger;
      ParamByName('CGCCPF').AsInteger := qryArqSer.FieldByName('CLI_CGCCPF').AsInteger;
      ParamByName('C_G_C_').AsString  := qryArqSer.FieldByName('CLI_C_G_C_').AsString;
      ParamByName('DTACAC').Value     := fClienteDesde(qryArqSer.FieldByName('CLI_C_G_C_').AsString);
      ParamByName('STATUS').AsString  := qryArqSer.FieldByName('CLI_STATUS').AsString;
      ParamByName('CANCEL').AsString  := qryArqSer.FieldByName('CTR_CANCEL').AsString;
      ParamByName('DEVOLV').AsString  := qryArqSer.FieldByName('DET_DEVOLV').AsString;
      ParamByName('DTADEV').Value     := qryArqSer.FieldByName('DET_DTADEV').Value;
      ExecSQL;
    End;
  End;

  procedure pStepStatusGravacao;
  Begin
    If Assigned(pgbStatus) Then
    Begin
      pgbStatus.Position := pgbStatus.Position + 1;
      Application.ProcessMessages;
    End;
  End;

begin
  qryArqTmp := fCriaQuery(Self);

  Result := True;

  Try

    qryArqTmp.SQL.Clear;
    qryArqTmp.SQL.Add(fInsertTemporaria);
    qryArqSer.DisableControls;
    qryArqSer.First;

    pInfoStatusGravacao(pgbStatus, 'Aguarde, Buscando duplicatas...', qryArqSer.RecordCount);

    While Not qryArqSer.EOF Do
    Begin
      pAdicionaRegistroTemporaria;
      pStepStatusGravacao;
      qryArqSer.Next;
    End;

    qryArqSer.First;
    qryArqSer.EnableControls;

  Except
    On E:Exception Do
    Begin
      Result := False;
      fMensagem('','Ocorreu um erro ao tentar gravar os dados!' + #13#10 + E.Message,['&O K']);
    End;
  End;

  FreeAndNil(qryArqTmp);
end;

End.

