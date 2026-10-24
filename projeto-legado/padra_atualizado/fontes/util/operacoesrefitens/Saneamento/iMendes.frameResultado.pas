unit iMendes.frameResultado;

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
    procedure pAddFieldInfGerais(BandPai: TcxGridband);

    procedure pAddFieldsICMS(Perfil: TPerfil; BandPai: TcxGridband);
    procedure pAddFieldsST(Perfil: TPerfil; BandPai: TcxGridband);
    procedure pAddFieldsDifal(Perfil: TPerfil; BandPai: TcxGridband);
    procedure pAddFieldsFCP(Perfil: TPerfil; BandPai: TcxGridband);
    procedure AliquotaGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
    procedure IVAGetDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string);
  End;


  TfraImendesResultado = class(TFrame)
    cxgDados: TcxGrid;
    cxbDados: TcxGridDBBandedTableView;
    IME_CODITE: TcxGridDBBandedColumn;
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
    IME_GERABF: TcxGridDBBandedColumn;
    IME_SEMIME: TcxGridDBBandedColumn;
    IME_RETPAR: TcxGridDBBandedColumn;
    DIF_PISCOF: TcxGridDBBandedColumn;
    DIF_IPI: TcxGridDBBandedColumn;
    DIF_INF_GERAIS: TcxGridDBBandedColumn;
    IME_DIFICM: TcxGridDBBandedColumn;
    cxbDadosPAGINA: TcxGridDBBandedColumn;
    cxlDados: TcxGridLevel;
    Panel3: TPanel;
    Label4: TLabel;
    Shape5: TShape;
    Label7: TLabel;
    Shape6: TShape;
    dtsDados: TDataSource;
    DIF_ITE_CLAIPI: TcxGridDBBandedColumn;
    DIF_ITE_CDCEST: TcxGridDBBandedColumn;
    DIF_ITE_CODLUB: TcxGridDBBandedColumn;
    DIF_ITE_EXCIPI: TcxGridDBBandedColumn;
    ITE_CODBAR: TcxGridDBBandedColumn;
    Shape1: TShape;
    Label1: TLabel;
    TEM_MENSAGEM_PEF: TcxGridDBBandedColumn;
    TEM_MENSAGEM_PER: TcxGridDBBandedColumn;
    TEM_MENSAGEM_PES: TcxGridDBBandedColumn;
    TEM_MENSAGEM_PSI: TcxGridDBBandedColumn;
    TEM_MENSAGEM_PII: TcxGridDBBandedColumn;
    TEM_MENSAGEM_NCO: TcxGridDBBandedColumn;
    TEM_MENSAGEM_CCO: TcxGridDBBandedColumn;
    TEM_MENSAGEM_CNC: TcxGridDBBandedColumn;
    TEM_MENSAGEM_SNA: TcxGridDBBandedColumn;
    TEM_MENSAGEM_CTA: TcxGridDBBandedColumn;
    TEM_MENSAGEM_PRU: TcxGridDBBandedColumn;
    TEM_MENSAGEM_IND: TcxGridDBBandedColumn;
    TEM_MENSAGEM_PEJ: TcxGridDBBandedColumn;
    TEM_MENSAGEM_TRS: TcxGridDBBandedColumn;
    ITE_CLAIPI_: TcxGridDBBandedColumn;
    ITE_CDCEST_: TcxGridDBBandedColumn;
    IME_EXCIPI_: TcxGridDBBandedColumn;
    ITE_CODLUB_: TcxGridDBBandedColumn;
    Shape2: TShape;
    Label2: TLabel;
    Label5: TLabel;
    Shape3: TShape;
    IME_SEMEAN: TcxGridDBBandedColumn;
    Shape4: TShape;
    Label3: TLabel;
    procedure cxbDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxbDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxbDadosCustomDrawGroupCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableCellViewInfo;
      var ADone: Boolean);
    procedure IME_CODITEGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure TEM_MENSAGEM_PEFPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure TEM_MENSAGEM_PEFGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure TEM_MENSAGEM_PEJPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure TEM_MENSAGEM_PERPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure TEM_MENSAGEM_PESPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure TEM_MENSAGEM_PSIPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure TEM_MENSAGEM_PIIPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure TEM_MENSAGEM_NCOPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure TEM_MENSAGEM_CCOPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure TEM_MENSAGEM_CNCPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure TEM_MENSAGEM_SNAPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure TEM_MENSAGEM_CTAPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure TEM_MENSAGEM_PRUPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure TEM_MENSAGEM_INDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure TEM_MENSAGEM_TRSPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);


  private
    { Private declarations }
    function fFieldTemDivergencia(AViewInfo: TcxGridTableDataCellViewInfo; RecordIndex: integer; blnInfGerais: Boolean = False):Boolean;
    function fRetFieldCorreto(strField: String): String;

    function fDecideCorFonte(strLocal: String): TColor;
    function fEstadoTrocaCor(AEstado: String): Boolean;
    procedure pCarregaDadosAdcionais(APerfil: String;
                                 var AAmparoLegal: String;
                                 var ANomeProtocolo: String;
                                 var ADescProtocolo: String;
                                 var ANomeConvenio: String;
                                 var ADescConvenio: String);
    procedure pCarregaInfAd(APerfil: String);




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
    ADtsDados: TDataSource): TfraImendesResultado;


    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, iMendes.Constantes, iMendes.Functions,
  untIformacoesAdicionaisICMS;

