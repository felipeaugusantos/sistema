unit untHerancaItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Mask,
  MaskEditFocus, StrUtils, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmHerancaItem = class(TfrmPai)
    Panel1: TPanel;
    Label9: TLabel;
    edtDesProduto: TEditFocus;
    edtCodProduto: TEditFocus;
    btnConfirma: TBitBtnLocked;
    procedure edtCodProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    strCodIte: String;
  public
    { Public declarations }
    blnConfirma: Boolean;

    qryGenIte :TUniQuery;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  end;

var
  frmHerancaItem: TfrmHerancaItem;

implementation

uses  untfuncoesSimples, DB, untConsultas, untTypesSistema, untPanelCxItem,
    untPnlDadosItem;

{$R *.dfm}

procedure TfrmHerancaItem.edtCodProdutoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryConGen: TUniQuery;
{    blnFiltraTecla: Boolean;
    intMinDigitos: Integer;
    blnIniciaVazio: Boolean;}
    arrSel : TConsultasArray;
    intOpcAtivos: Integer;
    objfrmPnl: TPanelCxItem;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin

    Try
      qryConGen := fCriaQuery;

      objfrmPnl := TPanelCxItem.New();

      Try
        intOpcAtivos := fMensagem('','Selecione o status dos itens:', ['Ativos', 'Inativos', 'Todos'],3);

        fPesqItem(conIteSimples, Self, edtCodProduto, edtDesProduto, qryConGen,
                  Key, arrSel, True, objFrmPnl, 'Consulta de Itens', '1',
                  '', {strConPag}
                  0,  {fltTaxVpr}
                  False, {blnEmpFat}
                  False, {blnExiPar}
                  intOpcAtivos, {intOpcAtivos}
                  cdrCodIte, {opcCodIte}
                  '', {strAplica}
                  False, {blnPedCom}
                  '', {strCodCli}
                  '',
                  True, {blnMostrarPrecos}
                  False, {blnTablet}
                  False {blnConsiderarExiLis});

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[frmHerancaItem.edtCodProdutoKeyPress]');
        End;
      End;
    Finally
      FreeAndNil(qryConGen);
      FreeAndNil(objfrmPnl);
    End;
  End;
end;

procedure TfrmHerancaItem.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtCodProduto);
end;

procedure TfrmHerancaItem.FormShow(Sender: TObject);
begin
  inherited;
  edtCodProduto.Clear;
  edtDesProduto.Clear;
  pSetFocus(edtCodProduto);

end;

