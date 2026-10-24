unit untRelCtpTitDeletados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, Uni,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus, QColorLabel,
  ExtCtrls, BitBtnLockedIncrem, Buttons, Mask, MaskEditFocus, StrUtils,
  frxExportCSVTestabilidade, untTypesSistema, untIFuncoes,
  untGeraExcel, Data.DB, untExcel;

type
  TfrmRelCtpTitDeletados = class(TfrmPaiRelatorio)
    Label5: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label7: TLabel;
    Label6: TLabel;
    mskDtaFin: TMaskEditFocus;
    Label8: TLabel;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    gpbOrdem: TGroupBox;
    ColorLabel5: TColorLabel;
    edtOrdem: TEditFocus;
    chkLisCtaRec: TCheckBox;
    mskCompet: TMaskEditFocus;
    Label1: TLabel;
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    qryRelatorio: TUniQuery;

		procedure pCriaQryRelatorio;
    function fGeraExcel: Boolean;
    procedure pOnMontaResumo(Excel: TExcel; Campos: TCampos;
      Quebra: TRecQuebras);
    procedure pOnSomaReumo(var Totais: TTotais; Dados: TDataSet);

    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmRelCtpTitDeletados: TfrmRelCtpTitDeletados;

implementation

uses  untFuncoesFactory, untModuloRelCtpTitDeletados;

{$R *.dfm}

{ TfrmRelCtpTitDeletados }

procedure TfrmRelCtpTitDeletados.btnImprimirClick(Sender: TObject);
  Var
    strSQL      : String;
    blnTbCaixa  : Boolean;
    qryGenDel   : TUniQuery;

begin
  inherited;

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;
  Application.ProcessMessages;

  qryGenDel := fCriaQuery(Self);

  blnTbCaixa := False;

  If blnImprime Then
  Begin
    if fTabelaExiste('DEL_CADPAG') then blnTbCaixa := true;

    If blnTbCaixa Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE        ';
      strSQL := strSQL + '  "DELC" AS TAB,           ';
      strSQL := strSQL + '  D.DTADEL,                ';
      strSQL := strSQL + '  D.HORDEL,                ';
      strSQL := strSQL + '  D.OPEDEL,                ';
      strSQL := strSQL + '  D.AUTOINCREM,            ';
      strSQL := strSQL + '  D.CTP_NOMFRM,            ';
      strSQL := strSQL + '  D.CTP_DTAVEN,            ';
      strSQL := strSQL + '  CONCAT(D.CTP_NUMDUP, D.CTP_PARCEL) AS NUMDUP, ';
      strSQL := strSQL + '  D.CTP_CODEMP,            ';
      strSQL := strSQL + '  D.CTP_CODFOR,            ';
      strSQL := strSQL + '  REPLACE(CTP_HIST01, "<<csq>>", " ") AS CTP_HIST01, ';
      strSQL := strSQL + '  D.CTP_DTACAD,            ';
      strSQL := strSQL + '  D.CTP_VALDUP,            ';
      strSQL := strSQL + '  FOR_NOMFOR               ';
      strSQL := strSQL + 'FROM                       ';
      strSQL := strSQL + '  DEL_CADPAG D,            ';
      strSQL := strSQL + '  CADFOR                   ';
      strSQL := strSQL + 'WHERE                      ';
      strSQL := strSQL + '  D.DTADEL BETWEEN :DTAINI AND :DTAFIN AND ';
      strSQL := strSQL + '  FOR_CODFOR = D.CTP_CODFOR                ';

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        strSQL := strSQL + '  AND D.CTP_CODEMP = :CODEMP '
      Else
        strSQL := strSQL + '  AND LOCATE(D.CTP_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

      If (chkLisCtaRec.Checked) Then

        strSQL := strSQL + ' AND D.CTP_NOMFRM = :NOMFRM ';

    {**************************}
    {* FILTRO POR COMPETÊNCIA *}
    {************************BB}
      if not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
        strSQL := strSQL + '  AND D.CTP_COMPET = :COMPET ';

      strSQL := strSQL + 'ORDER BY       ';

      If edtOrdem.Text = 'D' Then
        strSQL := strSQL + '  DTADEL, HORDEL '
      Else
        strSQL := strSQL + '  CTP_NUMDUP, CTP_CODEMP ';

      With qryRelatorio Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

        If Not fEmptyStr(edtCodEmpresa.Text) Then
          ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

        if not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
          ParamByName('COMPET').AsString := mskCompet.Text;

        If (chkLisCtaRec.Checked) Then
          ParamByName('NOMFRM').AsString := 'frmCadCtaPagar';

        Open;
      End;

      If Not qryRelatorio.IsEmpty Then
      Begin
        if edtDestino.Text <> 'E' then
        Begin
          Try
            frmModuloRelCtpTitDeletados := TfrmModuloRelCtpTitDeletados.Create(Self);

            With frmModuloRelCtpTitDeletados Do
            Begin
              frxRelatorio.DataSet := qryRelatorio;

              If strTipImp = 'M' Then
                frxRelCtpDel := frxTitDel_M
              Else
              Begin
                frxRelCtpDel                           := frxTitDel_J;
                frxRelCtpDel.DotMatrixReport           := False;