{$R *.dfm}

{ TfraImendesResultado }


procedure TfraImendesResultado.CollapseAll;
begin
  cxbDados.ViewData.Collapse(False);
end;

procedure TfraImendesResultado.ExpandAll;
begin
  cxbDados.ViewData.Expand(False);

end;

function TfraImendesResultado.fRetFieldCorreto(strField: String): String;
begin
  Result :=  strField;
  If strField = 'ITE_CLAIPI_' Then
    Result := 'DIF_ITE_CLAIPI'
  Else If strField = 'ITE_CDCEST_' Then
    Result := 'DIF_ITE_CDCEST'
  Else If strField = 'ITE_CODLUB' Then
    Result := 'DIF_ITE_CODLUB_'
  Else If strField = 'IME_EXCIPI_' Then
    Result := 'DIF_EXCIPI';
End;

function TfraImendesResultado.fFieldTemDivergencia(AViewInfo: TcxGridTableDataCellViewInfo; RecordIndex: integer; blnInfGerais: Boolean = False):Boolean;
var cxColumnDiff: TcxGridDBBandedColumn;
    strFiledDiff: String;
var Grid: TcxGridDBBandedTableView;
Begin
  Result := False;
  strFiledDiff := TcxGridItemDBDataBinding(AViewInfo.Item.DataBinding).FieldName;
  Grid := cxbDados;
  blnInfGerais := POS(strFiledDiff, '_ITE_CLAIPI__ITE_CDCEST__ITE_CODLUB__IME_EXCIPI__') > 0;

  If blnInfGerais Then
    strFiledDiff := fRetFieldCorreto(strFiledDiff)
  Else
    strFiledDiff := AnsiReplaceStr(strFiledDiff, 'ABF_', 'DIF_');


  cxColumnDiff := Grid.GetColumnByFieldName(strFiledDiff);

  If POS('TEM_MENSAGEM', strFiledDiff) > 0 then
    Exit(False);
  If Assigned(cxColumnDiff) Then
    Result :=   VarToStr(Grid.DataController.Values[RecordIndex, cxColumnDiff.Index]) = '1';

  Result := Result And (VarToStr(Grid.DataController.Values[RecordIndex, IME_SEMIME.Index]) = '0');
End;



procedure TfraImendesResultado.IME_CODITEGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
var
  posIni: Integer;
begin
  inherited;
  posIni := Pos('<TAG_AUTCOM>', AText) + Length('<TAG_AUTCOM>');
  AText := Copy(AText, posIni, Length(AText));
end;

procedure TfraImendesResultado.pDestroy;
var i: integer;
begin

  For i := 0 To High(GridDinamico.ArrBandPerfil) do
    FreeAndNil(GridDinamico.ArrBandPerfil[i]);

  SetLength(GridDinamico.ArrBandPerfil, 0);
  cxbDados.ClearItems;

  FreeAndNil(GridDinamico);

