unit untFrameAbreviacaoIcms;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxLabel, cxCurrencyEdit, cxContainer, cxTextEdit, cxMaskEdit, cxSpinEdit,
  Vcl.StdCtrls, cxCustomListBox, cxCheckListBox, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridBandedTableView, cxGridDBBandedTableView, cxClasses,
  cxGridCustomView, cxGrid, iMendes.TProcessoAutcom, untSalvaDadosInterface, iMendes.Types,
  cxGridDBDataDefinitions, System.strUtils, Vcl.CheckLst, System.UITypes,
  cxButtonEdit, Uni;

type


  TBandPerfil = class
    Visible : Boolean ;
    Band    : TcxGridband;
    Perfil  : TPerfil;
    strDescri: String;
    procedure pChangeVisible(AValue: Boolean);
  End;


  TArrBandPerfil = array of TBandPerfil;

  TGridDinamico = class
    cxbGrid: TcxGridDBBandedTableView;
    ArrBandPerfil: TArrBandPerfil;
    procedure pAjustaArrBandPerfil(FilterPerfis: TConjPerfis; chkListPrefil: TcxCheckListBox);
    procedure pCriaEstruturas;
    procedure pCriaEstruturaPerfil(Perfil: TPerfil; index: integer);
    procedure pCriaEstruturaInfGerais;
    procedure pAddFieldCST(Perfil: TPerfil; BandPai: TcxGridband);

    procedure pAddFieldsICMS(Perfil: TPerfil; BandPai: TcxGridband);
    procedure pAddFieldsST(Perfil: TPerfil; BandPai: TcxGridband);
    procedure pAddFieldsDifal(Perfil: TPerfil; BandPai: TcxGridband);
    procedure pAddFieldsFCP(Perfil: TPerfil; BandPai: TcxGridband);
    procedure AliquotaGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure IVAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure pAddFieldsMensagens(Perfil: TPerfil; BandPai: TcxGridband);
    procedure pAddFieldsCODBEN(Perfil: TPerfil; BandPai: TcxGridband);
  End;


  TframeAbreviacoesIcms = class(TFrame)
    cxgDados: TcxGrid;
    cxbDados: TcxGridDBBandedTableView;
    bABF_CODABF: TcxGridDBBandedColumn;
    LOCAL: TcxGridDBBandedColumn;
    ABF_ESTADO: TcxGridDBBandedColumn;
    ABF_CODSIT_ENT_PEF: TcxGridDBBandedColumn;
    ABF_BASICM_ENT_PEF: TcxGridDBBandedColumn;
    ABF_ALQICM_ENT_PEF: TcxGridDBBandedColumn;
    ABF_BASRET_ENT_PEF: TcxGridDBBandedColumn;
    ABF_ALQRET_ENT_PEF: TcxGridDBBandedColumn;
    ABF_IVA_ST_ENT_PEF: TcxGridDBBandedColumn;
    ABF_ALQFCP_ENT_PEF: TcxGridDBBandedColumn;
    ABF_ALQEFO_ENT_PEF: TcxGridDBBandedColumn;
    ABF_ALQRED_ENT_PEF: TcxGridDBBandedColumn;
    ABF_BASDDS_ENT_PEF: TcxGridDBBandedColumn;
    DIF_CODSIT_ENT_PEF: TcxGridDBBandedColumn;
    DIF_BASICM_ENT_PEF: TcxGridDBBandedColumn;
    DIF_ALQICM_ENT_PEF: TcxGridDBBandedColumn;
    DIF_BASRET_ENT_PEF: TcxGridDBBandedColumn;
    DIF_ALQRET_ENT_PEF: TcxGridDBBandedColumn;
    DIF_IVA_ST_ENT_PEF: TcxGridDBBandedColumn;
    DIF_ALQFCP_ENT_PEF: TcxGridDBBandedColumn;
    DIF_ALQEFO_ENT_PEF: TcxGridDBBandedColumn;
    DIF_ALQRED_ENT_PEF: TcxGridDBBandedColumn;
    DIF_BASDDS_ENT_PEF: TcxGridDBBandedColumn;
    ABF_CODSIT_ENT_PEJ: TcxGridDBBandedColumn;
    ABF_BASICM_ENT_PEJ: TcxGridDBBandedColumn;
    ABF_ALQICM_ENT_PEJ: TcxGridDBBandedColumn;
    ABF_BASRET_ENT_PEJ: TcxGridDBBandedColumn;
    ABF_ALQRET_ENT_PEJ: TcxGridDBBandedColumn;
    ABF_IVA_ST_ENT_PEJ: TcxGridDBBandedColumn;
    ABF_ALQFCP_ENT_PEJ: TcxGridDBBandedColumn;
    ABF_ALQEFO_ENT_PEJ: TcxGridDBBandedColumn;
    ABF_ALQRED_ENT_PEJ: TcxGridDBBandedColumn;
    ABF_BASDDS_ENT_PEJ: TcxGridDBBandedColumn;
    DIF_CODSIT_ENT_PEJ: TcxGridDBBandedColumn;
    DIF_BASICM_ENT_PEJ: TcxGridDBBandedColumn;
    DIF_ALQICM_ENT_PEJ: TcxGridDBBandedColumn;
    DIF_BASRET_ENT_PEJ: TcxGridDBBandedColumn;
    DIF_ALQRET_ENT_PEJ: TcxGridDBBandedColumn;
    DIF_IVA_ST_ENT_PEJ: TcxGridDBBandedColumn;
    DIF_ALQFCP_ENT_PEJ: TcxGridDBBandedColumn;
    DIF_ALQEFO_ENT_PEJ: TcxGridDBBandedColumn;
    DIF_ALQRED_ENT_PEJ: TcxGridDBBandedColumn;
    DIF_BASDDS_ENT_PEJ: TcxGridDBBandedColumn;
    ABF_CODSIT_ENT_PER: TcxGridDBBandedColumn;
    ABF_BASICM_ENT_PER: TcxGridDBBandedColumn;
    ABF_ALQICM_ENT_PER: TcxGridDBBandedColumn;
    ABF_BASRET_ENT_PER: TcxGridDBBandedColumn;
    ABF_ALQRET_ENT_PER: TcxGridDBBandedColumn;
    ABF_IVA_ST_ENT_PER: TcxGridDBBandedColumn;
    ABF_ALQFCP_ENT_PER: TcxGridDBBandedColumn;
    ABF_ALQEFO_ENT_PER: TcxGridDBBandedColumn;
    ABF_ALQRED_ENT_PER: TcxGridDBBandedColumn;
    ABF_BASDDS_ENT_PER: TcxGridDBBandedColumn;
    DIF_CODSIT_ENT_PER: TcxGridDBBandedColumn;
    DIF_BASICM_ENT_PER: TcxGridDBBandedColumn;
    DIF_ALQICM_ENT_PER: TcxGridDBBandedColumn;
    DIF_BASRET_ENT_PER: TcxGridDBBandedColumn;
    DIF_ALQRET_ENT_PER: TcxGridDBBandedColumn;
    DIF_IVA_ST_ENT_PER: TcxGridDBBandedColumn;
    DIF_ALQFCP_ENT_PER: TcxGridDBBandedColumn;
    DIF_ALQEFO_ENT_PER: TcxGridDBBandedColumn;
    DIF_ALQRED_ENT_PER: TcxGridDBBandedColumn;
    DIF_BASDDS_ENT_PER: TcxGridDBBandedColumn;
    ABF_CODSIT_ENT_PES: TcxGridDBBandedColumn;
    ABF_BASICM_ENT_PES: TcxGridDBBandedColumn;
    ABF_ALQICM_ENT_PES: TcxGridDBBandedColumn;
    ABF_BASRET_ENT_PES: TcxGridDBBandedColumn;
    ABF_ALQRET_ENT_PES: TcxGridDBBandedColumn;
    ABF_IVA_ST_ENT_PES: TcxGridDBBandedColumn;
    ABF_ALQFCP_ENT_PES: TcxGridDBBandedColumn;
    ABF_ALQEFO_ENT_PES: TcxGridDBBandedColumn;
    ABF_ALQRED_ENT_PES: TcxGridDBBandedColumn;
    ABF_BASDDS_ENT_PES: TcxGridDBBandedColumn;
    DIF_CODSIT_ENT_PES: TcxGridDBBandedColumn;
    DIF_BASICM_ENT_PES: TcxGridDBBandedColumn;
    DIF_ALQICM_ENT_PES: TcxGridDBBandedColumn;
    DIF_BASRET_ENT_PES: TcxGridDBBandedColumn;
    DIF_ALQRET_ENT_PES: TcxGridDBBandedColumn;
    DIF_IVA_ST_ENT_PES: TcxGridDBBandedColumn;
    DIF_ALQFCP_ENT_PES: TcxGridDBBandedColumn;
    DIF_ALQEFO_ENT_PES: TcxGridDBBandedColumn;
    DIF_ALQRED_ENT_PES: TcxGridDBBandedColumn;
    DIF_BASDDS_ENT_PES: TcxGridDBBandedColumn;
    ABF_CODSIT_ENT_PSI: TcxGridDBBandedColumn;
    ABF_BASICM_ENT_PSI: TcxGridDBBandedColumn;
    ABF_ALQICM_ENT_PSI: TcxGridDBBandedColumn;
    ABF_BASRET_ENT_PSI: TcxGridDBBandedColumn;
    ABF_ALQRET_ENT_PSI: TcxGridDBBandedColumn;
    ABF_IVA_ST_ENT_PSI: TcxGridDBBandedColumn;
    ABF_ALQFCP_ENT_PSI: TcxGridDBBandedColumn;
    ABF_ALQEFO_ENT_PSI: TcxGridDBBandedColumn;
    ABF_ALQRED_ENT_PSI: TcxGridDBBandedColumn;
    ABF_BASDDS_ENT_PSI: TcxGridDBBandedColumn;
    DIF_CODSIT_ENT_PSI: TcxGridDBBandedColumn;
    DIF_BASICM_ENT_PSI: TcxGridDBBandedColumn;
    DIF_ALQICM_ENT_PSI: TcxGridDBBandedColumn;
    DIF_BASRET_ENT_PSI: TcxGridDBBandedColumn;
    DIF_ALQRET_ENT_PSI: TcxGridDBBandedColumn;
    DIF_IVA_ST_ENT_PSI: TcxGridDBBandedColumn;
    DIF_ALQFCP_ENT_PSI: TcxGridDBBandedColumn;
    DIF_ALQEFO_ENT_PSI: TcxGridDBBandedColumn;
    DIF_ALQRED_ENT_PSI: TcxGridDBBandedColumn;
    DIF_BASDDS_ENT_PSI: TcxGridDBBandedColumn;
    ABF_CODSIT_ENT_PII: TcxGridDBBandedColumn;
    ABF_BASICM_ENT_PII: TcxGridDBBandedColumn;
    ABF_ALQICM_ENT_PII: TcxGridDBBandedColumn;
    ABF_BASRET_ENT_PII: TcxGridDBBandedColumn;
    ABF_ALQRET_ENT_PII: TcxGridDBBandedColumn;
    ABF_IVA_ST_ENT_PII: TcxGridDBBandedColumn;
    ABF_ALQFCP_ENT_PII: TcxGridDBBandedColumn;
    ABF_ALQEFO_ENT_PII: TcxGridDBBandedColumn;
    ABF_ALQRED_ENT_PII: TcxGridDBBandedColumn;
    ABF_BASDDS_ENT_PII: TcxGridDBBandedColumn;
    DIF_CODSIT_ENT_PII: TcxGridDBBandedColumn;
    DIF_BASICM_ENT_PII: TcxGridDBBandedColumn;
    DIF_ALQICM_ENT_PII: TcxGridDBBandedColumn;
    DIF_BASRET_ENT_PII: TcxGridDBBandedColumn;
    DIF_ALQRET_ENT_PII: TcxGridDBBandedColumn;
    DIF_IVA_ST_ENT_PII: TcxGridDBBandedColumn;
    DIF_ALQFCP_ENT_PII: TcxGridDBBandedColumn;
    DIF_ALQEFO_ENT_PII: TcxGridDBBandedColumn;
    DIF_ALQRED_ENT_PII: TcxGridDBBandedColumn;
    DIF_BASDDS_ENT_PII: TcxGridDBBandedColumn;
    ABF_CODSIT_SAI_NCO: TcxGridDBBandedColumn;
    ABF_BASICM_SAI_NCO: TcxGridDBBandedColumn;
    ABF_ALQICM_SAI_NCO: TcxGridDBBandedColumn;
    ABF_BASRET_SAI_NCO: TcxGridDBBandedColumn;
    ABF_ALQRET_SAI_NCO: TcxGridDBBandedColumn;
    ABF_IVA_ST_SAI_NCO: TcxGridDBBandedColumn;
    ABF_ALQFCP_SAI_NCO: TcxGridDBBandedColumn;
    ABF_ALQEFO_SAI_NCO: TcxGridDBBandedColumn;
    ABF_ALQRED_SAI_NCO: TcxGridDBBandedColumn;
    ABF_BASDDS_SAI_NCO: TcxGridDBBandedColumn;
    DIF_CODSIT_SAI_NCO: TcxGridDBBandedColumn;
    DIF_BASICM_SAI_NCO: TcxGridDBBandedColumn;
    DIF_ALQICM_SAI_NCO: TcxGridDBBandedColumn;
    DIF_BASRET_SAI_NCO: TcxGridDBBandedColumn;
    DIF_ALQRET_SAI_NCO: TcxGridDBBandedColumn;
    DIF_IVA_ST_SAI_NCO: TcxGridDBBandedColumn;
    DIF_ALQFCP_SAI_NCO: TcxGridDBBandedColumn;
    DIF_ALQEFO_SAI_NCO: TcxGridDBBandedColumn;
    DIF_ALQRED_SAI_NCO: TcxGridDBBandedColumn;
    DIF_BASDDS_SAI_NCO: TcxGridDBBandedColumn;
    ABF_CODSIT_SAI_CCO: TcxGridDBBandedColumn;
    ABF_BASICM_SAI_CCO: TcxGridDBBandedColumn;
    ABF_ALQICM_SAI_CCO: TcxGridDBBandedColumn;
    ABF_BASRET_SAI_CCO: TcxGridDBBandedColumn;
    ABF_ALQRET_SAI_CCO: TcxGridDBBandedColumn;
    ABF_IVA_ST_SAI_CCO: TcxGridDBBandedColumn;
    ABF_ALQFCP_SAI_CCO: TcxGridDBBandedColumn;
    ABF_ALQEFO_SAI_CCO: TcxGridDBBandedColumn;
    ABF_ALQRED_SAI_CCO: TcxGridDBBandedColumn;
    ABF_BASDDS_SAI_CCO: TcxGridDBBandedColumn;
    DIF_CODSIT_SAI_CCO: TcxGridDBBandedColumn;
    DIF_BASICM_SAI_CCO: TcxGridDBBandedColumn;
    DIF_ALQICM_SAI_CCO: TcxGridDBBandedColumn;
    DIF_BASRET_SAI_CCO: TcxGridDBBandedColumn;
    DIF_ALQRET_SAI_CCO: TcxGridDBBandedColumn;
    DIF_IVA_ST_SAI_CCO: TcxGridDBBandedColumn;
    DIF_ALQFCP_SAI_CCO: TcxGridDBBandedColumn;
    DIF_ALQEFO_SAI_CCO: TcxGridDBBandedColumn;
    DIF_ALQRED_SAI_CCO: TcxGridDBBandedColumn;
    DIF_BASDDS_SAI_CCO: TcxGridDBBandedColumn;
    ABF_CODSIT_SAI_CNC: TcxGridDBBandedColumn;
    ABF_BASICM_SAI_CNC: TcxGridDBBandedColumn;
    ABF_ALQICM_SAI_CNC: TcxGridDBBandedColumn;
    ABF_BASRET_SAI_CNC: TcxGridDBBandedColumn;
    ABF_ALQRET_SAI_CNC: TcxGridDBBandedColumn;
    ABF_IVA_ST_SAI_CNC: TcxGridDBBandedColumn;
    ABF_ALQFCP_SAI_CNC: TcxGridDBBandedColumn;
    ABF_ALQEFO_SAI_CNC: TcxGridDBBandedColumn;
    ABF_ALQRED_SAI_CNC: TcxGridDBBandedColumn;
    ABF_BASDDS_SAI_CNC: TcxGridDBBandedColumn;
    DIF_CODSIT_SAI_CNC: TcxGridDBBandedColumn;
    DIF_BASICM_SAI_CNC: TcxGridDBBandedColumn;
    DIF_ALQICM_SAI_CNC: TcxGridDBBandedColumn;
    DIF_BASRET_SAI_CNC: TcxGridDBBandedColumn;
    DIF_ALQRET_SAI_CNC: TcxGridDBBandedColumn;
    DIF_IVA_ST_SAI_CNC: TcxGridDBBandedColumn;
    DIF_ALQFCP_SAI_CNC: TcxGridDBBandedColumn;
    DIF_ALQEFO_SAI_CNC: TcxGridDBBandedColumn;
    DIF_ALQRED_SAI_CNC: TcxGridDBBandedColumn;
    DIF_BASDDS_SAI_CNC: TcxGridDBBandedColumn;
    ABF_CODSIT_SAI_SNA: TcxGridDBBandedColumn;
    ABF_BASICM_SAI_SNA: TcxGridDBBandedColumn;
    ABF_ALQICM_SAI_SNA: TcxGridDBBandedColumn;
    ABF_BASRET_SAI_SNA: TcxGridDBBandedColumn;
    ABF_ALQRET_SAI_SNA: TcxGridDBBandedColumn;
    ABF_IVA_ST_SAI_SNA: TcxGridDBBandedColumn;
    ABF_ALQFCP_SAI_SNA: TcxGridDBBandedColumn;
    ABF_ALQEFO_SAI_SNA: TcxGridDBBandedColumn;
    ABF_ALQRED_SAI_SNA: TcxGridDBBandedColumn;
    ABF_BASDDS_SAI_SNA: TcxGridDBBandedColumn;
    DIF_CODSIT_SAI_SNA: TcxGridDBBandedColumn;
    DIF_BASICM_SAI_SNA: TcxGridDBBandedColumn;
    DIF_ALQICM_SAI_SNA: TcxGridDBBandedColumn;
    DIF_BASRET_SAI_SNA: TcxGridDBBandedColumn;
    DIF_ALQRET_SAI_SNA: TcxGridDBBandedColumn;
    DIF_IVA_ST_SAI_SNA: TcxGridDBBandedColumn;
    DIF_ALQFCP_SAI_SNA: TcxGridDBBandedColumn;
    DIF_ALQEFO_SAI_SNA: TcxGridDBBandedColumn;
    DIF_ALQRED_SAI_SNA: TcxGridDBBandedColumn;
    DIF_BASDDS_SAI_SNA: TcxGridDBBandedColumn;
    ABF_CODSIT_SAI_CTA: TcxGridDBBandedColumn;
    ABF_BASICM_SAI_CTA: TcxGridDBBandedColumn;
    ABF_ALQICM_SAI_CTA: TcxGridDBBandedColumn;
    ABF_BASRET_SAI_CTA: TcxGridDBBandedColumn;
    ABF_ALQRET_SAI_CTA: TcxGridDBBandedColumn;
    ABF_IVA_ST_SAI_CTA: TcxGridDBBandedColumn;
    ABF_ALQFCP_SAI_CTA: TcxGridDBBandedColumn;
    ABF_ALQEFO_SAI_CTA: TcxGridDBBandedColumn;
    ABF_ALQRED_SAI_CTA: TcxGridDBBandedColumn;
    ABF_BASDDS_SAI_CTA: TcxGridDBBandedColumn;
    DIF_CODSIT_SAI_CTA: TcxGridDBBandedColumn;
    DIF_BASICM_SAI_CTA: TcxGridDBBandedColumn;
    DIF_ALQICM_SAI_CTA: TcxGridDBBandedColumn;
    DIF_BASRET_SAI_CTA: TcxGridDBBandedColumn;
    DIF_ALQRET_SAI_CTA: TcxGridDBBandedColumn;
    DIF_IVA_ST_SAI_CTA: TcxGridDBBandedColumn;
    DIF_ALQFCP_SAI_CTA: TcxGridDBBandedColumn;
    DIF_ALQEFO_SAI_CTA: TcxGridDBBandedColumn;
    DIF_ALQRED_SAI_CTA: TcxGridDBBandedColumn;
    DIF_BASDDS_SAI_CTA: TcxGridDBBandedColumn;
    ABF_CODSIT_SAI_PRU: TcxGridDBBandedColumn;
    ABF_BASICM_SAI_PRU: TcxGridDBBandedColumn;
    ABF_ALQICM_SAI_PRU: TcxGridDBBandedColumn;
    ABF_BASRET_SAI_PRU: TcxGridDBBandedColumn;
    ABF_ALQRET_SAI_PRU: TcxGridDBBandedColumn;
    ABF_IVA_ST_SAI_PRU: TcxGridDBBandedColumn;
    ABF_ALQFCP_SAI_PRU: TcxGridDBBandedColumn;
    ABF_ALQEFO_SAI_PRU: TcxGridDBBandedColumn;
    ABF_ALQRED_SAI_PRU: TcxGridDBBandedColumn;
    ABF_BASDDS_SAI_PRU: TcxGridDBBandedColumn;
    DIF_CODSIT_SAI_PRU: TcxGridDBBandedColumn;
    DIF_BASICM_SAI_PRU: TcxGridDBBandedColumn;
    DIF_ALQICM_SAI_PRU: TcxGridDBBandedColumn;
    DIF_BASRET_SAI_PRU: TcxGridDBBandedColumn;
    DIF_ALQRET_SAI_PRU: TcxGridDBBandedColumn;
    DIF_IVA_ST_SAI_PRU: TcxGridDBBandedColumn;
    DIF_ALQFCP_SAI_PRU: TcxGridDBBandedColumn;
    DIF_ALQEFO_SAI_PRU: TcxGridDBBandedColumn;
    DIF_ALQRED_SAI_PRU: TcxGridDBBandedColumn;
    DIF_BASDDS_SAI_PRU: TcxGridDBBandedColumn;
    ABF_CODSIT_SAI_IND: TcxGridDBBandedColumn;
    ABF_BASICM_SAI_IND: TcxGridDBBandedColumn;
    ABF_ALQICM_SAI_IND: TcxGridDBBandedColumn;
    ABF_BASRET_SAI_IND: TcxGridDBBandedColumn;
    ABF_ALQRET_SAI_IND: TcxGridDBBandedColumn;
    ABF_IVA_ST_SAI_IND: TcxGridDBBandedColumn;
    ABF_ALQFCP_SAI_IND: TcxGridDBBandedColumn;
    ABF_ALQEFO_SAI_IND: TcxGridDBBandedColumn;
    ABF_ALQRED_SAI_IND: TcxGridDBBandedColumn;
    ABF_BASDDS_SAI_IND: TcxGridDBBandedColumn;
    DIF_CODSIT_SAI_IND: TcxGridDBBandedColumn;
    DIF_BASICM_SAI_IND: TcxGridDBBandedColumn;
    DIF_ALQICM_SAI_IND: TcxGridDBBandedColumn;
    DIF_BASRET_SAI_IND: TcxGridDBBandedColumn;
    DIF_ALQRET_SAI_IND: TcxGridDBBandedColumn;
    DIF_IVA_ST_SAI_IND: TcxGridDBBandedColumn;
    DIF_ALQFCP_SAI_IND: TcxGridDBBandedColumn;
    DIF_ALQEFO_SAI_IND: TcxGridDBBandedColumn;
    DIF_ALQRED_SAI_IND: TcxGridDBBandedColumn;
    DIF_BASDDS_SAI_IND: TcxGridDBBandedColumn;
    ABF_CODSIT_SAI_TRS: TcxGridDBBandedColumn;
    ABF_BASICM_SAI_TRS: TcxGridDBBandedColumn;
    ABF_ALQICM_SAI_TRS: TcxGridDBBandedColumn;
    ABF_BASRET_SAI_TRS: TcxGridDBBandedColumn;
    ABF_ALQRET_SAI_TRS: TcxGridDBBandedColumn;
    ABF_IVA_ST_SAI_TRS: TcxGridDBBandedColumn;
    ABF_ALQFCP_SAI_TRS: TcxGridDBBandedColumn;
    ABF_ALQEFO_SAI_TRS: TcxGridDBBandedColumn;
    ABF_ALQRED_SAI_TRS: TcxGridDBBandedColumn;
    ABF_BASDDS_SAI_TRS: TcxGridDBBandedColumn;
    DIF_CODSIT_SAI_TRS: TcxGridDBBandedColumn;
    DIF_BASICM_SAI_TRS: TcxGridDBBandedColumn;
    DIF_ALQICM_SAI_TRS: TcxGridDBBandedColumn;
    DIF_BASRET_SAI_TRS: TcxGridDBBandedColumn;
    DIF_ALQRET_SAI_TRS: TcxGridDBBandedColumn;
    DIF_IVA_ST_SAI_TRS: TcxGridDBBandedColumn;
    DIF_ALQFCP_SAI_TRS: TcxGridDBBandedColumn;
    DIF_ALQEFO_SAI_TRS: TcxGridDBBandedColumn;
    DIF_ALQRED_SAI_TRS: TcxGridDBBandedColumn;
    DIF_BASDDS_SAI_TRS: TcxGridDBBandedColumn;
    ABF_ALQIED_ENT_PEF: TcxGridDBBandedColumn;
    DIF_ALQIED_ENT_PEF: TcxGridDBBandedColumn;
    ABF_ALQIED_ENT_PEJ: TcxGridDBBandedColumn;
    DIF_ALQIED_ENT_PEJ: TcxGridDBBandedColumn;
    ABF_ALQIED_ENT_PER: TcxGridDBBandedColumn;
    DIF_ALQIED_ENT_PER: TcxGridDBBandedColumn;
    ABF_ALQIED_ENT_PES: TcxGridDBBandedColumn;
    DIF_ALQIED_ENT_PES: TcxGridDBBandedColumn;
    ABF_ALQIED_ENT_PSI: TcxGridDBBandedColumn;
    DIF_ALQIED_ENT_PSI: TcxGridDBBandedColumn;
    ABF_ALQIED_ENT_PII: TcxGridDBBandedColumn;
    DIF_ALQIED_ENT_PII: TcxGridDBBandedColumn;
    ABF_ALQIED_SAI_NCO: TcxGridDBBandedColumn;
    DIF_ALQIED_SAI_NCO: TcxGridDBBandedColumn;
    ABF_ALQIED_SAI_CCO: TcxGridDBBandedColumn;
    DIF_ALQIED_SAI_CCO: TcxGridDBBandedColumn;
    ABF_ALQIED_SAI_CNC: TcxGridDBBandedColumn;
    DIF_ALQIED_SAI_CNC: TcxGridDBBandedColumn;
    ABF_ALQIED_SAI_SNA: TcxGridDBBandedColumn;
    DIF_ALQIED_SAI_SNA: TcxGridDBBandedColumn;
    ABF_ALQIED_SAI_CTA: TcxGridDBBandedColumn;
    DIF_ALQIED_SAI_CTA: TcxGridDBBandedColumn;
    ABF_ALQIED_SAI_PRU: TcxGridDBBandedColumn;
    DIF_ALQIED_SAI_PRU: TcxGridDBBandedColumn;
    ABF_ALQIED_SAI_IND: TcxGridDBBandedColumn;
    DIF_ALQIED_SAI_IND: TcxGridDBBandedColumn;
    ABF_ALQIED_SAI_TRS: TcxGridDBBandedColumn;
    DIF_ALQIED_SAI_TRS: TcxGridDBBandedColumn;
    ESTADO: TcxGridDBBandedColumn;
    cxbDadosPAGINA: TcxGridDBBandedColumn;
    cxlDados: TcxGridLevel;
    pnlLegendas: TPanel;
    lblDivergencias: TLabel;
    shpDivergencias: TShape;
    dtsDados: TDataSource;
    ABF_CODABF: TcxGridDBBandedColumn;
    ABF_MENS01_SAI_NCO: TcxGridDBBandedColumn;
    ABF_MENS02_SAI_NCO: TcxGridDBBandedColumn;
    ABF_MENS01_SAI_CCO: TcxGridDBBandedColumn;
    ABF_MENS02_SAI_CCO: TcxGridDBBandedColumn;
    ABF_MENS01_SAI_CNC: TcxGridDBBandedColumn;
    ABF_MENS02_SAI_CNC: TcxGridDBBandedColumn;
    ABF_MENS01_SAI_CTA: TcxGridDBBandedColumn;
    ABF_MENS02_SAI_CTA: TcxGridDBBandedColumn;
    ABF_MENS01_SAI_PRU: TcxGridDBBandedColumn;
    ABF_MENS02_SAI_PRU: TcxGridDBBandedColumn;
    ABF_MENS01_SAI_SNA: TcxGridDBBandedColumn;
    ABF_MENS02_SAI_SNA: TcxGridDBBandedColumn;
    ABF_MENS01_SAI_IND: TcxGridDBBandedColumn;
    ABF_MENS02_SAI_IND: TcxGridDBBandedColumn;
    ABF_MENS01_SAI_TRS: TcxGridDBBandedColumn;
    ABF_MENS02_SAI_TRS: TcxGridDBBandedColumn;
    ABF_MENS01_SAI_ORG: TcxGridDBBandedColumn;
    ABF_MENS02_SAI_ORG: TcxGridDBBandedColumn;
    DIF_MENS02_SAI_NCO: TcxGridDBBandedColumn;
    DIF_MENS01_SAI_CCO: TcxGridDBBandedColumn;
    DIF_MENS01_SAI_NCO: TcxGridDBBandedColumn;
    DIF_MENS02_SAI_CCO: TcxGridDBBandedColumn;
    DIF_MENS01_SAI_CNC: TcxGridDBBandedColumn;
    DIF_MENS02_SAI_CNC: TcxGridDBBandedColumn;
    DIF_MENS01_SAI_CTA: TcxGridDBBandedColumn;
    DIF_MENS02_SAI_CTA: TcxGridDBBandedColumn;
    DIF_MENS01_SAI_PRU: TcxGridDBBandedColumn;
    DIF_MENS02_SAI_PRU: TcxGridDBBandedColumn;
    DIF_MENS01_SAI_SNA: TcxGridDBBandedColumn;
    DIF_MENS02_SAI_SNA: TcxGridDBBandedColumn;
    DIF_MENS01_SAI_IND: TcxGridDBBandedColumn;
    DIF_MENS02_SAI_IND: TcxGridDBBandedColumn;
    DIF_MENS01_SAI_TRS: TcxGridDBBandedColumn;
    DIF_MENS02_SAI_TRS: TcxGridDBBandedColumn;
    DIF_MENS01_SAI_ORG: TcxGridDBBandedColumn;
    DIF_MENS02_SAI_ORG: TcxGridDBBandedColumn;
    ABF_CODBEN_ENT_PEF: TcxGridDBBandedColumn;
    ABF_CODBEN_ENT_PEJ: TcxGridDBBandedColumn;
    ABF_CODBEN_ENT_PER: TcxGridDBBandedColumn;
    ABF_CODBEN_SAI_NCO: TcxGridDBBandedColumn;
    ABF_CODBEN_SAI_CCO: TcxGridDBBandedColumn;
    ABF_CODBEN_SAI_CNC: TcxGridDBBandedColumn;
    ABF_CODBEN_SAI_SNA: TcxGridDBBandedColumn;
    ABF_CODBEN_SAI_CTA: TcxGridDBBandedColumn;
    ABF_CODBEN_SAI_PRU: TcxGridDBBandedColumn;
    ABF_CODBEN_SAI_IND: TcxGridDBBandedColumn;
    ABF_CODBEN_SAI_TRS: TcxGridDBBandedColumn;
    ABF_CODBEN_ENT_PII: TcxGridDBBandedColumn;
    ABF_CODBEN_ENT_PSI: TcxGridDBBandedColumn;
    ABF_CODBEN_ENT_PES: TcxGridDBBandedColumn;
    DIF_CODBEN_ENT_PEF: TcxGridDBBandedColumn;
    DIF_CODBEN_ENT_PEJ: TcxGridDBBandedColumn;
    DIF_CODBEN_ENT_PER: TcxGridDBBandedColumn;
    DIF_CODBEN_SAI_NCO: TcxGridDBBandedColumn;
    DIF_CODBEN_SAI_CCO: TcxGridDBBandedColumn;
    DIF_CODBEN_SAI_CNC: TcxGridDBBandedColumn;
    DIF_CODBEN_SAI_SNA: TcxGridDBBandedColumn;
    DIF_CODBEN_SAI_CTA: TcxGridDBBandedColumn;
    DIF_CODBEN_SAI_PRU: TcxGridDBBandedColumn;
    DIF_CODBEN_SAI_IND: TcxGridDBBandedColumn;
    DIF_CODBEN_ENT_PII: TcxGridDBBandedColumn;
    DIF_CODBEN_SAI_TRS: TcxGridDBBandedColumn;
    DIF_CODBEN_ENT_PSI: TcxGridDBBandedColumn;
    DIF_CODBEN_ENT_PES: TcxGridDBBandedColumn;
    procedure cxbDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxbDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxbDadosCustomDrawGroupCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableCellViewInfo;
      var ADone: Boolean);


  private
    { Private declarations }
    function fFieldTemDivergencia(AViewInfo: TcxGridTableDataCellViewInfo; RecordIndex: integer; blnInfGerais: Boolean = False):Boolean;
    function fDecideCorFonte(strLocal: String): TColor;
    function fEstadoTrocaCor(AEstado: String): Boolean;

  protected
    ProcessaImendesRetorno: TProcessaImendesRetorno;
  public
    frmPai: TForm;
    GridDinamico : TGridDinamico;
    btnSair: TBitBtnLocked;
    procedure ExpandAll;
    procedure CollapseAll;
    procedure pIniciaAlteracao;
    procedure pFinalizaAlteracao;
    procedure pDestroy;
    procedure pSetFocusGrid;
    Class Function fCriaFrameResultado(frmDestino: TForm; tbsPagina: TWinControl; AProcessaImendesRetorno: TProcessaImendesRetorno;
    ADtsDados: TDataSource): TframeAbreviacoesIcms;
    procedure pExibirLocal(blnExibirLocal: Boolean);

    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, iMendes.Constantes, iMendes.Functions;

