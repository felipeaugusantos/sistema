unit libTintaBautech_DfmCheck_Unit;

interface

implementation

uses
  untPai,
  untAbstractDigTintaImobiliaria,
  untFormulacaoImobiliaria,
  untNovasFormulasEmbalagens,
  SysUtils;

procedure TestDfmFormConsistency;
begin
{ frmPai: TfrmPai }
  with TfrmPai(nil) do { untPai.pas }
  begin
    pnlBotoes.ClassName; { pnlBotoes: TPanel; }
    btnSair.ClassName; { btnSair: TBitBtnLocked; }
    pnlStatus.ClassName; { pnlStatus: TPanel; }
    pnlNomeForm.ClassName; { pnlNomeForm: TPanel; }
    pnlInfo.ClassName; { pnlInfo: TPanel; }
    ApplicationEvents.ClassName; { ApplicationEvents: TApplicationEvents; }
    mnuAuxiliar.ClassName; { mnuAuxiliar: TPopupMenu; }
    mnuConfigurarRel.ClassName; { mnuConfigurarRel: TMenuItem; }
    frxCSVExportTestabilidade.ClassName; { frxCSVExportTestabilidade: TfrxCSVExportTestabilidade; }
  end;

{ frmAbstractDigTintaImobiliaria: TfrmAbstractDigTintaImobiliaria }
  with TfrmAbstractDigTintaImobiliaria(nil) do { untAbstractDigTintaImobiliaria.pas }
  begin
    pnlBotoes.ClassName; { pnlBotoes: TPanel; }
    btnSair.ClassName; { btnSair: TBitBtnLocked; }
    btnConfirma.ClassName; { btnConfirma: TBitBtnLocked; }
    btnFormulacao.ClassName; { btnFormulacao: TBitBtnLocked; }
    pnlStatus.ClassName; { pnlStatus: TPanel; }
    pnlNomeForm.ClassName; { pnlNomeForm: TPanel; }
    pnlInfo.ClassName; { pnlInfo: TPanel; }
    pnlGeral.ClassName; { pnlGeral: TPanel; }
    Label1.ClassName; { Label1: TLabel; }
    Label2.ClassName; { Label2: TLabel; }
    Label3.ClassName; { Label3: TLabel; }
    Label4.ClassName; { Label4: TLabel; }
    Label5.ClassName; { Label5: TLabel; }
    edtBasAtu.ClassName; { edtBasAtu: TEditFocus; }
    edtDesBasAtu.ClassName; { edtDesBasAtu: TEditFocus; }
    edtPreBasAtu.ClassName; { edtPreBasAtu: TEditFocus; }
    edtNovBas.ClassName; { edtNovBas: TEditFocus; }
    edtDesNovBas.ClassName; { edtDesNovBas: TEditFocus; }
    edtPreNovBas.ClassName; { edtPreNovBas: TEditFocus; }
    edtDesAdi.ClassName; { edtDesAdi: TEditFocus; }
    pnlTotais.ClassName; { pnlTotais: TPanel; }
    Label7.ClassName; { Label7: TLabel; }
    Label8.ClassName; { Label8: TLabel; }
    Label9.ClassName; { Label9: TLabel; }
    edtValBas.ClassName; { edtValBas: TEditFocus; }
    edtValCol.ClassName; { edtValCol: TEditFocus; }
    edtValTin.ClassName; { edtValTin: TEditFocus; }
  end;

{ frmFormulacaoImobiliaria: TfrmFormulacaoImobiliaria }
  with TfrmFormulacaoImobiliaria(nil) do { untFormulacaoImobiliaria.pas }
  begin
    pnlBotoes.ClassName; { pnlBotoes: TPanel; }
    btnSair.ClassName; { btnSair: TBitBtnLocked; }
    pnlStatus.ClassName; { pnlStatus: TPanel; }
    pnlNomeForm.ClassName; { pnlNomeForm: TPanel; }
    pnlInfo.ClassName; { pnlInfo: TPanel; }
    lsvFormulacao.ClassName; { lsvFormulacao: TListView; }
    pnlRodape.ClassName; { pnlRodape: TPanel; }
    Label1.ClassName; { Label1: TLabel; }
    memCalculo.ClassName; { memCalculo: TMemo; }
  end;

{ frmNovasFormulasEmbalagens: TfrmNovasFormulasEmbalagens }
  with TfrmNovasFormulasEmbalagens(nil) do { untNovasFormulasEmbalagens.pas }
  begin
    pnlBotoes.ClassName; { pnlBotoes: TPanel; }
    btnSair.ClassName; { btnSair: TBitBtnLocked; }
    btnGravar.ClassName; { btnGravar: TBitBtnLocked; }
    pnlStatus.ClassName; { pnlStatus: TPanel; }
    pnlNomeForm.ClassName; { pnlNomeForm: TPanel; }
    pnlInfo.ClassName; { pnlInfo: TPanel; }
    grpEmbDif.ClassName; { grpEmbDif: TGroupBox; }
    dbgrdEmbDif.ClassName; { dbgrdEmbDif: TDBGridCitel; }
    ApplicationEvents.ClassName; { ApplicationEvents: TApplicationEvents; }
    dsCadEmb.ClassName; { dsCadEmb: TDataSource; }
    cdsEmbDif.ClassName; { cdsEmbDif: TUniClientDataSet; }
    cdsEmbDifBAU_CODFML.ClassName; { cdsEmbDifBAU_CODFML: TStringField; }
    cdsEmbDifBAU_CODBAS.ClassName; { cdsEmbDifBAU_CODBAS: TStringField; }
    cdsEmbDifBAU_CODUNI.ClassName; { cdsEmbDifBAU_CODUNI: TStringField; }
    cdsEmbDifUNI_DESUNI.ClassName; { cdsEmbDifUNI_DESUNI: TStringField; }
    cdsEmbDifNFM_VOLUME.ClassName; { cdsEmbDifNFM_VOLUME: TFloatField; }
  end;

end;

end.