end;

procedure TfraImendesResultado.pFinalizaAlteracao;
begin
  cxgDados.EndUpdate;
end;

procedure TfraImendesResultado.pIniciaAlteracao;
begin
  cxgDados.BeginUpdate;
end;

procedure TfraImendesResultado.pSetFocusGrid;
begin
  pSetFocus(cxgDados);
end;

procedure TfraImendesResultado.TEM_MENSAGEM_CCOPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  pCarregaInfAd('CCO');

end;

procedure TfraImendesResultado.TEM_MENSAGEM_CNCPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  pCarregaInfAd('CNC');

end;

procedure TfraImendesResultado.TEM_MENSAGEM_CTAPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  pCarregaInfAd('CTA');

end;

procedure TfraImendesResultado.TEM_MENSAGEM_INDPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  pCarregaInfAd('IND');

end;

procedure TfraImendesResultado.TEM_MENSAGEM_NCOPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  pCarregaInfAd('NCO');

end;

procedure TfraImendesResultado.TEM_MENSAGEM_PEFGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AText :=  Copy(AText, 3,3);
  If AText = '1' Then
    AText := 'Sim'
  Else
    AText := 'Não'

end;

procedure TfraImendesResultado.TEM_MENSAGEM_PEFPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);

begin
  pCarregaInfAd('PEF');
end;


procedure TfraImendesResultado.TEM_MENSAGEM_PEJPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  pCarregaInfAd('PEJ');

end;

procedure TfraImendesResultado.TEM_MENSAGEM_PERPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  pCarregaInfAd('PER');

end;

procedure TfraImendesResultado.TEM_MENSAGEM_PESPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  pCarregaInfAd('PES');

end;

procedure TfraImendesResultado.TEM_MENSAGEM_PIIPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  pCarregaInfAd('PII');

end;

procedure TfraImendesResultado.TEM_MENSAGEM_PRUPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  pCarregaInfAd('PRU');

end;

procedure TfraImendesResultado.TEM_MENSAGEM_PSIPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  pCarregaInfAd('PSI');

end;

procedure TfraImendesResultado.TEM_MENSAGEM_SNAPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  pCarregaInfAd('SNA');

end;

procedure TfraImendesResultado.TEM_MENSAGEM_TRSPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  pCarregaInfAd('TRS');
end;

procedure TfraImendesResultado.pCarregaDadosAdcionais(APerfil: String;
                                 var AAmparoLegal: String;
                                 var ANomeProtocolo: String;
                                 var ADescProtocolo: String;
                                 var ANomeConvenio: String;
                                 var ADescConvenio: String);
Begin

  AAmparoLegal   := cxbDados.DataController.DataSet.FieldByName('ABF_IME_AMPLEG_'+ APerfil).AsString;
  ANomeProtocolo := cxbDados.DataController.DataSet.FieldByName('ABF_IME_PTCNOM_'+ APerfil).AsString;
  ADescProtocolo := cxbDados.DataController.DataSet.FieldByName('ABF_IME_PTCDES_'+ APerfil).AsString;
  ANomeConvenio  := cxbDados.DataController.DataSet.FieldByName('ABF_IME_CONNOM_'+ APerfil).AsString;
  ADescConvenio  := cxbDados.DataController.DataSet.FieldByName('ABF_IME_CONDES_'+ APerfil).AsString;

  TfrmInfAdicionaisICMS.pChamaInfAdcICMS( AAmparoLegal,
                                          ANomeProtocolo,
                                          ADescProtocolo,
                                          ANomeConvenio,
                                          ADescConvenio);
End;

procedure TfraImendesResultado.pCarregaInfAd(APerfil: String);
var AmparoLegal,
    NomeProtocolo,
    DescProtocolo,
    NomeConvenio,
    DescConvenio: String;
Begin
  If Copy(cxbDados.DataController.DataSet.FieldByName('TEM_MENSAGEM_'+ APerfil).AsString, 3 , 3) = '0' Then
  Begin
    pMensagemOk('Sem dados para exibir');
    Exit
  End;


  pCarregaDadosAdcionais(APerfil,
                         AmparoLegal,
                         NomeProtocolo,
                         DescProtocolo,
                         NomeConvenio,
                         DescConvenio);