{$R *.dfm}

{ TfraImendesResultado }


procedure TframeAbreviacoesIcms.CollapseAll;
begin
  cxbDados.ViewData.Collapse(False);
end;

procedure TframeAbreviacoesIcms.ExpandAll;
begin
  cxbDados.ViewData.Expand(False);
end;

function TframeAbreviacoesIcms.fFieldTemDivergencia(AViewInfo: TcxGridTableDataCellViewInfo; RecordIndex: integer; blnInfGerais: Boolean = False):Boolean;
var cxColumnDiff: TcxGridDBBandedColumn;
    strFiledDiff: String;
var Grid: TcxGridDBBandedTableView;
Begin
  Result := False;
  strFiledDiff := TcxGridItemDBDataBinding(AViewInfo.Item.DataBinding).FieldName;
  Grid := cxbDados;

  strFiledDiff := AnsiReplaceStr(strFiledDiff, 'ABF_', 'DIF_');

  cxColumnDiff := Grid.GetColumnByFieldName(strFiledDiff);

  If Assigned(cxColumnDiff) Then
    Result := VarToStr(Grid.DataController.Values[RecordIndex, cxColumnDiff.Index]) = 'S';
End;

procedure TframeAbreviacoesIcms.pDestroy;
var i: integer;
begin
  For i := 0 To High(GridDinamico.ArrBandPerfil) do
    FreeAndNil(GridDinamico.ArrBandPerfil[i]);

  SetLength(GridDinamico.ArrBandPerfil, 0);
  cxbDados.ClearItems;

  FreeAndNil(GridDinamico);