function TfrmHerancaItem.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    if Sender = edtCodProduto then
    begin
      If fEmptyStr(edtCodProduto.Text) Then
      Begin
        fMensagem('ATENÇÃO','O Campo Código do Item deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      Begin
        edtDesProduto.Text := fRetNomProduto(edtCodProduto.Text);
        If fEmptyStr(edtDesProduto.Text) Then
        Begin
          fMensagem('ATENÇÃO','Código do Produto não encontrado!',['&O K']);
          edtCodProduto.Clear;
          Result := False;
        end;
      End;
    end;

    if not Result then
      pSetFocus(Sender);
  End;
end;

procedure TfrmHerancaItem.btnConfirmaClick(Sender: TObject);
  Var
    strSQL: String;
    intTabPre: Integer;
begin
  inherited;

  if not fVerificaCampos then
    Exit;

  strCodIte := edtCodProduto.Text;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  //CAMPOS DO SELECT NO ITEGER
  strSQL := strSQL + '  G.ITE_CODEMP, ';
  strSQL := strSQL + '  G.ITE_CODITE, ';
  strSQL := strSQL + '  G.ITE_PRECOM, ';
  strSQL := strSQL + '  G.ITE_DESF01, ';
  strSQL := strSQL + '  G.ITE_DESF02, ';
  strSQL := strSQL + '  G.ITE_DESF03, ';
  strSQL := strSQL + '  G.ITE_DESF04, ';
  strSQL := strSQL + '  G.ITE_DESF05, ';
  strSQL := strSQL + '  G.ITE_DESF06, ';
  strSQL := strSQL + '  G.ITE_ICMENT, ';
  strSQL := strSQL + '  G.ITE_SUBFED, ';
  strSQL := strSQL + '  G.ITE_IPIENT, ';
  strSQL := strSQL + '  G.ITE_FREENT, ';
  strSQL := strSQL + '  G.ITE_ACRFIN, ';
  strSQL := strSQL + '  G.ITE_SUBSTI, ';
  strSQL := strSQL + '  G.ITE_IMPFED, ';
  strSQL := strSQL + '  G.ITE_PRECUS, ';
  strSQL := strSQL + '  G.ITE_ICMSAI, ';
  strSQL := strSQL + '  G.ITE_OUTVAL, ';
  strSQL := strSQL + '  G.ITE_DESADB, ';  
  strSQL := strSQL + '  G.ITE_DESMAX, ';
  strSQL := strSQL + '  G.ITE_MARBR1, ';
  strSQL := strSQL + '  G.ITE_PREVE1, ';
  strSQL := strSQL + '  G.ITE_MARBR2, ';
  strSQL := strSQL + '  G.ITE_PREVE2, ';
  strSQL := strSQL + '  G.ITE_MARBR3, ';
  strSQL := strSQL + '  G.ITE_PREVE3, ';
  strSQL := strSQL + '  G.ITE_MARBR4, ';
  strSQL := strSQL + '  G.ITE_PREVE4, ';
  strSQL := strSQL + '  G.ITE_MARBR5, ';
  strSQL := strSQL + '  G.ITE_PREVE5, ';
  strSQL := strSQL + '  G.ITE_MARBR6, ';
  strSQL := strSQL + '  G.ITE_PREVE6, ';
  strSQL := strSQL + '  G.ITE_MARBR7, ';
  strSQL := strSQL + '  G.ITE_PREVE7, ';

  strSQL := strSQL + '  G.ITE_TABPR1, ';
  strSQL := strSQL + '  G.ITE_TABPR2, ';
  strSQL := strSQL + '  G.ITE_TABPR3, ';
  strSQL := strSQL + '  G.ITE_TABPR4, ';
  strSQL := strSQL + '  G.ITE_TABPR5, ';
  strSQL := strSQL + '  G.ITE_TABPR6, ';
  strSQL := strSQL + '  G.ITE_TABPR7, ';

  strSQL := strSQL + '  G.ITE_IPISAI, ';
  strSQL := strSQL + '  G.ITE_LOCFIS, ';
  strSQL := strSQL + '  G.ITE_COMVAR, ';
  strSQL := strSQL + '  G.ITE_COMATA, ';
  strSQL := strSQL + '  G.ITE_COMDIS, ';
  strSQL := strSQL + '  G.ITE_DTAULT, ';
  strSQL := strSQL + '  G.ITE_QTDUCO, ';
  strSQL := strSQL + '  G.ITE_PREULT, ';
  strSQL := strSQL + '  G.ITE_IMPULT, ';
  strSQL := strSQL + '  G.ITE_DTAUVE, ';
  strSQL := strSQL + '  G.ITE_QTDUVE, ';
  strSQL := strSQL + '  G.ITE_PREUVE, ';
  strSQL := strSQL + '  G.ITE_PREMED, ';
  strSQL := strSQL + '  G.ITE_FORULT, ';
  strSQL := strSQL + '  G.ITE_SALDOS, ';
  strSQL := strSQL + '  G.ITE_DESOPE, ';
  strSQL := strSQL + '  G.ITE_QTPPRO, ';
  strSQL := strSQL + '  G.ITE_ESMIDG, ';
  strSQL := strSQL + '  G.ITE_CPRCEN, ';
  strSQL := strSQL + '  G.ITE_VALFRE, ';

  strSQL := strSQL + '  G.ITE_COMTB1, ';
  strSQL := strSQL + '  G.ITE_COMTB2, ';
  strSQL := strSQL + '  G.ITE_COMTB3, ';
  strSQL := strSQL + '  G.ITE_COMTB4, ';
  strSQL := strSQL + '  G.ITE_COMTB5, ';
  strSQL := strSQL + '  G.ITE_COMTB6, ';
  strSQL := strSQL + '  G.ITE_COMTB7, ';

  strSQL := strSQL + '  G.ITE_MARID1, ';
  strSQL := strSQL + '  G.ITE_MARID2, ';
  strSQL := strSQL + '  G.ITE_MARID3, ';
  strSQL := strSQL + '  G.ITE_MARID4, ';
  strSQL := strSQL + '  G.ITE_MARID5, ';
  strSQL := strSQL + '  G.ITE_MARID6, ';
  strSQL := strSQL + '  G.ITE_MARID7, ';

  strSQL := strSQL + '  G.ITE_NIVGIR, ';
  strSQL := strSQL + '  G.ITE_NIVCRI, ';
  strSQL := strSQL + '  G.ITE_DTAVAL, ';

  //CAMPOS DO SELECT NO CADITE
  strSQL := strSQL + '  I.ITE_DESITE, ';
  strSQL := strSQL + '  I.ITE_GRAMAR, ';
  strSQL := strSQL + '  I.ITE_MLTSPO, ';

  strSQL := strSQL + '  I.ITE_EXCBFR, ';
  strSQL := strSQL + '  I.ITE_ABFREF, ';

  strSQL := strSQL + '  I.ITE_CODGRU, ';
  strSQL := strSQL + '  I.ITE_REFERE, ';
  strSQL := strSQL + '  I.ITE_FATCMP, ';
  strSQL := strSQL + '  I.ITE_FATPM3, ';
  strSQL := strSQL + '  I.ITE_CODUNI, ';
  strSQL := strSQL + '  I.ITE_UNICOM, ';
  strSQL := strSQL + '  I.ITE_UNITRI, ';
  strSQL := strSQL + '  I.ITE_FATUTR, ';
  strSQL := strSQL + '  UNI_DESUNI, ';
  strSQL := strSQL + '  I.ITE_CODMAR, ';
  strSQL := strSQL + '  MAR_DESMAR, ';
  strSQL := strSQL + '  I.ITE_CODBAR, ';
  strSQL := strSQL + '  I.ITE_CODFAB, ';
  strSQL := strSQL + '  I.ITE_CODFOR, ';
  strSQL := strSQL + '  I.ITE_CODGPR, ';  
  strSQL := strSQL + '  I.ITE_CDCEST, ';

  If fCfgSIs('TIPABF') = '1' Then
    strSQL := strSQL + '  I.ITE_CODABF, '
  Else
    strSQL := strSQL + '  G.ITE_CODABF, ';

  If fCfgSIs('TIPABF') = '1' Then
    strSQL := strSQL + '  I.ITE_USAPPF, '
  Else
    strSQL := strSQL + '  G.ITE_USAPPF, ';

  If fCfgSis('TPABPC') = '1' Then
  Begin
    strSQL := strSQL + '  I.ITE_ABFPIS, ';
    strSQL := strSQL + '  I.ITE_ABFCOF, ';
    strSQL := strSQL + '  I.ITE_ABFIPI, ';
  End
  Else
  Begin
    strSQL := strSQL + '  G.ITE_ABFPIS, ';
    strSQL := strSQL + '  G.ITE_ABFCOF, ';
    strSQL := strSQL + '  G.ITE_ABFIPI, ';
  End;

  strSQL := strSQL + '  I.ITE_INCPIS, ';
  strSQL := strSQL + '  I.ITE_COMLUB, ';
  strSQL := strSQL + '  I.ITE_CLAIPI, ';
  strSQL := strSQL + '  G.ITE_IMPLIS, ';
  strSQL := strSQL + '  G.ITE_APERET, ';
  strSQL := strSQL + '  G.ITE_APEENT, ';
  strSQL := strSQL + '  I.ITE_ITEATI, ';
  strSQL := strSQL + '  I.ITE_ATICOM, ';
  strSQL := strSQL + '  I.ITE_PESOIT, ';
  strSQL := strSQL + '  I.ITE_PESLIQ, ';  
  strSQL := strSQL + '  I.ITE_ITEBAS, ';
  strSQL := strSQL + '  I.ITE_CNV_ML, ';
  strSQL := strSQL + '  I.ITE_ITEPIG, ';
  strSQL := strSQL + '  I.ITE_EMBALA, ';
  strSQL := strSQL + '  I.ITE_MLTCOM, ';
  strSQL := strSQL + '  I.ITE_MLTVEN, ';
  strSQL := strSQL + '  I.ITE_NVLGIR, ';
  strSQL := strSQL + '  I.ITE_NVLCRI, ';
  strSQL := strSQL + '  I.ITE_MSGLV1, ';
  strSQL := strSQL + '  I.ITE_MSGLV2, ';
  strSQL := strSQL + '  I.ITE_APLICA, ';
  strSQL := strSQL + '  I.ITE_INFLAM, ';
  strSQL := strSQL + '  I.ITE_ITECCR, ';
  strSQL := strSQL + '  I.ITE_FATCNV, ';
  strSQL := strSQL + '  I.ITE_TMPGAR, ';
  strSQL := strSQL + '  I.ITE_RSPGAR, ';
  strSQL := strSQL + '  I.ITE_EXPSIT, ';
  strSQL := strSQL + '  I.ITE_EXPB2B, ';
  strSQL := strSQL + '  I.ITE_EXPPOK, ';
  strSQL := strSQL + '  I.ITE_EXPAPP, ';

  strSQL := strSQL + '  I.ITE_EXPAPP, ';

  strSQL := strSQL + '  I.ITE_LAYORD, ';
  strSQL := strSQL + '  I.ITE_VALIDA, ';
  strSQL := strSQL + '  I.ITE_COMPOS, ';
  strSQL := strSQL + '  I.ITE_ITESAC, ';
  strSQL := strSQL + '  I.ITE_PAISOR, ';
  strSQL := strSQL + '  I.ITE_CLACRM, ';
  strSQL := strSQL + '  G.ITE_USASER, ';
  strSQL := strSQL + '  G.ITE_REDROP, ';
  strSQL := strSQL + '  G.ITE_PDEGRD, ';

  If fCfgSis('IMPDIG') = '1' Then
    strSQL := strSQL + '  I.ITE_IMPDIR, '
  Else
    strSQL := strSQL + '  G.ITE_IMPDIR, ';

  If fCfgSis('INDREV') = '1' Then
    strSQL := strSQL + '  I.ITE_INDREV, '
  Else
    strSQL := strSQL + '  G.ITE_INDREV, ';

  strSQL := strSQL + '  I.ITE_ECARGA, ';
  strSQL := strSQL + '  I.ITE_PERSOL, ';
  strSQL := strSQL + '  I.ITE_ABSOLE, ';
  strSQL := strSQL + '  I.ITE_TIPFRE, ';
  strSQL := strSQL + '  G.ITE_CPRCEN, ';
  strSQL := strSQL + '  G.ITE_ABAMLT, ';
  strSQL := strSQL + '  G.ITE_DESMGE, ';
  strSQL := strSQL + '  G.ITE_DESMSU, ';
  strSQL := strSQL + '  D.ITE_DESITE AS ITE_DESSIT, ';
  strSQL := strSQL + '  D.ITE_URLIMG AS ITE_URLIMG, ';
  strSQL := strSQL + '  D.ITE_DESSIT AS ITE_VALDES, ';
  strSQL := strSQL + '  D.ITE_NOMITE, ';
  strSQL := strSQL + '  D.ITE_APLITE, ';
  strSQL := strSQL + '  D.ITE_DADTEC, ';
  strSQL := strSQL + '  D.ITE_EXPALT, ';
  strSQL := strSQL + '  D.ITE_EXPLAR, ';
  strSQL := strSQL + '  D.ITE_EXPPRO, ';
  strSQL := strSQL + '  D.ITE_INCLUS, ';
  strSQL := strSQL + '  D.ITE_DESTAQ, ';
  strSQL := strSQL + '  D.ITE_CRODOC, ';
  strSQL := strSQL + '  D.ITE_ATZPRE, ';
  strSQL := strSQL + '  I.ITE_USABON, ';
  strSQL := strSQL + '  I.ITE_FATCOM, ';
  strSQL := strSQL + '  I.ITE_VALOBR, ';
  strSQL := strSQL + '  G.ITE_DESMVM, ';
  strSQL := strSQL + '  G.ITE_DESMSM, ';
  strSQL := strSQL + '  G.ITE_DESMGM, ';

  if fCfgSis('NFEPEP', varBoolean) then
    strSQL := strSQL + '  G.ITE_OBRNFE, '
  else
    strSQL := strSQL + '  I.ITE_OBRNFE, ';

  strSQL := strSQL + '  G.ITE_PREDOL, ';
  strSQL := strSQL + '  I.ITE_DENSID, ';
  strSQL := strSQL + '  I.ITE_CODDEP, ';
  strSQL := strSQL + '  I.ITE_PEEFUT, ';
  strSQL := strSQL + '  I.ITE_PEFUTP, ';
  strSQL := strSQL + '  I.AUTOINCREM, ';
  strSQL := strSQL + '  I.ITE_PER_CI, ';
  strSQL := strSQL + '  I.ITE_NUMFCI, ';
  strSQL := strSQL + '  I.ITE_PRAPEL, ';
  strSQL := strSQL + '  I.ITE_INFGAR, ';
  strSQL := strSQL + '  I.ITE_PIIZFM, ';
  strSQL := strSQL + '  G.ITE_CODLSE, ';

  strSQL := strSQL + '  I.ITE_DESSIM, ';
  strSQL := strSQL + '  I.ITE_PRDGRU, ';
  strSQL := strSQL + '  I.ITE_ABATIM, ';
  strSQL := strSQL + '  I.ITE_BRITA_, ';
  strSQL := strSQL + '  I.ITE_TIPMPS, ';
  strSQL := strSQL + '  I.ITE_FCKDIA, ';
  strSQL := strSQL + '  I.ITE_CONBOM, ';
  strSQL := strSQL + '  I.ITE_PRAVAL, ';
  strSQL := strSQL + '  I.ITE_PROEMB, ';
  strSQL := strSQL + '  I.ITE_MARBAS, ';
  strSQL := strSQL + '  I.ITE_DENSID, ';
  strSQL := strSQL + '  I.ITE_SITPRD, ';
  strSQL := strSQL + '  I.ITE_CODCOM, ';
  strSQL := strSQL + '  G.ITE_SITPRO, ';
  strSQL := strSQL + '  I.ITE_BAREXP, ';
  strSQL := strSQL + '  I.ITE_MAXBRI, ';
  strSQL := strSQL + '  I.ITE_NOTESP, ';
  strSQL := strSQL + '  I.ITE_VLCFRE, ';
  strSQL := strSQL + '  I.ITE_MESGIR, ';
  strSQL := strSQL + '  G.ITE_PRAMIN, ';
  strSQL := strSQL + '  I.ITE_IMPETI, ';
  strSQL := strSQL + '  I.ITE_DESFAB, ';
  strSQL := strSQL + '  I.ITE_GRUCMP, ';
  strSQL := strSQL + '  I.ITE_DIAFOR, ';
  strSQL := strSQL + '  I.ITE_RPRENT, ';
  strSQL := strSQL + '  I.ITE_REAEND, ';
  strSQL := strSQL + '  I.ITE_OBRBAR, ';
  strSQL := strSQL + '  I.ITE_ACOOBJ, ';
  strSQL := strSQL + '  I.ITE_RASTRE, ';
  strSQL := strSQL + '  I.ITE_OBRCPF, ';
  strSQL := strSQL + '  I.ITE_OBRIBA, ';
  strSQL := strSQL + '  I.ITE_MENFIS, ';
  strSQL := strSQL + '  I.ITE_AGROTO, ';
  strSQL := strSQL + '  I.ITE_CODONU, ';
  strSQL := strSQL + '  I.ITE_CODDIC, ';
  strSQL := strSQL + '  G.ITE_TIPPRO, ';
  strSQL := strSQL + '  I.ITE_CODFIN, ';
  strSQL := strSQL + '  I.ITE_CODLUB, ';

  strSQL := strSQL + '  I.ITE_DESANP, ';
  strSQL := strSQL + '  I.ITE_INDESC, ';
  strSQL := strSQL + '  I.ITE_ENIECB, ';
  strSQL := strSQL + '  I.ITE_CNPFME, ';
  strSQL := strSQL + '  I.ITE_CDBFIS, ';

  strSQL := strSQL + '  D.ITE_CODCAT, ';

  strSQL := strSQL + '  G.ITE_COMMEC, ';
  strSQL := strSQL + '  G.ITE_COMPRO, ';
  strSQL := strSQL + '  G.ITE_MARMIN, ';
  strSQL := strSQL + '  G.ITE_MARMSG, ';
  strSQL := strSQL + '  G.ITE_MARMGE, ';

  strSQL := strSQL + '  G.ITE_MARMMV, ';
  strSQL := strSQL + '  G.ITE_MARMMS, ';
  strSQL := strSQL + '  G.ITE_MARMMG, ';

  For intTabPre := 1 To Length(VS_strTabPrc) Do
    strSQL := strSQL + '  '+'G.ITE_MINTB' + IntToStr(intTabPre)+', ';

  strSQL := strSQL + '  I.ITE_LARVID, ';
  strSQL := strSQL + '  I.ITE_ALTVID, ';
  strSQL := strSQL + '  I.ITE_LAMAVI, ';
  strSQL := strSQL + '  I.ITE_ALMAVI, ';

  strSQL := strSQL + '  I.ITE_CDCEST, ';
  strSQL := strSQL + '  I.ITE_EXCIPI, ';
  strSQL := strSQL + '  G.ITE_TPCOMC, ';
  strSQL := strSQL + '  I.ITE_PEFFPR, ';
  strSQL := strSQL + '  I.ITE_USAFLE, ';

  strSQL := strSQL + '  I.ITE_ARESUG, ';
  strSQL := strSQL + '  I.ITE_AREMAX, ';
  strSQL := strSQL + '  I.ITE_LARMIN, ';
  strSQL := strSQL + '  I.ITE_ALTMIN, ';
  strSQL := strSQL + '  I.ITE_AREMIN, ';
  strSQL := strSQL + '  I.ITE_UTIAMP, ';
  strSQL := strSQL + '  I.ITE_LOTEPD, ';
  strSQL := strSQL + '  I.ITE_DESCND, ';
  strSQL := strSQL + '  I.ITE_VENSUB, ';
  strSQL := strSQL + '  I.ITE_TRASUB, ';
  strSQL := strSQL + '  G.ITE_RECDEV, ';
  strSQL := strSQL + '  G.ITE_PESOBR, ';
  strSQL := strSQL + '  G.ITE_CPESOB, ';
  strSQL := strSQL + '  G.ITE_COMDIG, ';
  strSQL := strSQL + '  I.ITE_USABEF, ';
  strSQL := strSQL + '  I.ITE_CAREST, ';
  strSQL := strSQL + '  G.ITE_DESCHK, ';
  strSQL := strSQL + '  I.ITE_USAQUE, ';
  strSQL := strSQL + '  I.ITE_ABFCON, ';
  strSQL := strSQL + '  G.ITE_TCIFCU, ';
  strSQL := strSQL + '  G.ITE_TSCUST, ';
  strSQL := strSQL + '  G.ITE_DEPICO, ';
  strSQL := strSQL + '  G.ITE_DEICMS, ';
  strSQL := strSQL + '  G.ITE_FATREG, ';
  strSQL := strSQL + '  I.ITE_CODGPC, ';
  strSQL := strSQL + '  I.ITE_DIACRI, ';
  strSQL := strSQL + '  I.ITE_REALOC, ';
  strSQL := strSQL + '  I.ITE_TIPLOC, ';
  strSQL := strSQL + '  I.ITE_USAPFD, ';
  strSQL := strSQL + '  I.ITE_USAPCV, ';
  strSQL := strSQL + '  I.ITE_ITEBAL, ';
  strSQL := strSQL + '  I.ITE_ANVISE, ';
  strSQL := strSQL + '  I.ITE_REGESP, ';
  strSQL := strSQL + '  I.ITE_CILVAS, ';
  strSQL := strSQL + '  I.ITE_ENTESP, ';
  strSQL := strSQL + '  I.ITE_SEPEXC, ';
  strSQL := strSQL + '  G.ITE_CODATC, ';
  strSQL := strSQL + '  G.ITE_SOBENC, ';
  strSQL := strSQL + '  G.ITE_MLTRCA, ';
  strSQL := strSQL + '  I.ITE_BASTRO, ';
  strSQL := strSQL + '  I.ITE_TPPROD, ';
  strSQL := strSQL + '  I.ITE_TIPREC, ';
  strSQL := strSQL + '  I.ITE_VLRCRE, ';
  strSQL := strSQL + '  I.ITE_LOTRAP, ';
  strSQL := strSQL + '  I.ITE_NFEIDP, ';
  strSQL := strSQL + '  I.ITE_NFCIDP, ';
  strSQL := strSQL + '  I.ITE_GERNTE, ';
  strSQL := strSQL + '  I.ITE_TRITTE, ';
  strSQL := strSQL + '  I.ITE_PROREC, ';
  strSQL := strSQL + '  I.ITE_PIMPTC, ';
  strSQL := strSQL + '  I.ITE_SEPBAR, ';
  strSQL := strSQL + '  G.ITE_OBRNLT, ';
  strSQL := strSQL + '  I.ITE_EXISIM, ';
  strSQL := strSQL + '  G.ITE_TIPABS, ';
  strSQL := strSQL + '  G.ITE_MLTTRF, ';
  strSQL := strSQL + '  G.ITE_VNOLCD, ';
  strSQL := strSQL + '  G.ITE_PGMNBM, ';
  strSQL := strSQL + '  G.ITE_MINTRF, ';
  strSQL := strSQL + '  G.ITE_MAXTRF, ';
  strSQL := strSQL + '  G.ITE_DCMPLJ, ';
  strSQL := strSQL + '  G.ITE_DIATRF, ';
  strSQL := strSQL + '  I.ITE_CLBPIN, ';
  strSQL := strSQL + '  G.ITE_PEVNDA, ';
  strSQL := strSQL + '  I.ITE_PERVDA  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ITEGER G ';
  strSQL := strSQL + '  JOIN CADITE I ON G.ITE_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '  JOIN CADMAR ON I.ITE_CODMAR = MAR_CODMAR ';
  strSQL := strSQL + '  JOIN CADUNI ON I.ITE_CODUNI = UNI_CODUNI ';
  strSQL := strSQL + '  LEFT JOIN DESSIT D ON I.ITE_CODITE = D.ITE_CODITE ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  G.ITE_CODEMP = ' + ' "' + VS_strCodEmp + ' "  AND ';
  strSQL := strSQL + '  G.ITE_CODITE = ' + ' "' + strCodIte + '"  AND ' ;
  strSQL := strSQL + '  I.ITE_CODUNI = UNI_CODUNI AND ';
  strSQL := strSQL + '  I.ITE_CODMAR = MAR_CODMAR AND ';
  strSQL := strSQL + '  G.ITE_CODITE = I.ITE_CODITE ';

  With qryGenIte Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;
  
  blnConfirma := True;
  Close;

end;

end.


