unit untFatFormulacaoGeneric;

interface

uses
  Windows, SysUtils, Classes, Variants, untPaiSimples, DBGridCitel, DBGrids,
  StdCtrls, Controls, ExtCtrls, {QTypes,} Forms,
  DB,  Uni, untFuncoesSimples, untTypesSistema,
  BitBtnLockedIncrem, untIFatFormulacao,  Grids, AppEvnts, Menus, ComCtrls, Buttons,
  frxClass, frxExportCSVTestabilidade, untTipoTinta;

const
  cnstEspTinDet: String = 'NF_IF_PA_EP_FF_UC_';

type
  TfrmFatFormulacaoGeneric = class(TfrmPaiSimples)
    pnlCentral: TPanel;
    dbgFormulacao: TDBGridCitel;
    pnlBotoesFor: TPanel;
    btnCancelarForm: TBitBtnLocked;
    btnImprimir: TBitBtnLocked;
    mmoBase: TMemo;
    lblTipoFormulacao: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgFormulacaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelarFormClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    qryFormul: TUniQuery;
    dtsFormul: TDataSource;
    ftiDadosEtiq: TFormulEtiq;
    fatFormulacao: IFatFormulacao;
    blnPulsos: Boolean;
    procedure pCriaTemporaria;
    procedure pDeletaTemporaria;
    procedure pAtualizaTemporaria;

    procedure pMostraFormulacoes;
    procedure pCarregaEmbalagemAutomotiva(qryGen: TUniQuery; strCfgExi: String);
    function fTintasQuantidadePulsos: Boolean;
  public
    { Public declarations }
    strAutInc: String;
    strDescri: String;
    strEspDoc: String;
    constructor Create(AOwner: TComponent; const fatFormulacao: IFatFormulacao); reintroduce;
  end;

var
  frmFatFormulacaoGeneric: TfrmFatFormulacaoGeneric;

implementation

uses untConstantes, StrUtils, untFuncTinta, untCfgRel, TypesRel, untFuncoesEtiquetas;

{$R *.dfm}

{ TfrmFatFormulacaoGeneric }

procedure TfrmFatFormulacaoGeneric.pAtualizaTemporaria;
  Var
    strSQL: String;
begin

  If (Not fTabelaExiste(fatFormulacao.GetNomeTabelaFormulacao)) Then
    pCriaTemporaria;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ' + fatFormulacao.GetNomeTabelaFormulacao + ' ';

  With qryFormul Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;
end;

procedure TfrmFatFormulacaoGeneric.pCarregaEmbalagemAutomotiva(
  qryGen: TUniQuery; strCfgExi: String);
var
  qryBase: TUniQuery;