end;

procedure TframeAbreviacoesIcms.pFinalizaAlteracao;
begin
  cxgDados.EndUpdate;
end;

procedure TframeAbreviacoesIcms.pIniciaAlteracao;
begin
  cxgDados.BeginUpdate;
end;

procedure TframeAbreviacoesIcms.pSetFocusGrid;
begin
  pSetFocus(cxgDados);
end;

procedure TframeAbreviacoesIcms.pExibirLocal(blnExibirLocal: Boolean);
begin
  if LOCAL.Visible = blnExibirLocal then
    Exit;

  LOCAL.Visible := blnExibirLocal;

  if blnExibirLocal then
    cxbDados.Bands[0].Width :=  cxbDados.Bands[0].Width + LOCAL.Width
  else
    cxbDados.Bands[0].Width :=  cxbDados.Bands[0].Width - LOCAL.Width
end;

Class Function TframeAbreviacoesIcms.fCriaFrameResultado(frmDestino: TForm; tbsPagina: TWinControl; AProcessaImendesRetorno: TProcessaImendesRetorno;ADtsDados: TDataSource): TframeAbreviacoesIcms;
Begin
  Result := TframeAbreviacoesIcms.Create(frmDestino);
  Result.frmPai    := frmDestino;
  Result.Parent    := tbsPagina;
  Result.Top       := 0;
  Result.TabOrder  := 0;
  Result.cxbDados.DataController.DataSource := ADtsDados;

  Result.dtsDados := ADtsDados;

  Result.ProcessaImendesRetorno := AProcessaImendesRetorno;

  Result.GridDinamico := TGridDinamico.Create;
  Result.GridDinamico.cxbGrid := Result.cxbDados;
  Result.GridDinamico.pCriaEstruturas;