//                frxRelCtpDel.PrintOptions.PrintMode    := pmScale;
//                frxRelCtpDel.PrintOptions.PrintOnSheet := 9; //A4
                TfrxMemoView(frxRelCtpDel.FindObject('rllZebra')).Highlight.Color := fCfgSis('CORZEB');
              End;

              frxRelCtpDel.Script.Variables['NOMEMP'] := fRetNomeEmpresaSelec(VS_strCodEmp);
              frxRelCtpDel.Script.Variables['TITULO'] := 'RELATORIO DE TITULOS DELETADOS ';
              frxRelCtpDel.Script.Variables['PERIODO']:= 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;
              frxRelCtpDel.Script.Variables['DTAHOR'] := 'EMITIDO EM ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', fNow());

              If Not fEmptyStr(edtCodEmpresa.Text) Then
                frxRelCtpDel.Script.Variables['EMPRESA'] := 'EMPRESA: ' + edtCodEmpresa.Text + '-' + edtDesEmpresa.Text
              Else
                frxRelCtpDel.Script.Variables['EMPRESA'] := 'EMPRESA: TODAS';

              frxRelCtpDel.Script.Variables['NOMREL'] := Self.Name;

              if fEmptyDate(mskCompet.Text) then
                frxRelCtpDel.Script.Variables['COMPET'] := 'TODOS'
              Else
                frxRelCtpDel.Script.Variables['COMPET'] := mskCompet.Text;

              frxRelCtpDel.Script.Variables['LISMAN'] := IfThen(chkLisCtaRec.Checked, 'SIM', 'NÃO');

              if edtOrdem.Text = 'D' then
                frxRelCtpDel.Script.Variables['ORDENA'] := 'DATA/HORA DA DELEÇÃO'
              Else
                frxRelCtpDel.Script.Variables['ORDENA'] := 'NÚMERO DE DUPLICATA';

              If edtDestino.Text = 'V' Then
                frxRelCtpDel.ShowReport
              Else If frxRelCtpDel.PrepareReport Then
                frxRelCtpDel.Print;

            End;
          Except
            On E: Exception Do
            Begin
              pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
            End;
          End;

          FreeAndNil(frmModuloRelCtpTitDeletados);
        End
        Else
          fGeraExcel;
      End
      Else
      Begin
        pTabelaVazia;
      End;
    End
    Else
    Begin
      pTabelaVazia;
    End;

    pSetFocus(mskDtaIni);

  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption     := '';

  FreeAndNil(qryGenDel);

end;

procedure TfrmRelCtpTitDeletados.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtCodEmpresa.Text) Then
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text)
  Else
    edtDesEmpresa.Text := 'TODAS';
end;

procedure TfrmRelCtpTitDeletados.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp : TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtpTitDeletados.FormCreate(Sender: TObject);
begin
  inherited;
  blnExcel := True;
end;

procedure TfrmRelCtpTitDeletados.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelCtpTitDeletados.FormShow(Sender: TObject);
begin
  inherited;
  pCriaQryRelatorio;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  inherited;

  pSetFocus(mskDtaIni);

end;