begin
  Try
    qryBase := fCriaQuery;
    With qryBase Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT ITE_CODITE, ');
      SQL.Add('        ITE_DESITE  ');

      If ((Pos(strCfgExi, 'O_OR_PD_OP_OD_PE_DP_AD_') > 0) Or (strCfgExi = 'VP')) And (Pos(strEspDoc, cnstEspTinDet) <= 0) Then
      Begin
        SQL.Add(' FROM FATDOR ');
        SQL.Add(' LEFT JOIN CADITE ON ITE_CODITE = FDO_ITEEMB ');
        SQL.Add('WHERE  ');
        SQL.Add('      FDO_NUMDOC = :NUMDOC AND ');
        SQL.Add('      FDO_ESPDOC = :ESPDOC AND ');
        SQL.Add('      FDO_CODEMP = :CODEMP AND ');
        SQL.Add('      FDO_CODCLI = :CODCLI AND ');
        SQL.Add('      FDO_CODITE = :CODITE AND ');
        SQL.Add('      FDO_CODACA = :CODACA AND ');
        SQL.Add('      FDO_EMPACA = :EMPACA ');

        ParamByName('NUMDOC').AsString := qryGen.FieldByName('FDO_NUMDOC').AsString;
        ParamByName('ESPDOC').AsString := qryGen.FieldByName('FDO_ESPDOC').AsString;
        ParamByName('CODEMP').AsString := qryGen.FieldByName('FDO_CODEMP').AsString;
        ParamByName('CODCLI').AsString := qryGen.FieldByName('FDO_CODCLI').AsString;
        ParamByName('CODITE').AsString := qryGen.FieldByName('FDO_CODITE').AsString;
        ParamByName('CODACA').AsString := qryGen.FieldByName('FDO_CODACA').AsString;
        ParamByName('EMPACA').AsString := qryGen.FieldByName('FDO_EMPACA').AsString;
      End
      Else
      Begin
        SQL.Add(' FROM MOVDET ');
        SQL.Add(' LEFT JOIN CADITE ON ITE_CODITE = DET_ITEEMB ');
        SQL.Add('WHERE ');
        SQL.Add('      DET_NUMDOC = :NUMDOC AND ');
        SQL.Add('      DET_ESPDOC = :ESPDOC AND ');
        SQL.Add('      DET_CODEMP = :CODEMP AND ');
        SQL.Add('      DET_CODCLI = :CODCLI AND ');
        SQL.Add('      DET_CODITE = :CODITE AND ');
        SQL.Add('      DET_CODACA = :CODACA AND ');
        SQL.Add('      DET_EMPACA = :EMPACA ');

        ParamByName('NUMDOC').AsString := qryGen.FieldByName('DET_NUMDOC').AsString;
        ParamByName('ESPDOC').AsString := qryGen.FieldByName('DET_ESPDOC').AsString;
        ParamByName('CODEMP').AsString := qryGen.FieldByName('DET_CODEMP').AsString;
        ParamByName('CODCLI').AsString := qryGen.FieldByName('DET_CODCLI').AsString;
        ParamByName('CODITE').AsString := qryGen.FieldByName('DET_CODITE').AsString;
        ParamByName('CODACA').AsString := qryGen.FieldByName('DET_CODACA').AsString;
        ParamByName('EMPACA').AsString := qryGen.FieldByName('DET_EMPACA').AsString;
      End;

      Open;

      mmoBase.Clear;

      If IsEmpty Then
        mmoBase.Text := 'VENDA SEM EMBALAGEM'
      Else
        mmoBase.Text := 'EMBALAGEM: ' + FieldByName('ITE_CODITE').AsString + ' - ' + FieldByName('ITE_DESITE').AsString;

      If Not fEmptyStr(strDescri) Then
        mmoBase.Text := mmoBase.Text + #13#10 + 'COR: ' +strDescri;
    End;
  Finally
    FreeAndNil(qryBase);
  End;
end;

procedure TfrmFatFormulacaoGeneric.pCriaTemporaria;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'CREATE TEMPORARY TABLE ' + fatFormulacao.GetNomeTabelaFormulacao + ' (';
  strSQL := strSQL + '  TMP_CODITE VARCHAR(10),  ';
  strSQL := strSQL + '  TMP_FORMUL VARCHAR(50),  ';
  strSQL := strSQL + '  TMP_DESCRI VARCHAR(255), ';
  strSQL := strSQL + '  TMP_QTDBAS VARCHAR(30) ) ';

  With qryFormul Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;
end;

procedure TfrmFatFormulacaoGeneric.pDeletaTemporaria;
  Var
    strSQL: String;
begin

  If fTabelaExiste(fatFormulacao.GetNomeTabelaFormulacao) Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'DROP TABLE ' + fatFormulacao.GetNomeTabelaFormulacao + ' ';

    With qryFormul Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;
  End;
end;