End;

procedure TframeAbreviacoesIcms.cxbDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  ACanvas.Font.Color :=  fDecideCorFonte(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, LOCAL.Index]));
  If fEstadoTrocaCor(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, ESTADO.Index])) then
    ACanvas.Brush.Color := $EEEEAF;

  If fFieldTemDivergencia(AViewInfo, AViewInfo.GridRecord.RecordIndex) Then
  Begin
    ACanvas.Brush.Color := clRed;
    ACanvas.Font.Color := clwhite;
  End;
end;

procedure TframeAbreviacoesIcms.cxbDadosCustomDrawGroupCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
  var lLineRect  : TRect;
      strCodAbf: String;
begin
  inherited;
  ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];

  ACanvas.FillRect(AViewInfo.Bounds, AViewInfo.Params.Color);
  ACanvas.Font.Style := ACanvas.Font.Style;
  AViewInfo.Params.Font := ACanvas.Font;
  ACanvas.DrawTexT(AViewInfo.Text, AViewInfo.TextBounds, cxAlignLeft + cxAlignVCenter);
  AViewInfo.Params.Font.Style := AViewInfo.Params.Font.Style + [fsBold];
  lLineRect := AViewInfo.TextBounds;
  lLineRect.Left := 500;
  ACanvas.FillRect(lLineRect, AViewInfo.Params.Color);
  strCodAbf := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, ABF_CODABF.Index]);

  strCodAbf := 'Abreviação: ' + strCodAbf;

  If strCodAbf <> '' Then
    ACanvas.TextOut(lLineRect.Left, lLineRect.Top, strCodAbf)
  Else
    ACanvas.TextOut(lLineRect.Left, lLineRect.Top, strCodAbf);

  ADone := True;