End;

Class Function TfraImendesResultado.fCriaFrameResultado(frmDestino: TForm; tbsPagina: TWinControl; AProcessaImendesRetorno: TProcessaImendesRetorno;ADtsDados: TDataSource): TfraImendesResultado;
Begin
  Result := TfraImendesResultado.Create(frmDestino);
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

procedure TfraImendesResultado.cxbDadosCustomDrawCell(
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

procedure TfraImendesResultado.cxbDadosCustomDrawGroupCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
  var lLineRect  : TRect;
      strCodBar: String;
begin
  inherited;
  ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, IME_SEMIME.Index]) = '1' Then
      ACanvas.Font.Color := $00006400;
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, IME_RETPAR.Index]) = '1' Then
      ACanvas.Font.Color := clTeal;
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, IME_SEMEAN.Index])  = '1' Then
      ACanvas.Font.Color := clPurple;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, IME_SEMEAN.Index])  = '2' Then
      ACanvas.Font.Color := clBlue;

  If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, IME_SEMIME.Index]) = '0') Then
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, IME_RETPAR.Index]) = '0' Then
  Begin
    If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, DIF_INF_GERAIS.Index]) = '1') Then
      ACanvas.Font.Color := clRed;
    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, IME_DIFICM.Index]) =  '1' Then
      ACanvas.Font.Color := clRed;
  End;

  ACanvas.FillRect(AViewInfo.Bounds, AViewInfo.Params.Color);
  ACanvas.Font.Style := ACanvas.Font.Style;
  AViewInfo.Params.Font := ACanvas.Font;
  //AViewInfo.Params.Font.Color := clBlack;
  ACanvas.DrawTexT(AViewInfo.Text, AViewInfo.TextBounds, cxAlignLeft + cxAlignVCenter);
  //AViewInfo.Params.Font.Color := clBlack;
  AViewInfo.Params.Font.Style := AViewInfo.Params.Font.Style + [fsBold];
  lLineRect := AViewInfo.TextBounds;
  lLineRect.Left := 500;//lLineRect.Left + ACanvas.TextWidth(AViewInfo.Text + ' - ');
  ACanvas.FillRect(lLineRect, AViewInfo.Params.Color);
  strCodBar := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, ITE_CODBAR.Index]);

  If  strCodBar = '' Then
    strCodBar := 'Cód. Barras: ' + 'Não definido'
  Else
    strCodBar := 'Cód. Barras: ' + strCodBar;

  If strCodBar <> '' Then
    ACanvas.TextOut(lLineRect.Left, lLineRect.Top, strCodBar)
  Else
    ACanvas.TextOut(lLineRect.Left, lLineRect.Top, strCodBar);



  ADone := True;
end;

procedure TfraImendesResultado.cxbDadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  posIni: Integer;
  strItem: String;

begin
  inherited;
  If Key = VK_ESCAPE Then
  Begin
    If Assigned(btnSair) Then
      btnSair.Click;
    Exit;
  End;


  If Not Assigned(cxbDados.DataController.DataSet) Then
    Exit;

  If cxbDados.DataController.DataSet.IsEmpty Then
    Exit;

  posIni := Pos('<TAG_AUTCOM>', cxbDados.DataController.DataSet.FieldByName('ITEM').AsString) + Length('<TAG_AUTCOM>');
  strItem := Copy(cxbDados.DataController.DataSet.FieldByName('ITEM').AsString, posIni, Length(cxbDados.DataController.DataSet.FieldByName('ITEM').AsString));


  If Key = VK_DELETE Then
    If fPergunta('Exluir o item ' + strItem + '?') Then
    Begin
      cxgDados.BeginUpdate();
      Try
        ProcessaImendesRetorno.pMarcaParaNaoVisualizar(cxbDados.DataController.DataSet.FieldByName('IME_SEQUEN').AsInteger);
        ProcessaImendesRetorno.pAbrirParametros(True, ProcessaImendesRetorno.strAutIncSelec,  dtsDados);
        cxbDados.DataController.DataSource := dtsDados;
      finally
        cxgDados.EndUpdate;
      End;
    End;