procedure TfrmFatFormulacaoGeneric.pMostraFormulacoes;
var
  strSQL: String;
  strFormul: String;
  strCfgExi: String;
  fltQtdBas: Double;
  intContador: Integer;
  qryGen: TUniQuery;

  strCodIte,
  strCodColRet,
  strDesCol,
  strDescri: string;

  intPulsos: Integer;
  intUniOpr: Integer;

  function fDescricaoColorante(strCodCol: String): String;
  begin
    Result := '';

    pRetItemEDescricaoColorante(fatFormulacao.GetIdePro, strCodCol, strCodIte, strCodColRet, strDesCol, VS_strCodEmp);

    If (Not fEmptyStr(strDesCol)) Then
    Begin
      Result := strDesCol;
    End;
  end;

begin
  qryGen := nil;
  Try
    Try

      blnPulsos := fCfgSis('PULMLS') = '1';
      intPulsos := fCfgSis('PULMLS', varInteger);
      lblTipoFormulacao.Caption := IIF(blnPulsos,'Formulação em Pulsos',IIF(intPulsos = 2,'Formulação em MLs','Formulação em Onças'));

      intUniOpr := fGetConfTinta(fatFormulacao.GetIdePro).fGetInteger('UNIOPR'); // A tinta tem a própria configuração

      if (intUniOpr > 0) then
        lblTipoFormulacao.Caption := IIF(intUniOpr = 1,'Formulação em Pulsos',IIF(intUniOpr = 2,'Formulação em MLs','Formulação em Onças'));

      if ((intPulsos = 1) Or (intUniOpr = 1)) then
      begin
        if (Not fTintasQuantidadePulsos) And (fTipoTinta(fatFormulacao.GetIdePro) = ttImobiliaria) then
          lblTipoFormulacao.Caption := 'Formulação em Mls';
      end;

      if fTipoTinta(fatFormulacao.GetIdePro) = ttAutomotiva then
      begin
        lblTipoFormulacao.Caption := 'Formulação em Gramas';
        dbgFormulacao.Columns[1].Title.Caption := 'Base';
      end
      else
        dbgFormulacao.Columns[1].Title.Caption := 'Colorante';

      If ((FatFormulacao.GetIdePro = 'INT') And (intUniOpr = 1)) Then
        lblTipoFormulacao.Caption := 'Formulação em Pulsos'
      Else If ((FatFormulacao.GetIdePro = 'INT') And (intUniOpr = 2)) Then
        lblTipoFormulacao.Caption := 'Formulação em MLs'
      Else If ((FatFormulacao.GetIdePro = 'INT') And (intUniOpr = 3)) Then
        lblTipoFormulacao.Caption := 'Formulação em Onças';


      strCfgExi := fCfgSis('EXIDOC');
      qryGen := fCriaQuery(Nil);
      pAtualizaTemporaria;

      strSQL := '';
      strSQL := strSQL + ' SELECT         ';
      strSQL := strSQL + '   DET_NUMDOC   ';
      strSQL := strSQL + '   , DET_ESPDOC ';
      strSQL := strSQL + '   , DET_CODEMP ';
      strSQL := strSQL + '   , DET_CODCLI ';
      strSQL := strSQL + '   , DET_CODITE ';
      strSQL := strSQL + '   , DET_CODACA ';
      strSQL := strSQL + '   , DET_EMPACA ';
      strSQL := strSQL + '   , DET_IDEPRO ';
      strSQL := strSQL + '   , DET_DESCRI ';
      strSQL := strSQL + '   , DET_TIPPRE ';
      strSQL := strSQL + '   , DET_DTAENT ';
      strSQL := strSQL + '   , DET_HORENT ';
      strSQL := strSQL + '   , DET_MONTAD ';
      strSQL := strSQL + '   , DET_A_N_O_ ';
      strSQL := strSQL + '   , IF(DET_QTDEMB > DET_QTDITE, DET_QTDITE, IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE)) AS DET_QTDEMB ';
      strSQL := strSQL + '   , IF(DET_QTDEMB > DET_QTDITE, DET_QTDITE, IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE)) AS QTD ';

      strSQL := strSQL + '   , CLI_NOMCLI ';
      strSQL := strSQL + '   , CLI_ENDERE ';
      strSQL := strSQL + '   , CLI_ENDNUM ';
      strSQL := strSQL + '   , CLI_BAIRRO ';
      strSQL := strSQL + '   , CID_NOMCID ';
      strSQL := strSQL + '   , CID_ESTADO ';
      strSQL := strSQL + '   , CLI_C_E_P_ ';
      strSQL := strSQL + '   , CLI_FONE01 ';
      strSQL := strSQL + '   , CLI_FONE02 ';
      strSQL := strSQL + '   , CONCAT(DET_NUMDOC,"-",DET_ESPDOC,"-",DET_CODEMP) AS DOCUME ';

      for intContador := 1 to fatFormulacao.GetQtdCampos do
      begin
        strSQL := strSQL + '   , DET_FORM' + fStrZero(intContador, 2) + ' ';
        strSQL := strSQL + '   , DET_QTDB' + fStrZero(intContador, 2) + ' / IF(DET_QTDEMB > DET_QTDITE, DET_QTDITE, IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE)) AS DET_QTDB' + fStrZero(intContador, 2) + ' ';
      end;

      strSQL := strSQL + 'FROM ';

      {******************}
      {*SE FOR ORÇAMENTO*}
      {***************PZ*}
      If ((Pos(strCfgExi, 'O_OR_PD_OP_OD_PE_DP_AD_') > 0) Or (strCfgExi = 'VP')) And
        (Pos(strEspDoc, cnstEspTinDet) <= 0) Then
      Begin
        strSQL := AnsiReplaceStr(strSQL,'DET_','FDO_');
        strSQL := strSQL + '  TINDOR A  ';

        strSQL := strSQL + '  LEFT JOIN CADCLI ON CLI_CODCLI = FDO_CODCLI ';
        strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID ';
      End
      Else
      Begin
        strSQL := strSQL + '  TINDET A ';

        strSQL := strSQL + '  LEFT JOIN CADCLI ON CLI_CODCLI = DET_CODCLI ';
        strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID ';
      End;

      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  A.AUTOINCREM = :AUTINC ';

      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(strSQL);
      qryGen.ParamByName('AUTINC').AsString := strAutInc;
      qryGen.Open;

      pCarregaDadosFormulEtiq(qryGen, ftiDadosEtiq, False, strEspDoc);

      If fTipoTinta(fatFormulacao.GetIdePro) = ttAutomotiva Then
        pCarregaEmbalagemAutomotiva(qryGen, strCfgExi);

      strSQL := '';
      strSQL := strSQL + STR_SQL_NAO_REPLICAR;
      strSQL := strSQL + ' INSERT INTO ' + fatFormulacao.GetNomeTabelaFormulacao + ' ';
      strSQL := strSQL + ' VALUES (    ';
      strSQL := strSQL + '   :CODITE,  ';
      strSQL := strSQL + '   :FORMUL,  ';
      strSQL := strSQL + '   :DESCRI,  ';
      strSQL := strSQL + '   :QTDBAS ) ';

      fltQtdBas := 0.0;
      For intContador := 1 To fatFormulacao.GetQtdCampos Do
      Begin

        if fTipoTinta(fatFormulacao.GetIdePro) = ttAutomotiva then
        begin
          If fGetConfTinta(fatFormulacao.GetIdePro).fGet('ACUABS') = '2' Then
            fltQtdBas := 0.0;
        end
        else
          fltQtdBas := 0;

        If (strCfgExi = 'V') Or (Pos(strEspDoc, cnstEspTinDet) > 0) Then
        Begin
          strFormul := qryGen.FieldByName('DET_FORM' + fStrZero(IntToStr(intContador), 2)).AsString;
          fltQtdBas := fltQtdBas + qryGen.FieldByName('DET_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat;
        End
        Else
        Begin
          strFormul := qryGen.FieldByName('FDO_FORM' + fStrZero(IntToStr(intContador), 2)).AsString;
          fltQtdBas := fltQtdBas + qryGen.FieldByName('FDO_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat;
        End;

        if fTipoTinta(fatFormulacao.GetIdePro) = ttImobiliaria then
        begin
          fltQtdBas := fltQtdBas / fGetFatorML(fatFormulacao.GetIdePro);
        end;

        If (fEmptyStr(strFormul)) Then
          Continue;

        With qryFormul Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('FORMUL').AsString := strFormul;
          if fCfgSis('TOTPRD', varBoolean) then
            fltQtdBas := fltQtdBas * qryGen.FieldByName('QTD').AsFloat;

          strDescri := fDescricaoColorante(strFormul);


          If (fCfgSis('IMPDOP') = '2') Then
            ParamByName('DESCRI').AsString := fRetNomProduto(strCodIte)
          Else
            ParamByName('DESCRI').AsString := strDescri;


          ParamByName('CODITE').AsString := strCodIte;

          if fTipoTinta(fatFormulacao.GetIdePro) = ttImobiliaria then
            ParamByName('QTDBAS').AsString := fGetQuantidadeOncaPulsoMl(fltQtdBas, fatFormulacao.GetIdePro)
          else
            ParamByName('QTDBAS').AsString := FloatToStr(fltQtdBas);

          ExecSQL;
          Close;
        End;

        pAtualizaTemporaria;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;


end;

procedure TfrmFatFormulacaoGeneric.FormShow(Sender: TObject);
begin
  inherited;
  pMostraFormulacoes;
  Self.Caption := 'Formulação - ' + fRetornaNomeTinta(fatFormulacao.GetIdePro);
end;

function TfrmFatFormulacaoGeneric.fTintasQuantidadePulsos: Boolean;
begin
  Result := Pos(fatFormulacao.GetIdePro, 'CAL_SAY_') > 0;
end;

procedure TfrmFatFormulacaoGeneric.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgFormulacao);
end;

procedure TfrmFatFormulacaoGeneric.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pDeletaTemporaria;
end;

procedure TfrmFatFormulacaoGeneric.FormCreate(Sender: TObject);
begin
  inherited;
  qryFormul := fCriaQuery(Self);
  dtsFormul := fCriaDataSource(qryFormul);
  dbgFormulacao.DataSource := dtsFormul;
end;

procedure TfrmFatFormulacaoGeneric.dbgFormulacaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
  Begin
    btnCancelarForm.Click;
  End
  Else If (Key = VK_F10) Then
  Begin
    btnImprimir.Click;
  End;
end;

procedure TfrmFatFormulacaoGeneric.btnCancelarFormClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatFormulacaoGeneric.btnImprimirClick(Sender: TObject);
var
  strTipImp: String;
  prmDllEtq: TParamDllEtiquetas;
begin
  inherited;
  If fEmptyStr(ftiDadosEtiq.strNomImp) Then
  Begin
    Try
      qryCfgRel := fCriaQuery;
      TCfgRel.pCarregaConfImpr(qryCfgRel, 'frmFatFormulacaoItens_FORMUL');
      TCfgRel.fPreImpressao(qryCfgRel, ftiDadosEtiq.strNomImp, strTipImp, False);
    Finally
      FreeAndNil(qryCfgRel);
    End;
  End;

  prmDllEtq := TParamDllEtiquetas.Create;
  Try
    prmDllEtq.tpeTipEtq := tpeFomulacaoTinta;
    prmDllEtq.dtsImpres := qryFormul;
    prmDllEtq.ftiDadEti := ftiDadosEtiq;
    prmDllEtq.strOperador := '';

    fImprimeEtiqueta(prmDllEtq);
  Finally
    FreeAndNil(prmDllEtq);
  End;
end;

constructor TfrmFatFormulacaoGeneric.Create(AOwner: TComponent; const fatFormulacao: IFatFormulacao);
begin
  inherited Create(AOwner);
  Self.fatFormulacao := fatFormulacao;
//  mmoBase.Visible := fTipoTinta(fatFormulacao.GetIdePro) = ttImobiliaria
end;

end.