end;

procedure TframeAbreviacoesIcms.cxbDadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_ESCAPE Then
  Begin
    If Assigned(btnSair) Then
      btnSair.Click;
    Exit;
  End;
end;

function TframeAbreviacoesIcms.fDecideCorFonte(strLocal: String): TColor;
Begin
  Result := clBlue
End;

function TframeAbreviacoesIcms.fEstadoTrocaCor(AEstado: String): Boolean;
var  index: integer;
begin
  index := AnsiIndexStr(UpperCase(AEstado), UNIDESFEDERATIVA);
  result := Not (index mod 2 = 0);
end;

{ TGridDinamico }

procedure TGridDinamico.pAddFieldCST(Perfil: TPerfil; BandPai: TcxGridband);
  var
    cxColum: TcxGridDBBandedColumn;
begin
  cxColum := cxbGrid.GetColumnByFieldName('ABF_CODSIT' +  fConvertConfPerfilToAliasFieldString(Perfil));
  cxColum.Position.BandIndex := BandPai.Index;
  cxColum.Caption := 'CST';
  cxColum.Width := 25;
end;

procedure TGridDinamico.pAddFieldsCODBEN(Perfil: TPerfil; BandPai: TcxGridband);
var
  cxABF_CODBEN: TcxGridDBBandedColumn;