function TfrmRelCtpTitDeletados.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    {*********************}
    {* VALIDA DATAS      *}
    {******************LU*}
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
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
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

    Else If (Sender = edtCodEmpresa) Then
    Begin

      If Not fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End
      Else
        edtDesEmpresa.Text := 'TODAS';

    End
    Else If (Sender = edtOrdem) Then
    Begin

      If Pos(edtOrdem.Text, 'D_N') <= 0 Then
      Begin
        fMensagem('', 'O campo Ordenar por deve ser D ou N!', ['&O k']);
        Result := False;
      End;

    End;


    if (Sender = mskCompet) then
    Begin

      if not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
      begin

        If not fValidaDataStr('01/'+ mskCompet.Text) Then
        Begin
          pMensagemOk('Data informada na Competência não é válida!');
          Result := False;
        End;

      end;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelCtpTitDeletados.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

procedure TfrmRelCtpTitDeletados.pOnSomaReumo(Var Totais: TTotais; Dados: TDataSet);
Begin
  Totais['CTP_VALDUP'] := Totais['CTP_VALDUP'] + Dados.FieldByName('CTP_VALDUP').AsFloat;
End;

procedure TfrmRelCtpTitDeletados.pOnMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
begin
  With Excel Do
  Begin
    ProximaLinha;

    Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_DTACAD'].Coluna , 'TOTAL:');
    FormatoNumerico(LinhaAtual, Campos.ColunaPorNome['CTP_VALDUP'].Coluna);
    Alinhamento(LinhaAtual, Campos.ColunaPorNome['CTP_VALDUP'].Coluna, Direita);
    Escrever(LinhaAtual, Campos.ColunaPorNome['CTP_VALDUP'].Coluna, Quebra.Totais.Campo['CTP_VALDUP']);

    Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
    CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Verde_Mar);
    CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Branco);
    Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
  End;

end;

function TfrmRelCtpTitDeletados.fGeraExcel: Boolean;
  Var
    objExcel : TGeraExcel;
begin
  objExcel := TGeraExcel.Create(qryRelatorio, Nil);
  Try
    With objExcel Do
    Begin
      strNomRel := 'RELATORIO DE TITULOS DELETADOS';

      AddFiltro('REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text);

      if fEmptyDate(mskCompet.Text) then
        AddFiltro('COMPETENCIA: TODOS')
      Else
        AddFiltro('COMPETENCIA: ' + mskCompet.Text);

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        AddFiltro('EMPRESA: ' + edtCodEmpresa.Text + '-' + edtDesEmpresa.Text)
      Else
        AddFiltro('EMPRESA: TODAS');

      AddFiltro('LISTAR SOMENTE AS DELETADAS PELA MANUTENÇÃO DO CONTAS A RECEBER: '+ IfThen(chkLisCtaRec.Checked, 'SIM', 'NÃO'));

      if edtOrdem.Text = 'D' then
        AddFiltro('ORDENAR POR: DATA/HORA DA DELEÇÃO')
      Else
       AddFiltro('ORDENAR POR: NÚMERO DE DUPLICATA');

      AddCampo('DTADEL','DATA DEL.');
      AddCampo('HORDEL','HORA DEL.');
      AddCampo('OPEDEL','OPERADOR');
      AddCampo('CTP_DTAVEN','DATA VENC.');
      AddCampo('NUMDUP','DUPLICATA');
      AddCampo('CTP_CODEMP','EMPRESA');
      AddCampo('CTP_CODFOR','CÓD. FORNECEDOR');
      AddCampo('FOR_NOMFOR','FORNECEDOR');
      AddCampo('CTP_DTACAD','DATA CAD.');
      AddCampo('CTP_VALDUP','VALOR');
      AddCampo('CTP_HIST01','HISTÓRICO');
      AddCampo('CTP_NOMFRM','ORIGEM');

      AddTotais('CTP_VALDUP');

      OnSomaResumo  := pOnSomaReumo;
      OnMontaResumo := pOnMontaResumo;

      Result := fGerarRelatorio;

      if Result then
        fMensagem('','Arquivo Gerado com Sucesso!', ['&OK']);

    End;
  Finally
    FreeAndNil(objExcel);
  End;
end;

end.