end;

function TfraImendesResultado.fDecideCorFonte(strLocal: String): TColor;
Begin
  If strLocal = 'iMendes' Then
    Result := $00006400
  Else
    Result := clBlue
End;


function TfraImendesResultado.fEstadoTrocaCor(AEstado: String): Boolean;
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
  cxColum := cxbGrid.GetColumnByFieldName('TEM_MENSAGEM_' +  fConvertConfPerfilToString(Perfil));
  cxColum.Position.BandIndex := BandPai.Index;
  cxColum.Caption := 'Adc.';
  cxColum.Width := 33;

  cxColum := cxbGrid.GetColumnByFieldName('ABF_CODSIT' +  fConvertConfPerfilToAliasFieldString(Perfil));
  cxColum.Position.BandIndex := BandPai.Index;
  cxColum.Caption := 'CST';
  cxColum.Width := 33;


end;


procedure TGridDinamico.pAddFieldInfGerais(BandPai: TcxGridband);
  var
    cxColum: TcxGridDBBandedColumn;
begin
  cxColum := cxbGrid.GetColumnByFieldName('ITE_CLAIPI_');
  cxColum.Position.BandIndex := BandPai.Index;

  cxColum := cxbGrid.GetColumnByFieldName('ITE_CDCEST_');
  cxColum.Position.BandIndex := BandPai.Index;

  cxColum := cxbGrid.GetColumnByFieldName('IME_EXCIPI_');
  cxColum.Position.BandIndex := BandPai.Index;

  cxColum := cxbGrid.GetColumnByFieldName('ITE_CODLUB_');
  cxColum.Position.BandIndex := BandPai.Index;
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

  cxColumABF_BASDDS.Width := 80;
  cxColumABF_ALQIED.Width := 130;
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

  cxABF_IVA_ST.Width := 60;
  cxABF_ALQRED.Width := 70;
  cxABF_ALQRET.Width := 65;
  cxABF_BASRET.Width := 65;
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
  Band.Width := 337
  ;
  {Cria o array para poder trocar a visibilidade no grid de acordo com o que estiver marcado no clsFilterPerfil}
  objBandInfGer := TBandPerfil.Create;
  ArrBandPerfil[0] := objBandInfGer;
  ArrBandPerfil[0].Visible := True;
  ArrBandPerfil[0].Band := Band;
  ArrBandPerfil[0].Perfil := cjpIndef;
  ArrBandPerfil[0].strDescri := Band.Caption;
  pAddFieldInfGerais(Band);
end;

procedure TGridDinamico.pCriaEstruturaPerfil(Perfil: TPerfil; index: integer);
var Band,
    BandIcms,
    BandST,
    BandFCP,
    BAndCST,
    BandDifal: TcxGridband;
    BandPerfil: TBandPerfil;


    qry: TUniQuery;
    blnExibirCarac: Boolean;
begin
  qry := fCriaQuery();



  Band := cxbGrid.Bands.Add;
  Band.Caption := fConvertPerfilToDescricao(Perfil);
  Band.Width := 673
  ;
  {Cria o array para poder trocar a visibilidade no grid de acordo com o que estiver marcado no clsFilterPerfil}
  BandPerfil := TBandPerfil.Create;
  ArrBandPerfil[index] := BandPerfil;
  ArrBandPerfil[index].Visible := True;
  ArrBandPerfil[index].Band := Band;
  ArrBandPerfil[index].Perfil := Perfil;
  blnExibirCarac := (Pos(strLoginUsuarioLogado, '_999_998_997_') > 0);

  ArrBandPerfil[index].strDescri := fConvertPerfilToDescricaoComCaracteristica(blnExibirCarac, Perfil, qry);

  BAndCST := Band.Bands.Add;
  BAndCST.Position.BandIndex := Band.Index;
  BAndCST.Position.ColIndex := 0;
  BAndCST.Caption := 'CST';
  pAddFieldCST(Perfil, BAndCST);
//  pAddFieldCST(Perfil, BAndCST);

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

  BandFCP.Width := 33;
  BandDifal.Width := 300;
  BandST.Width := 260;
  BAndCST.Width := 66;

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