begin
  cxABF_CODBEN := cxbGrid.GetColumnByFieldName('ABF_CODBEN' +  fConvertConfPerfilToAliasFieldString(Perfil));
  cxABF_CODBEN.Position.BandIndex := BandPai.Index;
  cxABF_CODBEN.Caption := 'Código Benefício Fiscal';
  cxABF_CODBEN.Options.Sorting := False;

  cxABF_CODBEN.Width := 125;
end;

procedure TGridDinamico.pAddFieldsDifal(Perfil: TPerfil; BandPai: TcxGridband);
  var
    cxColumABF_ALQEFO: TcxGridDBBandedColumn;
    cxColumABF_ALQIED: TcxGridDBBandedColumn;
    cxColumABF_BASDDS: TcxGridDBBandedColumn;
begin
  cxColumABF_ALQEFO := cxbGrid.GetColumnByFieldName('ABF_ALQEFO' +  fConvertConfPerfilToAliasFieldString(Perfil));
  cxColumABF_ALQEFO.Position.BandIndex := BandPai.Index;
  cxColumABF_ALQEFO.Caption := '% Alq.Efet.Ori.';
  cxColumABF_ALQEFO.OnGetDisplayText := AliquotaGetDisplayText;
  cxColumABF_ALQEFO.Options.Sorting := False;

  cxColumABF_ALQIED := cxbGrid.GetColumnByFieldName('ABF_ALQIED' +  fConvertConfPerfilToAliasFieldString(Perfil));
  cxColumABF_ALQIED.Position.BandIndex := BandPai.Index;
  cxColumABF_ALQIED.Caption := 'Aliq.Int.Estado.Dest';
  cxColumABF_ALQIED.OnGetDisplayText := AliquotaGetDisplayText;
  cxColumABF_ALQIED.Options.Sorting := False;

  cxColumABF_BASDDS := cxbGrid.GetColumnByFieldName('ABF_BASDDS' +  fConvertConfPerfilToAliasFieldString(Perfil));
  cxColumABF_BASDDS.Position.BandIndex := BandPai.Index;
  cxColumABF_BASDDS.Caption := '%Base Dest.';
  cxColumABF_BASDDS.OnGetDisplayText := AliquotaGetDisplayText;
  cxColumABF_BASDDS.Options.Sorting := False;

  cxColumABF_BASDDS.Width := 85;
  cxColumABF_ALQIED.Width := 125;
  cxColumABF_ALQEFO.Width := 90;
end;

procedure TGridDinamico.AliquotaGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
Begin
  If AText = '' Then
    AText := '0';
  AText := FormatFloat('0.00', StrToFloat(AText));
End;

procedure TGridDinamico.IVAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
Begin
  If AText = '' Then
    AText := '0';
  AText := FormatFloat('0.0000', StrToFloat(AText));
End;

procedure TGridDinamico.pAddFieldsFCP(Perfil: TPerfil; BandPai: TcxGridband);
  var
    cxColum: TcxGridDBBandedColumn;
begin
  cxColum := cxbGrid.GetColumnByFieldName('ABF_ALQFCP' +  fConvertConfPerfilToAliasFieldString(Perfil));
  cxColum.Position.BandIndex := BandPai.Index;
  cxColum.Caption := 'FCP';
  cxColum.OnGetDisplayText := AliquotaGetDisplayText;
End;

procedure TGridDinamico.pAddFieldsICMS(Perfil: TPerfil; BandPai: TcxGridband);
  var
    cxColum: TcxGridDBBandedColumn;
begin
  cxColum := cxbGrid.GetColumnByFieldName('ABF_BASICM' +  fConvertConfPerfilToAliasFieldString(Perfil));
  cxColum.Position.BandIndex := BandPai.Index;
  cxColum.Caption := '%Base';
  cxColum.OnGetDisplayText := AliquotaGetDisplayText;
  cxColum.Options.Sorting := False;

  cxColum := cxbGrid.GetColumnByFieldName('ABF_ALQICM' +  fConvertConfPerfilToAliasFieldString(Perfil));
  cxColum.Position.BandIndex := BandPai.Index;
  cxColum.Caption := '%Alq';
  cxColum.OnGetDisplayText :=  AliquotaGetDisplayText;
  cxColum.Options.Sorting := False;
end;

procedure TGridDinamico.pAddFieldsMensagens(Perfil: TPerfil;
  BandPai: TcxGridband);
var
  cxABF_MENS01,
  cxABF_MENS02: TcxGridDBBandedColumn;
begin
  cxABF_MENS01 := cxbGrid.GetColumnByFieldName('ABF_MENS01' +  fConvertConfPerfilToAliasFieldString(Perfil));
  cxABF_MENS01.Position.BandIndex := BandPai.Index;
  cxABF_MENS01.Caption := 'Mensagem 01';
  cxABF_MENS01.Options.Sorting := False;

  cxABF_MENS02 := cxbGrid.GetColumnByFieldName('ABF_MENS02' +  fConvertConfPerfilToAliasFieldString(Perfil));
  cxABF_MENS02.Position.BandIndex := BandPai.Index;
  cxABF_MENS02.Caption := 'Mensagem 02';
  cxABF_MENS02.Options.Sorting := False;

  cxABF_MENS01.Width := 125;
  cxABF_MENS02.Width := 125;
end;

procedure TGridDinamico.pAddFieldsST(Perfil: TPerfil; BandPai: TcxGridband);
var
    cxABF_BASRET: TcxGridDBBandedColumn;
    cxABF_ALQRET: TcxGridDBBandedColumn;
    cxABF_ALQRED: TcxGridDBBandedColumn;
    cxABF_IVA_ST: TcxGridDBBandedColumn;
begin
  cxABF_BASRET := cxbGrid.GetColumnByFieldName('ABF_BASRET' +  fConvertConfPerfilToAliasFieldString(Perfil));
  cxABF_BASRET.Position.BandIndex := BandPai.Index;
  cxABF_BASRET.Caption := '%Base';
  cxABF_BASRET.OnGetDisplayText := AliquotaGetDisplayText;
  cxABF_BASRET.Options.Sorting := False;

  cxABF_ALQRET := cxbGrid.GetColumnByFieldName('ABF_ALQRET' +  fConvertConfPerfilToAliasFieldString(Perfil));
  cxABF_ALQRET.Position.BandIndex := BandPai.Index;
  cxABF_ALQRET.Caption := '%Alq Int.';
  cxABF_ALQRET.OnGetDisplayText := AliquotaGetDisplayText;
  cxABF_ALQRET.Options.Sorting := False;

  cxABF_ALQRED := cxbGrid.GetColumnByFieldName('ABF_ALQRED' +  fConvertConfPerfilToAliasFieldString(Perfil));
  cxABF_ALQRED.Position.BandIndex := BandPai.Index;
  cxABF_ALQRED.Caption := '%Alq. Red.';
  cxABF_ALQRED.OnGetDisplayText := AliquotaGetDisplayText;
  cxABF_ALQRED.Options.Sorting := False;

  cxABF_IVA_ST := cxbGrid.GetColumnByFieldName('ABF_IVA_ST' +  fConvertConfPerfilToAliasFieldString(Perfil));
  cxABF_IVA_ST.Position.BandIndex := BandPai.Index;
  cxABF_IVA_ST.Caption := 'IVA';
  cxABF_IVA_ST.OnGetDisplayText := IVAGetDisplayText;
  cxABF_IVA_ST.Options.Sorting := False;

  cxABF_IVA_ST.Width := 50;
  cxABF_ALQRED.Width := 70;
  cxABF_ALQRET.Width := 65;
  cxABF_BASRET.Width := 60;
end;

procedure TGridDinamico.pAjustaArrBandPerfil(FilterPerfis: TConjPerfis; chkListPrefil: TcxCheckListBox);
var BandPerfil: TBandPerfil;
    qry: TUniQuery;
begin
  cxbGrid.BeginUpdate;
  chkListPrefil.Clear;
  qry := fCriaQuery();
  Try
    For BandPerfil in ArrBandPerfil do
    Begin
      BandPerfil.pChangeVisible(BandPerfil.Perfil in  (FilterPerfis));
      If BandPerfil.Visible Then
      Begin
        chkListPrefil.AddItem(BandPerfil.strDescri);
        chkListPrefil.Items[chkListPrefil.Count -1].ItemObject := BandPerfil;
        chkListPrefil.Items[chkListPrefil.Count -1].Checked := True;
      End;
    End;
  Finally
    FreeAndNil(qry);
  End;
  cxbGrid.EndUpdate;
End;

procedure TGridDinamico.pCriaEstruturaInfGerais;
  var Band : TcxGridband;
      objBandInfGer: TBandPerfil;
begin
  Band := cxbGrid.Bands.Add;
  Band.Caption := 'Informações Gerais';
  Band.Width := 337;
  {Cria o array para poder trocar a visibilidade no grid de acordo com o que estiver marcado no clsFilterPerfil}
  objBandInfGer := TBandPerfil.Create;
  ArrBandPerfil[0] := objBandInfGer;
  ArrBandPerfil[0].Visible := True;
  ArrBandPerfil[0].Band := Band;
  ArrBandPerfil[0].Perfil := cjpIndef;
  ArrBandPerfil[0].strDescri := Band.Caption;
end;

procedure TGridDinamico.pCriaEstruturaPerfil(Perfil: TPerfil; index: integer);
var Band,
    BandIcms,
    BandST,
    BandFCP,
    BandCST,
    BandDifal,
    BandMensagem,
    BandCODBEN: TcxGridband;
    BandPerfil: TBandPerfil;
    qry: TUniQuery;
begin
  qry := fCriaQuery();

  Band := cxbGrid.Bands.Add;
  Band.Caption := fConvertPerfilToDescricao(Perfil);
  Band.Width := 860;

  {Cria o array para poder trocar a visibilidade no grid de acordo com o que estiver marcado no clsFilterPerfil}
  BandPerfil := TBandPerfil.Create;
  ArrBandPerfil[index] := BandPerfil;
  ArrBandPerfil[index].Visible := True;
  ArrBandPerfil[index].Band := Band;
  ArrBandPerfil[index].Perfil := Perfil;
  ArrBandPerfil[index].strDescri := fConvertPerfilToDescricaoComCaracteristica(False, Perfil, qry);

  BandCST := Band.Bands.Add;
  BandCST.Position.BandIndex := Band.Index;
  BandCST.Position.ColIndex := 0;
  BandCST.Caption := 'CST';
  pAddFieldCST(Perfil, BandCST);

  BandIcms := Band.Bands.Add;
  BandIcms.Position.BandIndex := Band.Index;
  BandIcms.Position.ColIndex := 1;
  BandIcms.Caption := 'ICMS';
  pAddFieldsICMS(Perfil, BandIcms);

  BandST := Band.Bands.Add;
  BandST.Position.BandIndex := Band.Index;
  BandST.Position.ColIndex := 2;
  BandST.Caption := 'Substituição Tributária' ;
  pAddFieldsST(Perfil, BandST);

  BandDifal := Band.Bands.Add;
  BandDifal.Position.BandIndex := Band.Index;
  BandDifal.Position.ColIndex := 3;
  BandDifal.Caption := 'Difal';
  pAddFieldsDifal(Perfil, BandDifal);

  BandFCP := Band.Bands.Add;
  BandFCP.Position.BandIndex := Band.Index;
  BandFCP.Position.ColIndex := 4;
  BandFCP.Caption := 'FCP' ;
  pAddFieldsFCP(Perfil, BandFCP);

  if Pos(fConvertConfPerfilToString(Perfil), 'CNC_SNA_IND_TRS_NCO_CCO_CTA_PRU') > 0 then
  begin
    BandMensagem := Band.Bands.Add;
    BandMensagem.Position.BandIndex := Band.Index;
    BandMensagem.Position.ColIndex := 5;
    BandMensagem.Caption := 'Mensagens' ;
    pAddFieldsMensagens(Perfil, BandMensagem);

    BandMensagem.Width := 250;
  end;

  BandFCP.Width := 33;
  BandDifal.Width := 300;
  BandST.Width := 245;
  BandCST.Width := 33;

  if fCfgSis('OBRBEN', varBoolean) then
  begin
    BandCODBEN := Band.Bands.Add;
    BandCODBEN.Position.BandIndex := Band.Index;
    BandCODBEN.Position.ColIndex := 4;
    BandCODBEN.Caption := 'Código Benefício Fiscal' ;
    pAddFieldsCODBEN(Perfil, BandCODBEN);
  end;
end;

procedure TGridDinamico.pCriaEstruturas;
var perfil :Tperfil;
    conj   :TConjPerfis;
    i: integer;
begin
  cxbGrid.BeginUpdate;
  SetLength(ArrBandPerfil, 15);
  i:= 0;
  Try
    pCriaEstruturaInfGerais();

    conj := [cjpPEF, cjpPEJ, cjpPER, cjpPES, cjpPSI, cjpPII, cjpNCO, cjpCCO, cjpCNC, cjpSNA, cjpCTA, cjpPRU ,cjpIND, cjpTRS];
    for perfil in conj do
    Begin
      pCriaEstruturaPerfil(perfil, i+1);
      inc(i);
    End;
  Finally
    cxbGrid.EndUpdate;
  End;
end;

{ TBandPerfil }

procedure TBandPerfil.pChangeVisible(AValue: Boolean);
begin
  Self.Visible := AValue;
  Self.Band.Visible := AValue;
end;

end.
