unit untTImportacaoFranquias;

interface

uses Classes, SysUtils, StrUtils, Generics.Collections, Aurelius.Bind.Dataset,
  DB, System.Generics.Defaults, untFuncoesSimples, Vcl.Forms, Vcl.StdCtrls,
  Vcl.Controls, untTypesSistema, Vcl.ExtCtrls, UniClientDataSet, Uni, EditFocus,
  Types, Vcl.Graphics, CRAccess, System.Variants, MemoFocus, Vcl.ComCtrls,cxSpinEdit,
  untIZClient, System.DateUtils;

Type
  TTipoCad = (tcNenhum, tcFornecedores, tcProduto, tcDepartamento, tcLinhaGrupo,
              tcMarca, tcUnidade, tcGrupoProduto, tcAtividade, tcUnidadeCompra);

  TProduto = Record
    IMP_CODITE: String;
    IMP_CODVEL: String;
    IMP_DESITE: String;
    IMP_DESSIM: String;
    IMP_DESFAB: String;
    IMP_CODFAB: String;
    IMP_CODFOR: String;
    IMP_C_G_C_: String;
    IMP_REFERE: String;
    IMP_CODUNI: String;
    IMP_SIGUNI: String;
    IMP_UNICOM: String;
    IMP_SIGCOM: String;
    IMP_CODMAR: String;
    IMP_DESMAR: String;
    IMP_CODGRU: String;
    IMP_DESGRU: String;
    IMP_DESLIN: String;
    IMP_CODDEP: String;
    IMP_DESCRI: String;
    IMP_PRDGRU: String;
    IMP_CODBAR: String;
    IMP_BAREMB: String;
    IMP_EMBALA: String;
    IMP_APLICA: String;
    IMP_IMPLIS: String;
    IMP_ITEATI: String;
    IMP_ITEBAS: String;
    IMP_ITEPIG: String;
    IMP_PROEMB: String;
    IMP_VALOBR: String;
    IMP_INFLAM: String;
    IMP_BAREXP: String;
    IMP_PEEFUT: String;
    IMP_PEFFPR: String;
    IMP_PEFUTP: String;
    IMP_MSGLV1: String;
    IMP_MSGLV2: String;
    IMP_INFGAR: String;
    IMP_ATICOM: String;
    IMP_CPRCEN: String;
    IMP_RPRENT: String;
    IMP_ABAMLT: String;
    IMP_NVLGIR: String;
    IMP_ESMIDG: String;
    IMP_ACOOBJ: String;
    IMP_REAEND: String;
    IMP_CODABF: String;
    IMP_CLAIPI: String;
    IMP_EXCIPI: String;
    IMP_CODFIN: String;
    IMP_INCPIS: String;
    IMP_COMLUB: String;
    IMP_CODLUB: String;
    IMP_OBRCPF: String;
    IMP_OBRIBA: String;
    IMP_ABFPIS: String;
    IMP_ABFCOF: String;
    IMP_ABFIPI: String;
    IMP_CDCEST: String;
    IMP_MENFIS: String;
    IMP_OBRNFE: String;
    IMP_TIPPRO: String;
    IMP_NUMFCI: String;
    IMP_LOCSUP: String;
    IMP_DESGRP: String;
    IMP_PRAPEL: Double;
    IMP_PESOIT: Double;
    IMP_PESLIQ: Double;
    IMP_MLTVEN: Double;
    IMP_MLTCOM: Double;
    IMP_COMVAR: Double;
    IMP_COMATA: Double;
    IMP_COMDIS: Double;
    IMP_DESMAX: Double;
    IMP_DESMSU: Double;
    IMP_MARMIN: Double;
    IMP_MARMSG: Double;
    IMP_IPISAI: Double;
    IMP_PER_CI: Double;
    IMP_PRECOM: Double;
    IMP_DESF01: Double;
    IMP_DESF02: Double;
    IMP_DESF03: Double;
    IMP_DESF04: Double;
    IMP_DESF05: Double;
    IMP_DESF06: Double;
    IMP_ICMENT: Double;
    IMP_SUBFED: Double;
    IMP_IPIENT: Double;
    IMP_FREENT: Double;
    IMP_VALFRE: Double;
    IMP_ACRFIN: Double;
    IMP_SUBSTI: Double;
    IMP_DESADB: Double;
    IMP_OUTVAL: Double;
    IMP_ICMSAI: Double;
    IMP_IMPFED: Double;
    IMP_DESOPE: Double;
    IMP_COMTB1: Double;
    IMP_MARBR1: Double;
    IMP_PREVE1: Double;
    IMP_COMTB2: Double;
    IMP_MARBR2: Double;
    IMP_PREVE2: Double;
    IMP_COMTB3: Double;
    IMP_MARBR3: Double;
    IMP_PREVE3: Double;
    IMP_COMTB4: Double;
    IMP_MARBR4: Double;
    IMP_PREVE4: Double;
    IMP_COMTB5: Double;
    IMP_MARBR5: Double;
    IMP_PREVE5: Double;
    IMP_COMTB6: Double;
    IMP_MARBR6: Double;
    IMP_PREVE6: Double;
    IMP_COMTB7: Double;
    IMP_MARBR7: Double;
    IMP_PREVE7: Double;
    IMP_ESTMIN: Double;
    IMP_ESTMAX: Double;
    IMP_LOCFIS: String;
    IMP_DESMGE: Double;
    IMP_MARMGE: Double;
    IMP_DIAFOR: Integer;
    IMP_TMPGAR: Integer;
    IMP_TIPOPE: String;
    IMP_CODIMP: Integer;
    IMP_DTAIMP: TDateTime;
    IMP_TCIFCU: Double;
    IMP_TSCUST: Double;
    IMP_DEPICO: Double;
    IMP_DEICMS: Double;
    IMP_FATREG: Double;
  End;

  TFornecedor = Record
    IMP_CODVEL: String;
    IMP_VLRED2: String;
    IMP_SIMPAU: String;
    IMP_ACOOBJ: String;
    IMP_MATREV: String;
    IMP_ZONFRA: String;
    IMP_CODATI: String;
    IMP_OBSERV: String;
    IMP_OBSCMP: String;
    IMP_ENDNUM: String;
    IMP_NUMCEL: String;
    IMP_FONE01: String;
    IMP_FONE02: String;
    IMP_EMAPED: String;
    IMP_EMAIL_: String;
    IMP_C_G_C_: String;
    IMP_SUFRAM: String;
    IMP_CONTAT: String;
    IMP_CNDPAG: String;
    IMP_EMAIL3: String;
    IMP_EMAIL2: String;
    IMP_ENDCOM: String;
    IMP_HOMEPA: String;
    IMP_NOMFOR: String;
    IMP_BAIRRO: String;
    IMP_ENDERE: String;
    IMP_NOMFAN: String;
    IMP_DESATI: String;
    IMP_C_E_P_: String;
    IMP_CODCOR: Integer;
    IMP_DIAENT: Integer;
    IMP_CARPAG: Integer;
    IMP_CODIMP: Integer;
    IMP_DESVIS: Double;
    IMP_DTAIMP: TDateTime;
    IMP_TIPOPE: String;
  End;

  TRecParamAdicionar = Record
    intID: Integer;
    strCodigo,
    strDescricao: String;
    strDescricao2: String;
    recProduto: TProduto;
    recFornecedor: TFornecedor;
  End;

  TClasseBase = Class(TUniClientDataSet)
  Private
    FMemoLog: TMemoFocus;
    FMemoExclusao: TMemoFocus;
    FPgrGeral, FPgrDetalhe: TProgressBar;
    FIgnExcFor, FIgnExcPrd: Boolean;
    FArrCamposSelecionados: TArray<String>;

    procedure pCriarCampos; virtual; abstract;
    procedure pInicializarPrgDetalhe;
    procedure pIncrementarPositionProgressos;
  Public
    Constructor Create(AOwner: TComponent; mmoLog, mmoExclusao: TMemoFocus; pgrGeral, pgrDetalhe: TProgressBar); Reintroduce;

    procedure pLimparClient;
    procedure pAdicionar(params: TRecParamAdicionar); virtual; abstract;
    procedure pVincularRegistroExistente(strCodVel, strCodigo, strCamCodVel, strCamCodAut, strTabela: String);
    procedure pConfirmarVinculoRegistroExistente(strCamCodigo, strCamCodVel, strCamCodAut, strTabela: String);
    procedure pLimparRegistroExistente(strCodVel, strCodigo, strCamCodVel, strCamCodAut, strTabela: String);
    procedure pDesfazerVinculosRegistroExistente(strCamCodigo, strCamCodVel, strCamCodAut: String);

    function  fCampoExcluido(const AstrCampo: String): Boolean;
    function  fSalvarRegistros: Boolean; virtual; abstract;
    property  arrCamposSelecionados: TArray<String> Read FArrCamposSelecionados Write FArrCamposSelecionados;
  End;

  TImpProduto = class(TClasseBase)
    Const
      SQL_INSERT_CADITE = 'INSERT INTO CADITE ( AUTOINCREM,' +
                          '  ITE_CODITE, ' +
                          '  ITE_CODVEL, ' +
                          '  ITE_CODEMP, ' +
                          '  ITE_DESITE, ' +
                          '  ITE_DESSIM, ' +
                          '  ITE_DESFAB, ' +
                          '  ITE_CODFAB, ' +
                          '  ITE_CODFOR, ' +
                          '  ITE_REFERE, ' +
                          '  ITE_CODUNI, ' +
                          '  ITE_UNICOM, ' +
                          '  ITE_CODMAR, ' +
                          '  ITE_CODGRU, ' +
                          '  ITE_CODDEP, ' +
                          '  ITE_PRDGRU, ' +
                          '  ITE_PRAPEL, ' +
                          '  ITE_PESOIT, ' +
                          '  ITE_PESLIQ, ' +
                          '  ITE_CODBAR, ' +
                          '  ITE_BAREMB, ' +
                          '  ITE_EMBALA, ' +
                          '  ITE_APLICA, ' +
                          '  ITE_MLTVEN, ' +
                          '  ITE_MLTCOM, ' +
                          '  ITE_ITEATI, ' +
                          '  ITE_ITEBAS, ' +
                          '  ITE_ITEPIG, ' +
                          '  ITE_PROEMB, ' +
                          '  ITE_VALOBR, ' +
                          '  ITE_INFLAM, ' +
                          '  ITE_BAREXP, ' +
                          '  ITE_PEEFUT, ' +
                          '  ITE_PEFFPR, ' +
                          '  ITE_PEFUTP, ' +
                          '  ITE_MSGLV1, ' +
                          '  ITE_MSGLV2, ' +
                          '  ITE_TMPGAR, ' +
                          '  ITE_INFGAR, ' +
                          '  ITE_ATICOM, ' +
                          '  ITE_CPRCEN, ' +
                          '  ITE_DIAFOR, ' +
                          '  ITE_RPRENT, ' +
                          '  ITE_NVLGIR, ' +
                          '  ITE_ACOOBJ, ' +
                          '  ITE_REAEND, ' +
                          '  ITE_CODABF, ' +
                          '  ITE_CLAIPI, ' +
                          '  ITE_EXCIPI, ' +
                          '  ITE_CODFIN, ' +
                          '  ITE_INCPIS, ' +
                          '  ITE_COMLUB, ' +
                          '  ITE_CODLUB, ' +
                          '  ITE_OBRCPF, ' +
                          '  ITE_OBRIBA, ' +
                          '  ITE_ABFPIS, ' +
                          '  ITE_ABFCOF, ' +
                          '  ITE_ABFIPI, ' +
                          '  ITE_CDCEST, ' +
                          '  ITE_MENFIS, ' +
                          '  ITE_OBRNFE, ' +
                          '  ITE_PER_CI, ' +
                          '  ITE_CODOPE, ' +
                          '  ITE_DTACAD, ' +
                          '  ITE_DTAALT, ' +
                          '  ITE_NUMFCI) VALUES (:AUTINC, ' +
                          '    :CODITE, ' +
                          '    :CODVEL, ' +
                          '    :CODEMP, ' +
                          '    :DESITE, ' +
                          '    :DESSIM, ' +
                          '    :DESFAB, ' +
                          '    :CODFAB, ' +
                          '    :CODFOR, ' +
                          '    :REFERE, ' +
                          '    :CODUNI, ' +
                          '    :UNICOM, ' +
                          '    :CODMAR, ' +
                          '    :CODGRU, ' +
                          '    :CODDEP, ' +
                          '    :PRDGRU, ' +
                          '    :PRAPEL, ' +
                          '    :PESOIT, ' +
                          '    :PESLIQ, ' +
                          '    :CODBAR, ' +
                          '    :BAREMB, ' +
                          '    :EMBALA, ' +
                          '    :APLICA, ' +
                          '    :MLTVEN, ' +
                          '    :MLTCOM, ' +
                          '    :ITEATI, ' +
                          '    :ITEBAS, ' +
                          '    :ITEPIG, ' +
                          '    :PROEMB, ' +
                          '    :VALOBR, ' +
                          '    :INFLAM, ' +
                          '    :BAREXP, ' +
                          '    :PEEFUT, ' +
                          '    :PEFFPR, ' +
                          '    :PEFUTP, ' +
                          '    :MSGLV1, ' +
                          '    :MSGLV2, ' +
                          '    :TMPGAR, ' +
                          '    :INFGAR, ' +
                          '    :ATICOM, ' +
                          '    :CPRCEN, ' +
                          '    :DIAFOR, ' +
                          '    :RPRENT, ' +
                          '    :NVLGIR, ' +
                          '    :ACOOBJ, ' +
                          '    :REAEND, ' +
                          '    :CODABF, ' +
                          '    :CLAIPI, ' +
                          '    :EXCIPI, ' +
                          '    :CODFIN, ' +
                          '    :INCPIS, ' +
                          '    :COMLUB, ' +
                          '    :CODLUB, ' +
                          '    :OBRCPF, ' +
                          '    :OBRIBA, ' +
                          '    :ABFPIS, ' +
                          '    :ABFCOF, ' +
                          '    :ABFIPI, ' +
                          '    :CDCEST, ' +
                          '    :MENFIS, ' +
                          '    :OBRNFE, ' +
                          '    :PER_CI, ' +
                          '    :CODOPE, ' +
                          '    :DTACAD, ' +
                          '    :DTAALT, ' +
                          '    :NUMFCI)';
      SQL_DELETE_CADITE = 'DELETE FROM CADITE WHERE ITE_CODITE = :CODITE';
      SQL_INSERT_ITEGER = 'INSERT INTO ITEGER (AUTOINCREM, ' +
                          '  ITE_CODITE, ' +
                          '  ITE_CODVEL, ' +
                          '  ITE_CODEMP, ' +
                          '  ITE_IMPLIS, ' +
                          '  ITE_COMVAR, ' +
                          '  ITE_COMATA, ' +
                          '  ITE_COMDIS, ' +
                          '  ITE_DESMAX, ' +
                          '  ITE_DESMSU, ' +
                          '  ITE_MARMIN, ' +
                          '  ITE_MARMSG, ' +
                          '  ITE_MARMGE, ' +
                          '  ITE_CPRCEN, ' +
                          '  ITE_ABAMLT, ' +
                          '  ITE_ESMIDG, ' +
                          '  ITE_CODABF, ' +
                          '  ITE_IPISAI, ' +
                          '  ITE_EXCIPI, ' +
                          '  ITE_ABFPIS, ' +
                          '  ITE_ABFCOF, ' +
                          '  ITE_ABFIPI, ' +
                          '  ITE_TIPPRO, ' +
                          '  ITE_PRECOM, ' +
                          '  ITE_DESF01, ' +
                          '  ITE_DESF02, ' +
                          '  ITE_DESF03, ' +
                          '  ITE_DESF04, ' +
                          '  ITE_DESF05, ' +
                          '  ITE_DESF06, ' +
                          '  ITE_ICMENT, ' +
                          '  ITE_SUBFED, ' +
                          '  ITE_IPIENT, ' +
                          '  ITE_FREENT, ' +
                          '  ITE_VALFRE, ' +
                          '  ITE_ACRFIN, ' +
                          '  ITE_SUBSTI, ' +
                          '  ITE_DESADB, ' +
                          '  ITE_OUTVAL, ' +
                          '  ITE_ICMSAI, ' +
                          '  ITE_IMPFED, ' +
                          '  ITE_DESOPE, ' +
                          '  ITE_COMTB1, ' +
                          '  ITE_MARBR1, ' +
                          '  ITE_PREVE1, ' +
                          '  ITE_COMTB2, ' +
                          '  ITE_MARBR2, ' +
                          '  ITE_PREVE2, ' +
                          '  ITE_COMTB3, ' +
                          '  ITE_MARBR3, ' +
                          '  ITE_PREVE3, ' +
                          '  ITE_COMTB4, ' +
                          '  ITE_MARBR4, ' +
                          '  ITE_PREVE4, ' +
                          '  ITE_COMTB5, ' +
                          '  ITE_MARBR5, ' +
                          '  ITE_PREVE5, ' +
                          '  ITE_COMTB6, ' +
                          '  ITE_MARBR6, ' +
                          '  ITE_PREVE6, ' +
                          '  ITE_COMTB7, ' +
                          '  ITE_MARBR7, ' +
                          '  ITE_PREVE7, ' +
                          '  ITE_ESTMIN, ' +
                          '  ITE_ESTMAX, ' +
                          '  ITE_LOCFIS, ' +
                          '  ITE_LOCSUP, ' +
                          '  ITE_PRECUS, ' +
                          '  ITE_DTABAL, ' +
                          '  ITE_SALBAL, ' +
                          '  ITE_ML_BAL, ' +
                          '  ITE_SALDOS, ' +
                          '  ITE_SAL_ML, ' +
                          '  ITE_TCIFCU, ' +
                          '  ITE_TSCUST, ' +
                          '  ITE_DEPICO, ' +
                          '  ITE_DEICMS, ' +
                          '  ITE_FATREG, ' +
                          '  ITE_DESMGE, ' +
                          '  ITE_OBRNFE) ' +
                          ' VALUES (     ' +
                          '    :AUTINC, ' +
                          '    :CODITE, ' +
                          '    :CODVEL, ' +
                          '    :CODEMP, ' +
                          '    :IMPLIS, ' +
                          '    :COMVAR, ' +
                          '    :COMATA, ' +
                          '    :COMDIS, ' +
                          '    :DESMAX, ' +
                          '    :DESMSU, ' +
                          '    :MARMIN, ' +
                          '    :MARMSG, ' +
                          '    :MARMGE, ' +
                          '    :CPRCEN, ' +
                          '    :ABAMLT, ' +
                          '    :ESMIDG, ' +
                          '    :CODABF, ' +
                          '    :IPISAI, ' +
                          '    :EXCIPI, ' +
                          '    :ABFPIS, ' +
                          '    :ABFCOF, ' +
                          '    :ABFIPI, ' +
                          '    :TIPPRO, ' +
                          '    :PRECOM, ' +
                          '    :DESF01, ' +
                          '    :DESF02, ' +
                          '    :DESF03, ' +
                          '    :DESF04, ' +
                          '    :DESF05, ' +
                          '    :DESF06, ' +
                          '    :ICMENT, ' +
                          '    :SUBFED, ' +
                          '    :IPIENT, ' +
                          '    :FREENT, ' +
                          '    :VALFRE, ' +
                          '    :ACRFIN, ' +
                          '    :SUBSTI, ' +
                          '    :DESADB, ' +
                          '    :OUTVAL, ' +
                          '    :ICMSAI, ' +
                          '    :IMPFED, ' +
                          '    :DESOPE, ' +
                          '    :COMTB1, ' +
                          '    :MARBR1, ' +
                          '    :PREVE1, ' +
                          '    :COMTB2, ' +
                          '    :MARBR2, ' +
                          '    :PREVE2, ' +
                          '    :COMTB3, ' +
                          '    :MARBR3, ' +
                          '    :PREVE3, ' +
                          '    :COMTB4, ' +
                          '    :MARBR4, ' +
                          '    :PREVE4, ' +
                          '    :COMTB5, ' +
                          '    :MARBR5, ' +
                          '    :PREVE5, ' +
                          '    :COMTB6, ' +
                          '    :MARBR6, ' +
                          '    :PREVE6, ' +
                          '    :COMTB7, ' +
                          '    :MARBR7, ' +
                          '    :PREVE7, ' +
                          '    :ESTMIN, ' +
                          '    :ESTMAX, ' +
                          '    :LOCFIS, ' +
                          '    :LOCSUP, ' +
                          '    :PRECUS, ' +
                          '    :DTABAL, ' +
                          '    :SALBAL, ' +
                          '    :ML_BAL, ' +
                          '    :SALDOS, ' +
                          '    :SAL_ML, ' +
                          '    :TCIFCU, ' +
                          '    :TSCUST, ' +
                          '    :DEPICO, ' +
                          '    :DEICMS, ' +
                          '    :FATREG, ' +
                          '    :DESMGE, ' +
                          '    :OBRNFE) ';
      SQL_UPDATE_ITEGER_WHERE = ' WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP ';
      SQL_INSERT_ITEBAR = 'INSERT INTO ITEBAR ( ' +
                          '  AUTOINCREM, ' +
                          '  BAR_CODITE, ' +
                          '  BAR_CODBAR, ' +
                          '  BAR_CODEMP, ' +
                          '  BAR_EXBFAT, ' +
                          '  BAR_DESCRI, ' +
                          '  BAR_TABPRE, ' +
                          '  BAR_LASTRO, ' +
                          '  BAR_CAMADA, ' +
                          '  BAR_EMPMAX, ' +
                          '  BAR_PRINCI, ' +
                          '  BAR_COMPRA, ' +
                          '  BAR_ALTURA, ' +
                          '  BAR_LARGUR, ' +
                          '  BAR_PROFUN, ' +
                          '  BAR_PESOBR, ' +
                          '  BAR_PESOLQ, ' +
                          '  BAR_EMBALA, ' +
                          '  BAR_PREVEN ' +
                          ') VALUES ( ' +
                          '    :AUTINC, ' +
                          '    :CODITE, ' +
                          '    :CODBAR, ' +
                          '    :CODEMP, ' +
                          '    :EXBFAT, ' +
                          '    :DESCRI, ' +
                          '    :TABPRE, ' +
                          '    :LASTRO, ' +
                          '    :CAMADA, ' +
                          '    :EMPMAX, ' +
                          '    :PRINCI, ' +
                          '    :COMPRA, ' +
                          '    :ALTURA, ' +
                          '    :LARGUR, ' +
                          '    :PROFUN, ' +
                          '    :PESOBR, ' +
                          '    :PESOLQ, ' +
                          '    :EMBALA, ' +
                          '    :PREVEN)';
      SQL_DELETE_ITEBAR = 'DELETE FROM ITEBAR WHERE AUTOINCREM = :AUTINC';
      SQL_UPDATE_IMPPRO = 'UPDATE IMP_PRODUTO SET IMP_DTAIMP = :DTAIMP ' +
        ' WHERE IMP_CODITE = :CODITE AND IMP_DESITE = :DESITE ' +
        '   AND IMP_DTAIMP IS NULL AND IMP_CODIMP = :CODIMP ';
      SQL_UPDATE_ITEBAR_PRINCIPAL = ' UPDATE ITEBAR SET BAR_PRINCI = 0 WHERE BAR_CODITE = :CODITE ';
      SQL_UPDATE_ITEBAR_PRINCIPAL_COMPRA  = ' UPDATE ITEBAR SET BAR_COMPRA = 0 WHERE BAR_CODITE = :CODITE ';
  Private
    procedure pCriarCampos; override;
    function  fMarcarImportado: Boolean;
    function  fAdicionarIteGer(blnInserir: Boolean): Boolean;
    function  fAdicionarGirIte(strCodEmp, strCodIte: string): Boolean ;
    function  fAdicionarIteBar: Boolean;
    procedure pLimparTProdutoUpd;
    function  fGetRecProdutoUpdate(strCodIte, strCodEmp: String; blnCadIte: Boolean): TProduto;
  Public
    recProdUpdate: TProduto;

    Const
      SQL_SELECT_IMPPRO = 'SELECT * FROM IMP_PRODUTO WHERE IMP_DTAIMP IS NULL ORDER BY IMP_CODIMP';

    procedure pAdicionar(params: TRecParamAdicionar); override;

    function  fSalvarRegistros: Boolean; override;
  End;

  TImpFornecedor = class(TClasseBase)
    Const
      SQL_INSERT_CADFOR = 'INSERT INTO CADFOR ( ' +
                          '  FOR_CODFOR, ' +
                          '  FOR_CODATI, ' +
                          '  FOR_CODCID, ' +
                          '  FOR_NOMFOR, ' +
                          '  FOR_NOMFAN, ' +
                          '  FOR_ENDERE, ' +
                          '  FOR_BAIRRO, ' +
                          '  FOR_C_E_P_, ' +
                          '  FOR_CGCCPF, ' +
                          '  FOR_C_G_C_, ' +
                          '  FOR_I_E_S_, ' +
                          '  FOR_CONTAT, ' +
                          '  FOR_CAIPOS, ' +
                          '  FOR_FONE01, ' +
                          '  FOR_FONE02, ' +
                          '  FOR_F_A_X_, ' +
                          '  FOR_EMAIL_, ' +
                          '  FOR_EMAIL2, ' +
                          '  FOR_EMAIL3, ' +
                          '  FOR_HOMEPA, ' +
                          '  FOR_CNDPAG, ' +
                          '  FOR_CODEMP, ' +
                          '  AUTOINCREM, ' +
                          '  FOR_NUMRG_, ' +
                          '  FOR_MATREV, ' +
                          '  FOR_OBSERV, ' +
                          '  FOR_CODTRA, ' +
                          '  FOR_CONCON, ' +
                          '  FOR_CODCTA, ' +
                          '  FOR_CTATRA, ' +
                          '  FOR_CODVEL, ' +
                          '  FOR_0800__, ' +
                          '  FOR_STATUS, ' +
                          '  FOR_ENDNUM, ' +
                          '  FOR_ENDCOM, ' +
                          '  FOR_SIMPAU, ' +
                          '  FOR_NUMCEL, ' +
                          '  FOR_VLRED2, ' +
                          '  FOR_EMAPED, ' +
                          '  FOR_CODOPE, ' +
                          '  FOR_ACOOBJ, ' +
                          '  FOR_REVIST, ' +
                          '  FOR_DESIPI, ' +
                          '  FOR_DESSUB, ' +
                          '  FOR_ZONFRA, ' +
                          '  FOR_DESMEM, ' +
                          '  FOR_OBSCMP, ' +
                          '  FOR_SUFRAM, ' +
                          '  FOR_DIAENT, ' +
                          '  FOR_QTDETI, ' +
                          '  FOR_CARPAG, ' +
                          '  FOR_DESVIS, ' +
                          '  FOR_PERCOM, ' +
                          '  FOR_MINORC, ' +
                          '  FOR_PERFCX, ' +
                          '  FOR_DTACAD, ' +
                          '  FOR_ULTALT, ' +
                          '  FOR_DTAALT) VALUES ( ' +
                          '  :CODFOR, ' +
                          '  :CODATI, ' +
                          '  :CODCID, ' +
                          '  :NOMFOR, ' +
                          '  :NOMFAN, ' +
                          '  :ENDERE, ' +
                          '  :BAIRRO, ' +
                          '  :C_E_P_, ' +
                          '  :CGCCPF, ' +
                          '  :C_G_C_, ' +
                          '  :I_E_S_, ' +
                          '  :CONTAT, ' +
                          '  :CAIPOS, ' +
                          '  :FONE01, ' +
                          '  :FONE02, ' +
                          '  :F_A_X_, ' +
                          '  :EMAIL_, ' +
                          '  :EMAIL2, ' +
                          '  :EMAIL3, ' +
                          '  :HOMEPA, ' +
                          '  :CNDPAG, ' +
                          '  :CODEMP, ' +
                          '  :AUTINC, ' +
                          '  :NUMRG_, ' +
                          '  :MATREV, ' +
                          '  :OBSERV, ' +
                          '  :CODTRA, ' +
                          '  :CONCON, ' +
                          '  :CODCTA, ' +
                          '  :CTATRA, ' +
                          '  :CODVEL, ' +
                          '  :080000, ' +
                          '  :STATUS, ' +
                          '  :ENDNUM, ' +
                          '  :ENDCOM, ' +
                          '  :SIMPAU, ' +
                          '  :NUMCEL, ' +
                          '  :VLRED2, ' +
                          '  :EMAPED, ' +
                          '  :CODOPE, ' +
                          '  :ACOOBJ, ' +
                          '  :REVIST, ' +
                          '  :DESIPI, ' +
                          '  :DESSUB, ' +
                          '  :ZONFRA, ' +
                          '  :DESMEM, ' +
                          '  :OBSCMP, ' +
                          '  :SUFRAM, ' +
                          '  :DIAENT, ' +
                          '  :QTDETI, ' +
                          '  :CARPAG, ' +
                          '  :DESVIS, ' +
                          '  :PERCOM, ' +
                          '  :MINORC, ' +
                          '  :PERFCX, ' +
                          '  :DTACAD, ' +
                          '  :ULTALT, ' +
                          '  :DTAALT) ';
      SQL_UPDATE_CADFOR = 'UPDATE CADFOR SET ' +
                          '  FOR_CODATI = :CODATI, ' +
                          '  FOR_CODCID = :CODCID, ' +
                          '  FOR_NOMFOR = :NOMFOR, ' +
                          '  FOR_NOMFAN = :NOMFAN, ' +
                          '  FOR_ENDERE = :ENDERE, ' +
                          '  FOR_BAIRRO = :BAIRRO, ' +
                          '  FOR_C_E_P_ = :C_E_P_, ' +
                          '  FOR_CGCCPF = :CGCCPF, ' +
                          '  FOR_C_G_C_ = :C_G_C_, ' +
                          '  FOR_CONTAT = :CONTAT, ' +
                          '  FOR_FONE01 = :FONE01, ' +
                          '  FOR_FONE02 = :FONE02, ' +
                          '  FOR_EMAIL_ = :EMAIL_, ' +
                          '  FOR_EMAIL2 = :EMAIL2, ' +
                          '  FOR_EMAIL3 = :EMAIL3, ' +
                          '  FOR_HOMEPA = :HOMEPA, ' +
                          '  FOR_CNDPAG = :CNDPAG, ' +
                          '  FOR_CODEMP = :CODEMP, ' +
                          '  FOR_MATREV = :MATREV, ' +
                          '  FOR_OBSERV = :OBSERV, ' +
                          '  FOR_CODVEL = :CODVEL, ' +
                          '  FOR_0800__ = :0800,   ' +
                          '  FOR_STATUS = :STATUS, ' +
                          '  FOR_ENDNUM = :ENDNUM, ' +
                          '  FOR_ENDCOM = :ENDCOM, ' +
                          '  FOR_SIMPAU = :SIMPAU, ' +
                          '  FOR_NUMCEL = :NUMCEL, ' +
                          '  FOR_VLRED2 = :VLRED2, ' +
                          '  FOR_EMAPED = :EMAPED, ' +
                          '  FOR_ACOOBJ = :ACOOBJ, ' +
                          '  FOR_ZONFRA = :ZONFRA, ' +
                          '  FOR_OBSCMP = :OBSCMP, ' +
                          '  FOR_SUFRAM = :SUFRAM, ' +
                          '  FOR_DIAENT = :DIAENT, ' +
                          '  FOR_CARPAG = :CARPAG, ' +
                          '  FOR_DESVIS = :DESVIS, ' +
                          '  FOR_DTACAD = :DTACAD, ' +
                          '  FOR_ULTALT = :ULTALT, ' +
                          '  FOR_DTAALT = :DTAALT  ' +
                          ' WHERE FOR_CODFOR = :CODFOR ';
      SQL_DELETE_CADFOR = 'DELETE FROM CADFOR WHERE FOR_C_G_C_ = :C_G_C_ AND FOR_NOMFOR = :NOMFOR';
      SQL_UPDATE_IMPFOR = 'UPDATE IMP_FORNECEDOR SET IMP_DTAIMP = :DTAIMP ' +
        ' WHERE IMP_NOMFOR = :NOMFOR AND IFNULL(IMP_C_G_C_, "") = :C_G_C_ ' +
        '   AND IMP_DTAIMP IS NULL AND IMP_CODIMP = :CODIMP ';
  Private
    procedure pCriarCampos; override;
    function  fMarcarImportado: Boolean;
  Public
    Const
      SQL_SELECT_IMPFOR = 'SELECT * FROM IMP_FORNECEDOR WHERE IMP_DTAIMP IS NULL ORDER BY IMP_CODIMP';

    procedure pAdicionar(params: TRecParamAdicionar); override;

    function  fSalvarRegistros: Boolean; override;
  End;

  TCadDep = class(TClasseBase)
    Const
      SQL_INSERT_CADDEP = 'INSERT INTO CADDEP ( ' +
                           ' DEP_CODIGO, ' +
                           ' DEP_DESCRI, ' +
                           ' DEP_CODEMP, ' +
                           ' AUTOINCREM, ' +
                           ' DEP_PROEMB, ' +
                           ' DEP_PROMAP, ' +
                           ' DEP_PROGRA, ' +
                           ' DEP_PROACA, ' +
                           ' DEP_CODVEL) VALUES ( ' +
                           ' :CODIGO, ' +
                           ' :DESCRI, ' +
                           ' :CODEMP, ' +
                           ' :AUTINC, ' +
                           ' :PROEMB, ' +
                           ' :PROMAP, ' +
                           ' :PROGRA, ' +
                           ' :PROACA, ' +
                           ' :CODVEL)';
  Private
    procedure pCriarCampos; override;
  Public
    procedure pAdicionar(params: TRecParamAdicionar); override;

    function  fSalvarRegistros: Boolean; override;
  End;

  TCadLinGru = Class(TClasseBase)
    Const
      SQL_INSERT_CADGRU = 'INSERT INTO CADGRU ( ' +
                          '  GRU_CODGRU, ' +
                          '  GRU_DESGRU, ' +
                          '  GRU_CODEMP, ' +
                          '  AUTOINCREM, ' +
                          '  GRU_PERCOM, ' +
                          '  GRU_CODVEL, ' +
                          '  GRU_DRELIN, ' +
                          '  GRU_DREGRU, ' +
                          '  GRU_DETLIN, ' +
                          '  GRU_DETGRU, ' +
                          '  GRU_SGETGR, ' +
                          '  GRU_TIPGRU, ' +
                          '  GRU_ULTALT ' +
                          ') VALUES ( ' +
                          '  :CODGRU, ' +
                          '  :DESGRU, ' +
                          '  :CODEMP, ' +
                          '  :AUTINC, ' +
                          '  :PERCOM, ' +
                          '  :CODVEL, ' +
                          '  :DRELIN, ' +
                          '  :DREGRU, ' +
                          '  :DETLIN, ' +
                          '  :DETGRU, ' +
                          '  :SGETGR, ' +
                          '  :TIPGRU, ' +
                          '  :ULTALT) ';
  Private
    procedure pCriarCampos; override;
    function  fLinhaExiste: Boolean;
    function  fGrupoExiste: Boolean;
    function  fCadastrarLinha: Boolean;
    procedure pVerificarCadastroLinha;
  Public
    procedure pAdicionar(params: TRecParamAdicionar); override;

    function  fSalvarRegistros: Boolean; override;
  End;

  TCadMar = Class(TClasseBase)
    Const
      SQL_INSERT_CADMAR = 'INSERT INTO CADMAR ( ' +
                          '  MAR_CODMAR, ' +
                          '  MAR_DESMAR, ' +
                          '  MAR_CODEMP, ' +
                          '  AUTOINCREM, ' +
                          '  MAR_CODGRU, ' +
                          '  MAR_FATCUS, ' +
                          '  MAR_CODVEL, ' +
                          '  MAR_ULTALT ' +
                          ') VALUES ( ' +
                          '    :CODMAR, ' +
                          '    :DESMAR, ' +
                          '    :CODEMP, ' +
                          '    :AUTINC, ' +
                          '    :CODGRU, ' +
                          '    :FATCUS, ' +
                          '    :CODVEL, ' +
                          '    :ULTALT)';
  Private
    procedure pCriarCampos; override;
  Public
    procedure pAdicionar(params: TRecParamAdicionar); override;

    function  fSalvarRegistros: Boolean; override;
  End;

  TCadUni = Class(TClasseBase)
    Const
      SQL_INSERT_CADUNI = 'INSERT INTO CADUNI ( ' +
                          '  UNI_CODUNI, ' +
                          '  UNI_DESUNI, ' +
                          '  UNI_CODEMP, ' +
                          '  AUTOINCREM, ' +
                          '  UNI_PESLIT, ' +
                          '  UNI_ITEFRA, ' +
                          '  UNI_SIGUNI, ' +
                          '  UNI_METFAT, ' +
                          '  UNI_DREUNI, ' +
                          '  UNI_DETUNI, ' +
                          '  UNI_KILLIT, ' +
                          '  UNI_ULTALT, ' +
                          '  UNI_CODVEL, ' +
                          '  UNI_PEAPBE ' +
                          ') VALUES ( ' +
                          '    :CODUNI, ' +
                          '    :DESUNI, ' +
                          '    :CODEMP, ' +
                          '    :AUTINC, ' +
                          '    :PESLIT, ' +
                          '    :ITEFRA, ' +
                          '    :SIGUNI, ' +
                          '    :METFAT, ' +
                          '    :DREUNI, ' +
                          '    :DETUNI, ' +
                          '    :KILLIT, ' +
                          '    :ULTALT, ' +
                          '    :CODVEL, ' +
                          '    :PEAPBE)';
  Private
    procedure pCriarCampos; override;
  Public
    procedure pAdicionar(params: TRecParamAdicionar); override;

    function  fSalvarRegistros: Boolean; override;
  End;

  TGrpPrd = Class(TClasseBase)
    Const
      SQL_INSERT_GRPPRD = 'INSERT INTO GRPPRD ( ' +
                          '  PRD_CODGRU, ' +
                          '  PRD_DESGRU, ' +
                          '  PRD_CODEMP, ' +
                          '  AUTOINCREM, ' +
                          '  PRD_CODVEL ' +
                          ') VALUES (:CODGRU, :DESGRU, :CODEMP, :AUTINC, :CODVEL)';
  Private
    procedure pCriarCampos; override;
  Public
    procedure pAdicionar(params: TRecParamAdicionar); override;

    function  fSalvarRegistros: Boolean; override;
  End;

  TCadAti = Class(TClasseBase)
    Const
      SQL_INSERT_CADATI = 'INSERT INTO CADATI ( ' +
                          '  ATI_CODATI, ' +
                          '  ATI_DESATI, ' +
                          '  ATI_CODEMP, ' +
                          '  AUTOINCREM, ' +
                          '  ATI_TABPRE, ' +
                          '  ATI_PERCOM, ' +
                          '  ATI_CODVEL, ' +
                          '  ATI_RENPRE, ' +
                          '  ATI_CODGAT, ' +
                          '  ATI_ULTALT, ' +
                          '  ATI_CODJON ' +
                          ') VALUES ( ' +
                          '    :CODATI, ' +
                          '    :DESATI, ' +
                          '    :CODEMP, ' +
                          '    :AUTINC, ' +
                          '    :TABPRE, ' +
                          '    :PERCOM, ' +
                          '    :CODVEL, ' +
                          '    :RENPRE, ' +
                          '    :CODGAT, ' +
                          '    :ULTALT, ' +
                          '    :CODJON)';
  Private
    procedure pCriarCampos; override;
  Public
    procedure pAdicionar(params: TRecParamAdicionar); override;

    function  fSalvarRegistros: Boolean; override;
  End;

  TImportacaoCadastros = class(TComponent)
  Private
    FCdsCadDep: TCadDep;
    FCdsCadMar: TCadMar;
    FCdsCadUni: TCadUni;
    FCdsGrpPrd: TGrpPrd;
    FCdsCadGru: TCadLinGru;
    FCdsCadAti: TCadAti;

    FCdsImpPro: TImpProduto;
    FCdsImpFor: TImpFornecedor;

    FMemoLog  : TMemoFocus;
    FMemoExclusao: TMemoFocus;
    FPgrGeral, FPgrDetalhe: TProgressBar;

    FIgnExcFor, FIgnExcPrd: Boolean;
    FArrCamposSelecionados: TArray<String>;

    function  fGetRecProduto(qryDados: TUniQuery): TProduto;
    function  fGetRecFornecedor(qryDados: TUniQuery): TFornecedor;

    procedure pLimparClients;

    procedure pInicializarPrgDetalhe(intQtdReg: Integer);
    procedure pIncrementarPositionProgressos;
    function  fQtdRegistros: Integer;

    function  fRetCodAti(strCodVel, strDescri: String): String;
    function  fRetCodDep(strCodVel, strDescri: String): String;
    function  fRetCodLinGru(strCodVel, strDescri, strDescri2: String): String;
    function  fRetCodMarca(strCodVel, strDescri: String): String;
    function  fRetCodUnidade(strCodVel, strDescri: String): String;
    function  fRetCodGrupoProduto(strCodVel, strDescri: String): String;
    function  fRetCodForn(strC_G_C_, strCodVel: String): String;

    function  fVincularAtividadeFornecedor: Boolean;
    function  fVincularDepartamentoProduto: Boolean;
    function  fVincularLinhaGrupoProduto: Boolean;
    function  fVincularMarcaProduto: Boolean;
    function  fVincularUnidadeProduto: Boolean;
    function  fVincularGrupoProdutoProduto: Boolean;
    function  fVincularFornecedorProduto: Boolean;
  Public
    intLimitRegistros: Integer;

    Constructor Create(AOwner: TComponent; mmoLog, mmoExclusao: TMemoFocus; pgrGeral, pgrDetalhe: TProgressBar); Reintroduce;
    Destructor  Destroy; Override;

    function fVerificaDadosImportacao: Boolean;
    function fRealizarImportacao: Boolean;
    function fPossuiRegistros: Boolean;

    property cdsCadDep: TCadDep        Read FCdsCadDep;
    property cdsCadGru: TCadLinGru     Read FCdsCadGru;
    property cdsImpPro: TImpProduto    Read FCdsImpPro;
    property cdsCadMar: TCadMar        Read FCdsCadMar;
    property cdsCadUni: TCadUni        Read FCdsCadUni;
    property cdsGrpPrd: TGrpPrd        Read FCdsGrpPrd;
    property cdsCadAti: TCadAti        Read FCdsCadAti;
    property cdsImpFor: TImpFornecedor Read FCdsImpFor;
    property blnIgnExcFor: Boolean     Read FIgnExcFor Write FIgnExcFor;
    property blnIgnExcPrd: Boolean     Read FIgnExcPrd Write FIgnExcPrd;
    property arrCamposSelecionados: TArray<String> Read FArrCamposSelecionados Write FArrCamposSelecionados;
  End;

implementation

{ TImportacaoCadastros }

uses untParCalculaPrecoCusto, untTConfiguracao, untSaldoPedidoCompra;

constructor TImportacaoCadastros.Create(AOwner: TComponent; mmoLog, mmoExclusao: TMemoFocus;
  pgrGeral, pgrDetalhe: TProgressBar);
begin
  inherited Create(AOwner);
  Self.SetParentComponent(TWinControl(AOwner));

  FIgnExcFor := False;
  FIgnExcPrd := False;

  FCdsCadDep := TCadDep.Create(AOwner, mmoLog, mmoExclusao, pgrGeral, pgrDetalhe);
  FCdsImpPro := TImpProduto.Create(AOwner, mmoLog, mmoExclusao, pgrGeral, pgrDetalhe);
  FCdsCadGru := TCadLinGRu.Create(AOwner, mmoLog, mmoExclusao, pgrGeral, pgrDetalhe);
  FCdsCadMar := TCadMar.Create(AOwner, mmoLog, mmoExclusao, pgrGeral, pgrDetalhe);
  FCdsCadUni := TCadUni.Create(AOwner, mmoLog, mmoExclusao, pgrGeral, pgrDetalhe);
  FCdsGrpPrd := TGrpPrd.Create(AOwner, mmoLog, mmoExclusao, pgrGeral, pgrDetalhe);
  FCdsCadAti := TCadAti.Create(AOwner, mmoLog, mmoExclusao, pgrGeral, pgrDetalhe);
  FCdsImpFor := TImpFornecedor.Create(AOwner, mmoLog, mmoExclusao, pgrGeral, pgrDetalhe);

  If (Assigned(mmoLog)) Then
    FMemoLog := mmoLog
  Else
    FMemoLog := nil;

  If (Assigned(mmoExclusao)) Then
    FMemoExclusao := mmoExclusao
  Else
    FMemoExclusao := nil;

  If (Assigned(pgrGeral)) Then
    FPgrGeral := pgrGeral
  Else
    FPgrGeral := nil;

  If (Assigned(pgrDetalhe)) Then
    FPgrDetalhe := pgrDetalhe
  Else
    FPgrDetalhe := nil;

end;

destructor TImportacaoCadastros.Destroy;
begin
  inherited;

  FreeAndNil(FCdsCadDep);
  FreeAndNil(FCdsImpPro);
  FreeAndNil(FCdsCadGru);
  FreeAndNil(FCdsCadMar);
  FreeAndNil(FCdsCadUni);
  FreeAndNil(FCdsGrpPrd);
  FreeAndNil(FCdsCadAti);
  FreeAndNil(FCdsImpFor);
end;

function TImportacaoCadastros.fGetRecFornecedor(
  qryDados: TUniQuery): TFornecedor;
begin
  If (Assigned(FCdsImpFor)) And (FCdsImpFor.Active) And
     (Assigned(qryDados)) And (qryDados.Active) And (Not qryDados.IsEmpty) Then Begin
    With qryDados Do Begin
      Result.IMP_CODVEL := '';
      Result.IMP_VLRED2 := FieldByName('IMP_VLRED2').AsString;
      Result.IMP_SIMPAU := FieldByName('IMP_SIMPAU').AsString;
      Result.IMP_ACOOBJ := FieldByName('IMP_ACOOBJ').AsString;
      Result.IMP_MATREV := FieldByName('IMP_MATREV').AsString;
      Result.IMP_ZONFRA := FieldByName('IMP_ZONFRA').AsString;
      Result.IMP_CODATI := FieldByName('IMP_CODATI').AsString;
      Result.IMP_OBSERV := FieldByName('IMP_OBSERV').AsString;
      Result.IMP_OBSCMP := FieldByName('IMP_OBSCMP').AsString;
      Result.IMP_ENDNUM := FieldByName('IMP_ENDNUM').AsString;
      Result.IMP_NUMCEL := FieldByName('IMP_NUMCEL').AsString;
      Result.IMP_FONE01 := FieldByName('IMP_FONE01').AsString;
      Result.IMP_FONE02 := FieldByName('IMP_FONE02').AsString;
      Result.IMP_EMAPED := FieldByName('IMP_EMAPED').AsString;
      Result.IMP_EMAIL_ := FieldByName('IMP_EMAIL_').AsString;
      Result.IMP_C_G_C_ := FieldByName('IMP_C_G_C_').AsString;
      Result.IMP_SUFRAM := FieldByName('IMP_SUFRAM').AsString;
      Result.IMP_CONTAT := FieldByName('IMP_CONTAT').AsString;
      Result.IMP_CNDPAG := FieldByName('IMP_CNDPAG').AsString;
      Result.IMP_EMAIL3 := FieldByName('IMP_EMAIL3').AsString;
      Result.IMP_EMAIL2 := FieldByName('IMP_EMAIL2').AsString;
      Result.IMP_ENDCOM := FieldByName('IMP_ENDCOM').AsString;
      Result.IMP_HOMEPA := FieldByName('IMP_HOMEPA').AsString;
      Result.IMP_NOMFOR := FieldByName('IMP_NOMFOR').AsString;
      Result.IMP_BAIRRO := FieldByName('IMP_BAIRRO').AsString;
      Result.IMP_ENDERE := FieldByName('IMP_ENDERE').AsString;
      Result.IMP_NOMFAN := FieldByName('IMP_NOMFAN').AsString;
      Result.IMP_DESATI := FieldByName('IMP_DESATI').AsString;
      Result.IMP_C_E_P_ := FieldByName('IMP_C_E_P_').AsString;
      Result.IMP_TIPOPE := FieldByName('IMP_TIPOPE').AsString;
      Result.IMP_CODCOR := FieldByName('IMP_CODCOR').AsInteger;
      Result.IMP_DIAENT := FieldByName('IMP_DIAENT').AsInteger;
      Result.IMP_CARPAG := FieldByName('IMP_CARPAG').AsInteger;
      Result.IMP_CODIMP := FieldByName('IMP_CODIMP').AsInteger;
      Result.IMP_DESVIS := FieldByName('IMP_DESVIS').AsFloat;
      Result.IMP_DTAIMP := 0;
    End;
  End;
end;

function TImportacaoCadastros.fGetRecProduto(qryDados: TUniQuery): TProduto;
begin
  If (Assigned(FCdsImpPro)) And (FCdsImpPro.Active) And
     (Assigned(qryDados)) And (qryDados.Active) And (Not qryDados.IsEmpty) Then Begin
    With qryDados Do Begin
      Result.IMP_CODITE := FieldByName('IMP_CODITE').AsString;
      Result.IMP_CODVEL := FieldByName('IMP_CODITE').AsString;
      Result.IMP_DESITE := FieldByName('IMP_DESITE').AsString;
      Result.IMP_DESSIM := FieldByName('IMP_DESSIM').AsString;
      Result.IMP_DESFAB := FieldByName('IMP_DESFAB').AsString;
      Result.IMP_CODFAB := FieldByName('IMP_CODFAB').AsString;
      Result.IMP_CODFOR := FieldByName('IMP_CODFOR').AsString;
      Result.IMP_C_G_C_ := FieldByName('IMP_C_G_C_').AsString;
      Result.IMP_REFERE := FieldByName('IMP_REFERE').AsString;
      Result.IMP_CODUNI := FieldByName('IMP_CODUNI').AsString;
      Result.IMP_SIGUNI := FieldByName('IMP_SIGUNI').AsString;
      Result.IMP_UNICOM := FieldByName('IMP_UNICOM').AsString;
      Result.IMP_SIGCOM := FieldByName('IMP_SIGCOM').AsString;
      Result.IMP_CODMAR := FieldByName('IMP_CODMAR').AsString;
      Result.IMP_DESMAR := FieldByName('IMP_DESMAR').AsString;
      Result.IMP_CODGRU := FieldByName('IMP_CODGRU').AsString;
      Result.IMP_DESGRU := Trim(FieldByName('IMP_DESGRU').AsString);
      Result.IMP_DESLIN := Trim(FieldByName('IMP_DESLIN').AsString);
      Result.IMP_CODDEP := FieldByName('IMP_CODDEP').AsString;
      Result.IMP_DESCRI := FieldByName('IMP_DESCRI').AsString;
      Result.IMP_PRDGRU := FieldByName('IMP_PRDGRU').AsString;
      Result.IMP_CODBAR := FieldByName('IMP_CODBAR').AsString;
      Result.IMP_BAREMB := FieldByName('IMP_BAREMB').AsString;
      Result.IMP_EMBALA := FieldByName('IMP_EMBALA').AsString;
      Result.IMP_APLICA := FieldByName('IMP_APLICA').AsString;
      Result.IMP_IMPLIS := FieldByName('IMP_IMPLIS').AsString;
      Result.IMP_ITEATI := FieldByName('IMP_ITEATI').AsString;
      Result.IMP_ITEBAS := FieldByName('IMP_ITEBAS').AsString;
      Result.IMP_ITEPIG := FieldByName('IMP_ITEPIG').AsString;
      Result.IMP_PROEMB := FieldByName('IMP_PROEMB').AsString;
      Result.IMP_VALOBR := FieldByName('IMP_VALOBR').AsString;
      Result.IMP_INFLAM := FieldByName('IMP_INFLAM').AsString;
      Result.IMP_BAREXP := FieldByName('IMP_BAREXP').AsString;
      Result.IMP_PEEFUT := FieldByName('IMP_PEEFUT').AsString;
      Result.IMP_PEFFPR := FieldByName('IMP_PEFFPR').AsString;
      Result.IMP_PEFUTP := FieldByName('IMP_PEFUTP').AsString;
      Result.IMP_MSGLV1 := FieldByName('IMP_MSGLV1').AsString;
      Result.IMP_MSGLV2 := FieldByName('IMP_MSGLV2').AsString;
      Result.IMP_INFGAR := FieldByName('IMP_INFGAR').AsString;
      Result.IMP_ATICOM := FieldByName('IMP_ATICOM').AsString;
      Result.IMP_CPRCEN := FieldByName('IMP_CPRCEN').AsString;
      Result.IMP_RPRENT := FieldByName('IMP_RPRENT').AsString;
      Result.IMP_ABAMLT := FieldByName('IMP_ABAMLT').AsString;
      Result.IMP_NVLGIR := FieldByName('IMP_NVLGIR').AsString;
      Result.IMP_ESMIDG := FieldByName('IMP_ESMIDG').AsString;
      Result.IMP_ACOOBJ := FieldByName('IMP_ACOOBJ').AsString;
      Result.IMP_REAEND := FieldByName('IMP_REAEND').AsString;
      Result.IMP_CODABF := FieldByName('IMP_CODABF').AsString;
      Result.IMP_CLAIPI := FieldByName('IMP_CLAIPI').AsString;
      Result.IMP_EXCIPI := FieldByName('IMP_EXCIPI').AsString;
      Result.IMP_CODFIN := FieldByName('IMP_CODFIN').AsString;
      Result.IMP_INCPIS := FieldByName('IMP_INCPIS').AsString;
      Result.IMP_COMLUB := FieldByName('IMP_COMLUB').AsString;
      Result.IMP_CODLUB := FieldByName('IMP_CODLUB').AsString;
      Result.IMP_OBRCPF := FieldByName('IMP_OBRCPF').AsString;
      Result.IMP_OBRIBA := FieldByName('IMP_OBRIBA').AsString;
      Result.IMP_ABFPIS := FieldByName('IMP_ABFPIS').AsString;
      Result.IMP_ABFCOF := FieldByName('IMP_ABFCOF').AsString;
      Result.IMP_ABFIPI := FieldByName('IMP_ABFIPI').AsString;
      Result.IMP_CDCEST := FieldByName('IMP_CDCEST').AsString;
      Result.IMP_MENFIS := FieldByName('IMP_MENFIS').AsString;
      Result.IMP_OBRNFE := FieldByName('IMP_OBRNFE').AsString;
      Result.IMP_TIPPRO := FieldByName('IMP_TIPPRO').AsString;
      Result.IMP_NUMFCI := FieldByName('IMP_NUMFCI').AsString;
      Result.IMP_LOCSUP := FieldByName('IMP_LOCSUP').AsString;
      Result.IMP_DESGRP := FieldByName('IMP_DESGRP').AsString;
      Result.IMP_TIPOPE := FieldByName('IMP_TIPOPE').AsString;
      Result.IMP_PRAPEL := FieldByName('IMP_PRAPEL').AsFloat;
      Result.IMP_PESOIT := FieldByName('IMP_PESOIT').AsFloat;
      Result.IMP_PESLIQ := FieldByName('IMP_PESLIQ').AsFloat;
      Result.IMP_MLTVEN := FieldByName('IMP_MLTVEN').AsFloat;
      Result.IMP_MLTCOM := FieldByName('IMP_MLTCOM').AsFloat;
      Result.IMP_COMVAR := FieldByName('IMP_COMVAR').AsFloat;
      Result.IMP_COMATA := FieldByName('IMP_COMATA').AsFloat;
      Result.IMP_COMDIS := FieldByName('IMP_COMDIS').AsFloat;
      Result.IMP_DESMAX := FieldByName('IMP_DESMAX').AsFloat;
      Result.IMP_DESMSU := FieldByName('IMP_DESMSU').AsFloat;
      Result.IMP_MARMIN := FieldByName('IMP_MARMIN').AsFloat;
      Result.IMP_MARMSG := FieldByName('IMP_MARMSG').AsFloat;
      Result.IMP_MARMGE := FieldByName('IMP_MARMGE').AsFloat;
      Result.IMP_IPISAI := FieldByName('IMP_IPISAI').AsFloat;
      Result.IMP_PER_CI := FieldByName('IMP_PER_CI').AsFloat;
      Result.IMP_PRECOM := FieldByName('IMP_PRECOM').AsFloat;
      Result.IMP_DESF01 := FieldByName('IMP_DESF01').AsFloat;
      Result.IMP_DESF02 := FieldByName('IMP_DESF02').AsFloat;
      Result.IMP_DESF03 := FieldByName('IMP_DESF03').AsFloat;
      Result.IMP_DESF04 := FieldByName('IMP_DESF04').AsFloat;
      Result.IMP_DESF05 := FieldByName('IMP_DESF05').AsFloat;
      Result.IMP_DESF06 := FieldByName('IMP_DESF06').AsFloat;
      Result.IMP_ICMENT := FieldByName('IMP_ICMENT').AsFloat;
      Result.IMP_SUBFED := FieldByName('IMP_SUBFED').AsFloat;
      Result.IMP_IPIENT := FieldByName('IMP_IPIENT').AsFloat;
      Result.IMP_FREENT := FieldByName('IMP_FREENT').AsFloat;
      Result.IMP_VALFRE := FieldByName('IMP_VALFRE').AsFloat;
      Result.IMP_ACRFIN := FieldByName('IMP_ACRFIN').AsFloat;
      Result.IMP_SUBSTI := FieldByName('IMP_SUBSTI').AsFloat;
      Result.IMP_DESADB := FieldByName('IMP_DESADB').AsFloat;
      Result.IMP_OUTVAL := FieldByName('IMP_OUTVAL').AsFloat;
      Result.IMP_ICMSAI := FieldByName('IMP_ICMSAI').AsFloat;
      Result.IMP_IMPFED := FieldByName('IMP_IMPFED').AsFloat;
      Result.IMP_DESOPE := FieldByName('IMP_DESOPE').AsFloat;
      Result.IMP_COMTB1 := FieldByName('IMP_COMTB1').AsFloat;
      Result.IMP_MARBR1 := FieldByName('IMP_MARBR1').AsFloat;
      Result.IMP_PREVE1 := FieldByName('IMP_PREVE1').AsFloat;
      Result.IMP_COMTB2 := FieldByName('IMP_COMTB2').AsFloat;
      Result.IMP_MARBR2 := FieldByName('IMP_MARBR2').AsFloat;
      Result.IMP_PREVE2 := FieldByName('IMP_PREVE2').AsFloat;
      Result.IMP_COMTB3 := FieldByName('IMP_COMTB3').AsFloat;
      Result.IMP_MARBR3 := FieldByName('IMP_MARBR3').AsFloat;
      Result.IMP_PREVE3 := FieldByName('IMP_PREVE3').AsFloat;
      Result.IMP_COMTB4 := FieldByName('IMP_COMTB4').AsFloat;
      Result.IMP_MARBR4 := FieldByName('IMP_MARBR4').AsFloat;
      Result.IMP_PREVE4 := FieldByName('IMP_PREVE4').AsFloat;
      Result.IMP_COMTB5 := FieldByName('IMP_COMTB5').AsFloat;
      Result.IMP_MARBR5 := FieldByName('IMP_MARBR5').AsFloat;
      Result.IMP_PREVE5 := FieldByName('IMP_PREVE5').AsFloat;
      Result.IMP_COMTB6 := FieldByName('IMP_COMTB6').AsFloat;
      Result.IMP_MARBR6 := FieldByName('IMP_MARBR6').AsFloat;
      Result.IMP_PREVE6 := FieldByName('IMP_PREVE6').AsFloat;
      Result.IMP_COMTB7 := FieldByName('IMP_COMTB7').AsFloat;
      Result.IMP_MARBR7 := FieldByName('IMP_MARBR7').AsFloat;
      Result.IMP_PREVE7 := FieldByName('IMP_PREVE7').AsFloat;
      Result.IMP_ESTMIN := FieldByName('IMP_ESTMIN').AsFloat;
      Result.IMP_ESTMAX := FieldByName('IMP_ESTMAX').AsFloat;
      Result.IMP_LOCFIS := FieldByName('IMP_LOCFIS').AsString;
      Result.IMP_DESMGE := FieldByName('IMP_DESMGE').AsFloat;
      Result.IMP_DIAFOR := FieldByName('IMP_DIAFOR').AsInteger;
      Result.IMP_TMPGAR := FieldByName('IMP_TMPGAR').AsInteger;
      Result.IMP_CODIMP := FieldByName('IMP_CODIMP').AsInteger;
      Result.IMP_DESMGE := FieldByName('IMP_DESMGE').AsFloat;
      Result.IMP_TCIFCU := FieldByName('IMP_TCIFCU').AsFloat;
      Result.IMP_TSCUST := FieldByName('IMP_TSCUST').AsFloat;
      Result.IMP_DEPICO := FieldByName('IMP_DEPICO').AsFloat;
      Result.IMP_DEICMS := FieldByName('IMP_DEICMS').AsFloat;
      Result.IMP_FATREG := FieldByName('IMP_FATREG').AsFloat;
      Result.IMP_DTAIMP := 0;
    End;
  End;
end;

function TImportacaoCadastros.fPossuiRegistros: Boolean;
begin
  Result := (fQtdRegistros() > 0);
end;

function TImportacaoCadastros.fQtdRegistros: Integer;
begin
  Result := FCdsCadAti.RecordCount +
            FCdsImpFor.RecordCount +
            FCdsCadDep.RecordCount +
            FCdsCadGru.RecordCount +
            FCdsCadMar.RecordCount +
            FCdsCadUni.RecordCount +
            FCdsGrpPrd.RecordCount +
            FCdsImpPro.RecordCount;
end;

function TImportacaoCadastros.fRealizarImportacao: Boolean;

  procedure pInicializarProgresso; begin
    FPgrGeral.Min := 0;
    FPgrGeral.Max := fQtdRegistros();
    FPgrGeral.Position := 0;

    FPgrDetalhe.Min := 0;
    FPgrDetalhe.Max := 0;
    FPgrDetalhe.Position := 0;
  end;

begin
  Result := True;

  Try
    If (Assigned(FPgrGeral)) And (Assigned(FPgrDetalhe)) Then
      pInicializarProgresso();

    Application.ProcessMessages();

    fStartTransaction();

    //SALVAR REGISTROS IMPORTADOS DE ATIVIDADE
    Result := Result And FCdsCadAti.fSalvarRegistros();
    Result := Result And fVincularAtividadeFornecedor();

    //SALVAR REGISTROS IMPORTADOS DE FORNECEDOR
    FCdsImpFor.FIgnExcFor := Self.FIgnExcFor;
    Result := Result And FCdsImpFor.fSalvarRegistros();
    Result := Result And fVincularFornecedorProduto();

    //SALVAR REGISTROS IMPORTADOS DE DEPARTAMENTO
    Result := Result And FCdsCadDep.fSalvarRegistros();
    Result := Result And fVincularDepartamentoProduto();

    //SALVAR REGISTROS IMPORTADOS DE LINHA/GRUPO
    Result := Result And FCdsCadGru.fSalvarRegistros();
    Result := Result And fVincularLinhaGrupoProduto();

    //SALVAR REGISTROS IMPORTADOS DE MARCA
    Result := Result And FCdsCadMar.fSalvarRegistros();
    Result := Result And fVincularMarcaProduto();

    //SALVAR REGISTROS IMPORTADOS DE UNIDADE
    Result := Result And FCdsCadUni.fSalvarRegistros();
    Result := Result And fVincularUnidadeProduto();

    //SALVAR REGISTROS IMPORTADOS DE GRUPO DE PRODUTOS
    Result := Result And FCdsGrpPrd.fSalvarRegistros();
    Result := Result And fVincularGrupoProdutoProduto();

    Result := Result And fCommit();

    Result := Result And fStartTransaction();

    //SALVAR REGISTROS IMPORTADOS DE PRODUTO
    FCdsImpPro.FIgnExcPrd := Self.FIgnExcPrd;
    FCdsImpPro.FArrCamposSelecionados := Self.FArrCamposSelecionados;
    Result := Result And FCdsImpPro.fSalvarRegistros();

    Result := Result And fCommit();

  Except
    On E : Exception Do Begin
      Result := False;
      fRollBack();
		  pMensagensErro(E.Message, '[TImportacaoCadastros.fRealizarImportacao]');
    End;
  End;

end;

function TImportacaoCadastros.fRetCodAti(strCodVel, strDescri: String): String;
begin
  Result := '';

  If (FCdsCadAti.Locate('ATI_CODVEL;ATI_DESATI', VarArrayOf([strCodVel, strDescri]), [])) Then Begin
    Result := FCdsCadAti.FieldByName('ATI_CODAUT').AsString;
  End;
end;

function TImportacaoCadastros.fRetCodDep(strCodVel, strDescri: String): String;
begin
  Result := '';

  If (FCdsCadDep.Locate('DEP_CODVEL;DEP_DESCRI', VarArrayOf([strCodVel, strDescri]), [])) Then Begin
    Result := FCdsCadDep.FieldByName('DEP_CODAUT').AsString;
  End;
end;

function TImportacaoCadastros.fRetCodForn(strC_G_C_, strCodVel: String): String;
begin
  Result := '';

  If (Not FCdsImpFor.IsEmpty) Then Begin
    If (FCdsImpFor.Locate('IMP_C_G_C_;IMP_CODVEL', VarArrayOf([strC_G_C_, strCodVel]), [])) Then Begin
      Result := FCdsImpFor.FieldByName('IMP_CODAUT').AsString;
    End;
  End Else Begin
    Result := fCampoTabela('FOR_CODFOR', 'CADFOR', ['FOR_C_G_C_'], [strC_G_C_]);
  End;
end;

function TImportacaoCadastros.fRetCodGrupoProduto(strCodVel, strDescri: String): String;
begin
  Result := '';

  If (FCdsGrpPrd.Locate('PRD_CODVEL;PRD_DESGRU', VarArrayOf([strCodVel, strDescri]), [])) Then Begin
    Result := FCdsGrpPrd.FieldByName('PRD_CODAUT').AsString;
  End;
end;

function TImportacaoCadastros.fRetCodLinGru(strCodVel, strDescri, strDescri2: String): String;
begin
  Result := '';

  If (FCdsCadGru.Locate('GRU_CODVEL;GRU_DESGRU;GRU_DETLIN', VarArrayOf([strCodVel, Trim(strDescri), Trim(strDescri2)]), [])) Then Begin
    Result := FCdsCadGru.FieldByName('GRU_CODAUT').AsString;
  End;
end;

function TImportacaoCadastros.fRetCodMarca(strCodVel, strDescri: String): String;
begin
  Result := '';

  If (FCdsCadMar.Locate('MAR_CODVEL;MAR_DESMAR', VarArrayOf([strCodVel, strDescri]), [])) Then Begin
    Result := FCdsCadMar.FieldByName('MAR_CODAUT').AsString;
  End;
end;

function TImportacaoCadastros.fRetCodUnidade(strCodVel, strDescri: String): String;
begin
  Result := '';

  If (FCdsCadUni.Locate('UNI_CODVEL;UNI_SIGUNI', VarArrayOf([strCodVel, strDescri]), [])) Then Begin
    Result := FCdsCadUni.FieldByName('UNI_CODAUT').AsString;
  End;
end;

function TImportacaoCadastros.fVerificaDadosImportacao: Boolean;
  Var
    blnImpPro, blnImpFor: Boolean;
    qryTempProd, qryTempForn: TUniQuery;

  procedure pInicializarQryProd; begin
    qryTempProd.Close();
    qryTempProd.SQL.Clear();
    qryTempProd.SQL.Text := TImpProduto.SQL_SELECT_IMPPRO + ' LIMIT ' + intLimitRegistros.ToString;
  end;

  procedure pInicializarQryForn; begin
    qryTempForn.Close();
    qryTempForn.SQL.Clear();
    qryTempForn.SQL.Text := TImpFornecedor.SQL_SELECT_IMPFOR + ' LIMIT ' + intLimitRegistros.ToString;
  end;

  procedure pInicializarProgresso; begin
    FPgrGeral.Min := 0;
    FPgrGeral.Max := qryTempForn.RecordCount + qryTempProd.RecordCount;
    FPgrGeral.Position := 0;

    FPgrDetalhe.Min := 0;
    FPgrDetalhe.Max := 0;
    FPgrDetalhe.Position := 0;
  end;

  function fRetParams(tcTipoCad: TTipoCad): TRecParamAdicionar; begin
    Result.intID         := 0;
    Result.strCodigo     := '';
    Result.strDescricao  := '';

    Case (tcTipoCad) Of
      tcFornecedores:
        Begin
          Result.intID         := qryTempForn.RecNo;
          Result.recFornecedor := fGetRecFornecedor(qryTempForn);
        End;


      tcProduto:
        Begin
          Result.intID        := qryTempProd.RecNo;
          Result.recProduto   := fGetRecProduto(qryTempProd);
        End;

      tcDepartamento:
        Begin
          Result.intID        := qryTempProd.RecNo;
          Result.strCodigo    := qryTempProd.FieldByName('IMP_CODDEP').AsString;
          Result.strDescricao := qryTempProd.FieldByName('IMP_DESCRI').AsString;
        End;

      tcLinhaGrupo:
        Begin
          Result.intID         := qryTempProd.RecNo;
          Result.strCodigo     := qryTempProd.FieldByName('IMP_CODGRU').AsString;
          Result.strDescricao  := Trim(qryTempProd.FieldByName('IMP_DESGRU').AsString);
          Result.strDescricao2 := Trim(qryTempProd.FieldByName('IMP_DESLIN').AsString);
        End;

      tcMarca:
        Begin
          Result.intID        := qryTempProd.RecNo;
          Result.strCodigo    := qryTempProd.FieldByName('IMP_CODMAR').AsString;
          Result.strDescricao := qryTempProd.FieldByName('IMP_DESMAR').AsString;
        End;

      tcUnidade:
        Begin
          Result.intID        := qryTempProd.RecNo;
          Result.strCodigo    := qryTempProd.FieldByName('IMP_CODUNI').AsString;
          Result.strDescricao := qryTempProd.FieldByName('IMP_SIGUNI').AsString;
        End;

      tcUnidadeCompra:
        Begin
          Result.intID        := qryTempProd.RecNo;
          Result.strCodigo    := qryTempProd.FieldByName('IMP_UNICOM').AsString;
          Result.strDescricao := qryTempProd.FieldByName('IMP_SIGCOM').AsString;
        End;

      tcGrupoProduto:
        Begin
          Result.intID        := qryTempProd.RecNo;
          Result.strCodigo    := qryTempProd.FieldByName('IMP_PRDGRU').AsString;
          Result.strDescricao := qryTempProd.FieldByName('IMP_DESGRP').AsString;
        End;

      tcAtividade:
        Begin
          Result.intID        := qryTempForn.RecNo;
          Result.strCodigo    := qryTempForn.FieldByName('IMP_CODATI').AsString;
          Result.strDescricao := qryTempForn.FieldByName('IMP_DESATI').AsString;
        End;
    End;
  end;

begin
  Result := True;

  Try
    pLimparClients();

    qryTempProd := fCriaQuery(nil);
    qryTempForn := fCriaQuery(nil);

    Try
      //PESQUISA SE POSSUI FORNECEDORES PARA IMPORTAÇÃO
      pInicializarQryForn();
      pInicializarQryProd();

      //PESQUISA SE POSSUI PRODUTOS PARA IMPORTAÇÃO
      qryTempForn.Open();
      qryTempForn.First();

      qryTempProd.Open();
      qryTempProd.First();

      blnImpFor := (qryTempForn.RecordCount > 0);
      blnImpPro := (qryTempProd.RecordCount > 0);

      If (Assigned(FPgrGeral)) And (Assigned(FPgrDetalhe)) Then
        pInicializarProgresso();

      pInicializarPrgDetalhe(qryTempForn.RecordCount);

      Application.ProcessMessages();

      While (Not qryTempForn.Eof) Do Begin
        //ADICIONAR O REGISTRO DA ATIVIDADE A SER IMPORTADA
        FCdsCadAti.pAdicionar(fRetParams(tcAtividade));

        //ADICIONAR O REGISTRO DO FORNECEDOR A SER IMPORTADO
        FCdsImpFor.pAdicionar(fRetParams(tcFornecedores));

        pIncrementarPositionProgressos();
        qryTempForn.Next();
      End;

      pInicializarPrgDetalhe(qryTempProd.RecordCount);

      Application.ProcessMessages();

      While (Not qryTempProd.Eof) Do Begin
        //ADICIONAR O REGISTRO DO DEPARTAMENTO A SER IMPORTADO
        FCdsCadDep.pAdicionar(fRetParams(tcDepartamento));

        //ADICIONAR O REGISTRO DA LINHA/GRUPO A SER IMPORTADA
        FCdsCadGru.pAdicionar(fRetParams(tcLinhaGrupo));

        //ADICIONAR O REGISTRO DA MARCA A SER IMPORTADA
        FCdsCadMar.pAdicionar(fRetParams(tcMarca));

        //ADICIONAR O REGISTRO DA UNIDADE A SER IMPORTADA
        FCdsCadUni.pAdicionar(fRetParams(tcUnidade));

        FCdsCadUni.pAdicionar(fRetParams(tcUnidadeCompra));

        //ADICIONAR O REGISTRO DO GRUPO DE PRODUTOS A SER IMPORTADO
        FCdsGrpPrd.pAdicionar(fRetParams(tcGrupoProduto));

        //ADICIONAR O REGISTRO DO PRODUTO A SER IMPORTADO
        FCdsImpPro.pAdicionar(fRetParams(tcProduto));

        pIncrementarPositionProgressos();
        qryTempProd.Next();
      End;

      If (Not blnImpFor) Then
        FMemoLog.Lines.Add(#13#10 + 'Nenhum registro de FORNECEDOR foi encontrado para importação!' + #13#10);

      If (Not blnImpPro) Then
        FMemoLog.Lines.Add(#13#10 + 'Nenhum registro de PRODUTO foi encontrado para importação!' + #13#10);

    Finally
      FreeAndNil(qryTempProd);
      FreeAndNil(qryTempForn);
    End;
  Except
    On E : Exception Do Begin
      Result := False;
		  pMensagensErro(E.Message, '[TImportacaoCadastros.fSalvarRegistros]');
    End;
  End;
end;

function TImportacaoCadastros.fVincularAtividadeFornecedor: Boolean;
begin
  Try
    Result := True;

    If (Not FCdsImpFor.Active) Then Exit;

    Try
      FCdsImpFor.DisableControls();
      FCdsImpFor.First();

      While (Not FCdsImpFor.Eof) Do Begin
        FCdsImpFor.Edit();
        FCdsImpFor.FieldByName('IMP_ATIAUT').AsString :=
          fRetCodAti(FCdsImpFor.FieldByName('IMP_CODATI').AsString,
                     FCdsImpFor.FieldByName('IMP_DESATI').AsString);
        FCdsImpFor.Post();

        If (fEmptyStr(FCdsImpFor.FieldByName('IMP_ATIAUT').AsString)) Then
          FMemoLog.Lines.Add(#13#10 + 'ATIVIDADE NÃO ENCONTRADA: ' +
            QuotedStr(FCdsImpFor.FieldByName('IMP_CODATI').AsString) + ' - ' +
            QuotedStr(FCdsImpFor.FieldByName('IMP_DESATI').AsString) + #13#10);

        FCdsImpFor.Next();
      End;
    Finally
      FCdsImpFor.EnableControls();
    End;
  Except
    On E : Exception Do Begin
      Result := False;
		  pMensagensErro(E.Message, '[TImportacaoCadastros.fVincularAtividadeFornecedor]');

      FMemoLog.Lines.Add(#13#10 + 'ERRO: ' + E.Message + #13#10);
    End;
  End;
end;

function TImportacaoCadastros.fVincularDepartamentoProduto: Boolean;
begin
  Try
    Result := True;

    If (Not FCdsImpPro.Active) Then Exit;

    Try
      FCdsImpPro.DisableControls();
      FCdsImpPro.First();

      While (Not FCdsImpPro.Eof) Do Begin
        FCdsImpPro.Edit();
        FCdsImpPro.FieldByName('IMP_DEPAUT').AsString :=
          fRetCodDep(FCdsImpPro.FieldByName('IMP_CODDEP').AsString,
                     FCdsImpPro.FieldByName('IMP_DESCRI').AsString);
        FCdsImpPro.Post();

        If (fEmptyStr(FCdsImpPro.FieldByName('IMP_DEPAUT').AsString)) Then
          FMemoLog.Lines.Add(#13#10 + 'DEPARTAMENTO NÃO ENCONTRADO: ' +
            QuotedStr(FCdsImpPro.FieldByName('IMP_CODDEP').AsString) + ' - ' +
            QuotedStr(FCdsImpPro.FieldByName('IMP_DESCRI').AsString) + #13#10);

        FCdsImpPro.Next();
      End;
    Finally
      FCdsImpPro.EnableControls();
    End;
  Except
    On E : Exception Do Begin
      Result := False;
		  pMensagensErro(E.Message, '[TImportacaoCadastros.fVincularDepartamentoProduto]');

      FMemoLog.Lines.Add(#13#10 + 'ERRO: ' + E.Message + #13#10);
    End;
  End;
end;

function TImportacaoCadastros.fVincularFornecedorProduto: Boolean;
begin
  Try
    Result := True;

    If (Not FCdsImpPro.Active) Then Exit;

    Try
      FCdsImpPro.DisableControls();
      FCdsImpPro.First();

      While (Not FCdsImpPro.Eof) Do Begin
        FCdsImpPro.Edit();
        FCdsImpPro.FieldByName('IMP_AUTFOR').AsString :=
          fRetCodForn(FCdsImpPro.FieldByName('IMP_C_G_C_').AsString,
                      FCdsImpPro.FieldByName('IMP_CODFOR').AsString);
        FCdsImpPro.Post();

        If (fEmptyStr(FCdsImpPro.FieldByName('IMP_AUTFOR').AsString)) Then
          FMemoLog.Lines.Add(#13#10 + 'FORNECEDOR NÃO ENCONTRADO: ' +
            QuotedStr(FCdsImpPro.FieldByName('IMP_C_G_C_').AsString) + ' - ' +
            QuotedStr(FCdsImpPro.FieldByName('IMP_CODFOR').AsString) + #13#10);

        FCdsImpPro.Next();
      End;
    Finally
      FCdsImpPro.EnableControls();
    End;
  Except
    On E : Exception Do Begin
      Result := False;
		  pMensagensErro(E.Message, '[TImportacaoCadastros.fVincularFornecedorProduto]');

      FMemoLog.Lines.Add(#13#10 + 'ERRO: ' + E.Message + #13#10);
    End;
  End;
end;

function TImportacaoCadastros.fVincularLinhaGrupoProduto: Boolean;
begin
  Try
    Result := True;

    If (Not FCdsImpPro.Active) Then Exit;

    Try
      FCdsImpPro.DisableControls();
      FCdsImpPro.First();

      While (Not FCdsImpPro.Eof) Do Begin
        FCdsImpPro.Edit();
        FCdsImpPro.FieldByName('IMP_GRUAUT').AsString :=
          fRetCodLinGru(FCdsImpPro.FieldByName('IMP_CODGRU').AsString,
                        Trim(FCdsImpPro.FieldByName('IMP_DESGRU').AsString),
                        Trim(FCdsImpPro.FieldByName('IMP_DESLIN').AsString));
        FCdsImpPro.Post();

        If (fEmptyStr(FCdsImpPro.FieldByName('IMP_GRUAUT').AsString)) Then
          FMemoLog.Lines.Add(#13#10 + 'LINHA/GRUPO NÃO ENCONTRADO: ' +
            QuotedStr(FCdsImpPro.FieldByName('IMP_CODGRU').AsString) + ' - ' +
            QuotedStr(FCdsImpPro.FieldByName('IMP_DESGRU').AsString) + #13#10);

        FCdsImpPro.Next();
      End;
    Finally
      FCdsImpPro.EnableControls();
    End;
  Except
    On E : Exception Do Begin
      Result := False;
		  pMensagensErro(E.Message, '[TImportacaoCadastros.fVincularLinhaGrupoProduto]');

      FMemoLog.Lines.Add(#13#10 + 'ERRO: ' + E.Message + #13#10);
    End;
  End;
end;

function TImportacaoCadastros.fVincularMarcaProduto: Boolean;
begin
  Try
    Result := True;

    If (Not FCdsImpPro.Active) Then Exit;

    Try
      FCdsImpPro.DisableControls();
      FCdsImpPro.First();

      While (Not FCdsImpPro.Eof) Do Begin
        FCdsImpPro.Edit();
        FCdsImpPro.FieldByName('IMP_MARAUT').AsString :=
          fRetCodMarca(FCdsImpPro.FieldByName('IMP_CODMAR').AsString,
                       FCdsImpPro.FieldByName('IMP_DESMAR').AsString);
        FCdsImpPro.Post();

        If (fEmptyStr(FCdsImpPro.FieldByName('IMP_MARAUT').AsString)) Then
          FMemoLog.Lines.Add(#13#10 + 'MARCA NÃO ENCONTRADA: ' +
            QuotedStr(FCdsImpPro.FieldByName('IMP_CODMAR').AsString) + ' - ' +
            QuotedStr(FCdsImpPro.FieldByName('IMP_DESMAR').AsString) + #13#10);

        FCdsImpPro.Next();
      End;
    Finally
      FCdsImpPro.EnableControls();
    End;
  Except
    On E : Exception Do Begin
      Result := False;
		  pMensagensErro(E.Message, '[TImportacaoCadastros.fVincularMarcaProduto]');

      FMemoLog.Lines.Add(#13#10 + 'ERRO: ' + E.Message + #13#10);
    End;
  End;
end;

function TImportacaoCadastros.fVincularGrupoProdutoProduto: Boolean;
begin
  Try
    Result := True;

    If (Not FCdsImpPro.Active) Then Exit;

    Try
      FCdsImpPro.DisableControls();
      FCdsImpPro.First();

      While (Not FCdsImpPro.Eof) Do Begin
        FCdsImpPro.Edit();
        FCdsImpPro.FieldByName('IMP_GRPAUT').AsString :=
          fRetCodGrupoProduto(FCdsImpPro.FieldByName('IMP_PRDGRU').AsString,
                              FCdsImpPro.FieldByName('IMP_DESGRP').AsString);
        FCdsImpPro.Post();

        If (fEmptyStr(FCdsImpPro.FieldByName('IMP_GRPAUT').AsString)) Then
          FMemoLog.Lines.Add(#13#10 + 'GRUPO DE PRODUTO NÃO ENCONTRADO: ' +
            QuotedStr(FCdsImpPro.FieldByName('IMP_PRDGRU').AsString) + ' - ' +
            QuotedStr(FCdsImpPro.FieldByName('IMP_DESGRP').AsString) + #13#10);

        FCdsImpPro.Next();
      End;
    Finally
      FCdsImpPro.EnableControls();
    End;
  Except
    On E : Exception Do Begin
      Result := False;
		  pMensagensErro(E.Message, '[TImportacaoCadastros.fVincularGrupoProdutoProduto]');

      FMemoLog.Lines.Add(#13#10 + 'ERRO: ' + E.Message + #13#10);
    End;
  End;
end;

function TImportacaoCadastros.fVincularUnidadeProduto: Boolean;
begin
  Try
    Result := True;

    If (Not FCdsImpPro.Active) Then Exit;

    Try
      FCdsImpPro.DisableControls();
      FCdsImpPro.First();

      While (Not FCdsImpPro.Eof) Do Begin
        FCdsImpPro.Edit();
        FCdsImpPro.FieldByName('IMP_UNIAUT').AsString :=
          fRetCodUnidade(FCdsImpPro.FieldByName('IMP_CODUNI').AsString,
                         FCdsImpPro.FieldByName('IMP_SIGUNI').AsString);

        FCdsImpPro.FieldByName('IMP_UCPAUT').AsString :=
          fRetCodUnidade(FCdsImpPro.FieldByName('IMP_UNICOM').AsString,
                         FCdsImpPro.FieldByName('IMP_SIGCOM').AsString);

        FCdsImpPro.Post();

        If (fEmptyStr(FCdsImpPro.FieldByName('IMP_UNIAUT').AsString)) Then
          FMemoLog.Lines.Add(#13#10 + 'UNIDADE NÃO ENCONTRADA: ' +
            QuotedStr(FCdsImpPro.FieldByName('IMP_CODUNI').AsString) + ' - ' +
            QuotedStr(FCdsImpPro.FieldByName('IMP_SIGUNI').AsString) + #13#10);

        If (fEmptyStr(FCdsImpPro.FieldByName('IMP_UCPAUT').AsString)) Then
          FMemoLog.Lines.Add(#13#10 + 'UNIDADE DE COMPRA NÃO ENCONTRADA: ' +
            QuotedStr(FCdsImpPro.FieldByName('IMP_UNICOM').AsString) + ' - ' +
            QuotedStr(FCdsImpPro.FieldByName('IMP_SIGCOM').AsString) + #13#10);

        FCdsImpPro.Next();
      End;
    Finally
      FCdsImpPro.EnableControls();
    End;
  Except
    On E : Exception Do Begin
      Result := False;
		  pMensagensErro(E.Message, '[TImportacaoCadastros.fVincularUnidadeProduto]');

      FMemoLog.Lines.Add(#13#10 + 'ERRO: ' + E.Message + #13#10);
    End;
  End;
end;

procedure TImportacaoCadastros.pIncrementarPositionProgressos;
var
  blnProcessMessages: Boolean;
begin
  blnProcessMessages := False;
  
  If (Assigned(FPgrGeral)) Then
  Begin
    FPgrGeral.Position := FPgrGeral.Position + 1;
    blnProcessMessages := FPgrGeral.Position Mod 20 = 0;
  End;

  If (Assigned(FPgrDetalhe)) Then
  Begin
    FPgrDetalhe.Position := FPgrDetalhe.Position + 1;
    blnProcessMessages := FPgrDetalhe.Position Mod 20 = 0;
  End;

  If blnProcessMessages Then
    Application.ProcessMessages;
end;

procedure TImportacaoCadastros.pInicializarPrgDetalhe(intQtdReg: Integer);
begin
  If (Assigned(FPgrDetalhe)) Then Begin
    FPgrDetalhe.Min := 0;
    FPgrDetalhe.Max := intQtdReg;
    FPgrDetalhe.Position := 0;
  End;
end;

procedure TImportacaoCadastros.pLimparClients;
begin
  FCdsCadDep.pLimparClient();
  FCdsImpPro.pLimparClient();
  FCdsCadMar.pLimparClient();
  FCdsCadUni.pLimparClient();
  FCdsCadGru.pLimparClient();
  FCdsGrpPrd.pLimparClient();
  FCdsCadAti.pLimparClient();
  FCdsImpFor.pLimparClient();
end;

{ TCadDep }

function TCadDep.fSalvarRegistros: Boolean;
  Var
    qryTemp: TUniQuery;

  procedure pInicializarQry; begin
    qryTemp.Close();
    qryTemp.SQL.Clear();
    qryTemp.SQL.Text := SQL_INSERT_CADDEP;
  end;

begin
  Result := True;

  Try
    qryTemp := fCriaQuery(nil);

    Try
      Self.First();
      pInicializarPrgDetalhe();

      While (Not Self.Eof) Do Begin
        pInicializarQry();

        If (fEmptyStr(Self.FieldByName('DEP_CODAUT').AsString)) Then Begin
          Repeat
            qryTemp.ParamByName('CODIGO').AsString := fAtualizaProCod('CADDEP', 'DEP_CODIGO');
          Until (fEmptyStr(fCampoTabela('DEP_CODIGO', 'CADDEP', ['DEP_CODIGO'], [qryTemp.ParamByName('CODIGO').AsString])));

          Self.Edit();
          Self.FieldByName('DEP_CODIGO').AsString := qryTemp.ParamByName('CODIGO').AsString;
          Self.FieldByName('DEP_CODAUT').AsString := qryTemp.ParamByName('CODIGO').AsString;
          Self.Post();
        End Else Begin
          //ATUALIZAR OS REGISTROS A SEREM IMPORTADOS COM O CÓDIGO RESPECTIVO
          pIncrementarPositionProgressos();
          Self.Next();
          Continue;
        End;

        qryTemp.ParamByName('AUTINC').AsString := fRetAutoIncrem('CADDEP', VS_strCodEmp);

        qryTemp.ParamByName('CODVEL').AsString := Self.FieldByName('DEP_CODVEL').AsString;
        qryTemp.ParamByName('DESCRI').AsString := Self.FieldByName('DEP_DESCRI').AsString;
        qryTemp.ParamByName('CODEMP').AsString := Self.FieldByName('DEP_CODEMP').AsString;
        qryTemp.ParamByName('PROEMB').AsString := Self.FieldByName('DEP_PROEMB').AsString;
        qryTemp.ParamByName('PROMAP').AsString := Self.FieldByName('DEP_PROMAP').AsString;
        qryTemp.ParamByName('PROGRA').AsString := Self.FieldByName('DEP_PROGRA').AsString;
        qryTemp.ParamByName('PROACA').AsString := Self.FieldByName('DEP_PROACA').AsString;

        qryTemp.ExecSQL();

        FMemoLog.Lines.Add('DEPARTAMENTO ADICIONADO AO BD: CÓD. ANT. : ' +
          Self.FieldByName('DEP_CODVEL').AsString +
          ' | CÓD.: ' + Self.FieldByName('DEP_CODIGO').AsString);

        pIncrementarPositionProgressos();
        Self.Next();
      End;
    Finally
      FreeAndNil(qryTemp);
    End;
  Except
    On E : Exception Do Begin
      Result := False;
		  pMensagensErro(E.Message, '[TCadDep.fSalvarRegistros]');

      FMemoLog.Lines.Add(#13#10 + 'ERRO: ' + E.Message + #13#10);
    End;
  End;
end;

procedure TCadDep.pAdicionar(params: TRecParamAdicionar);
  Var
    strTemp: String;
begin
  If (fEmptyStr(params.strDescricao)) Then Exit;

  If (Self.Locate('DEP_CODVEL;DEP_DESCRI', VarArrayOf([params.strCodigo, params.strDescricao]), [])) Then
    Exit;

  Try
    strTemp := fCampoTabela('DEP_CODIGO', 'CADDEP', ['DEP_CODVEL', 'DEP_DESCRI'],
      [params.strCodigo, params.strDescricao]);

    If (fEmptyStr(strTemp)) Then Begin
      strTemp := fCampoTabela('DEP_CODIGO', 'CADDEP', ['DEP_CODIGO', 'DEP_DESCRI'],
        [params.strCodigo, params.strDescricao]);
    End;

    Self.Append();
    Self.FieldByName('ID').AsInteger := params.intID;
    Self.FieldByName('DEP_CODIGO').AsString := strTemp;
    Self.FieldByName('DEP_CODAUT').AsString := strTemp;
    Self.FieldByName('DEP_CODVEL').AsString := params.strCodigo;
    Self.FieldByName('DEP_DESCRI').AsString := params.strDescricao;
    Self.FieldByName('DEP_CODEMP').AsString := VS_strCodEmp;
    Self.FieldByName('AUTOINCREM').AsString := '';
    Self.FieldByName('DEP_PROEMB').AsString := 'N';
    Self.FieldByName('DEP_PROMAP').AsString := 'N';
    Self.FieldByName('DEP_PROGRA').AsString := 'N';
    Self.FieldByName('DEP_PROACA').AsString := 'N';
    Self.Post();

    FMemoLog.Lines.Add('DEPARTAMENTO ADICIONADO NO DATASET: CÓDIGO ANTERIOR: ' + params.strCodigo +
      ' | CÓD.: ' + strTemp);
  Except
    On E : Exception Do
		  pMensagensErro(E.Message, '[TCadDep.pAdicionar]');
  End;
end;

procedure TCadDep.pCriarCampos;
begin
  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'ID'; DataType := ftInteger; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'DEP_CODVEL'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'DEP_CODIGO'; DataType := ftString; Size := 3; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'DEP_CODAUT'; DataType := ftString; Size := 3; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'DEP_DESCRI'; DataType := ftString; Size := 40; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'DEP_CODEMP'; DataType := ftString; Size := 3; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'AUTOINCREM'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'DEP_PROEMB'; DataType := ftString; Size := 1; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'DEP_PROMAP'; DataType := ftString; Size := 1; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'DEP_PROGRA'; DataType := ftString; Size := 1; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'DEP_PROACA'; DataType := ftString; Size := 1; Required := False;
  End;

  Self.IndexName := 'ID';
  Self.IndexFieldNames := 'ID;DEP_CODIGO;DEP_CODAUT;DEP_CODVEL';
end;

{ TImpProduto }

function TImpProduto.fAdicionarIteBar: Boolean;
  Var
    qryTempBar: TUniQuery;
    strTemp, strAutIncEmb, strCodBarAtu, strCodBar: String;

  procedure pApagarIteBar;
    Var
      qryTemp: TUniQuery;
  begin
    Try
      qryTemp := fCriaQuery(nil);

      Try
        qryTemp.Close();
        qryTemp.SQL.Clear();
        qryTemp.SQL.Text := SQL_DELETE_ITEBAR;
        qryTemp.ParamByName('AUTINC').AsString := strAutIncEmb;
        qryTemp.ExecSQL();
      Except
        On E: Exception Do Begin
          pMensagensErro(E.Message, '[TImpProduto.fAdicionarIteBar.pApagarIteBar]');
          FMemoLog.Lines.Add(#13#10 + 'ERRO: ' + E.Message + #13#10);
        End;
      End;
    Finally
      FreeAndNil(qryTemp);
    End;
  end;

  procedure pInicializarQryBar(blnInserir: Boolean); begin
    qryTempBar.Close();
    qryTempBar.SQL.Clear();
    qryTempBar.SQL.Text := SQL_INSERT_ITEBAR;

    If (Not blnInserir) Then
      pApagarIteBar();

    qryTempBar.ParamByName('AUTINC').AsString  := fRetAutoIncrem('ITEBAR', VS_strCodEmp);
    qryTempBar.ParamByName('CODITE').AsString  := Self.FieldByName('IMP_CODITE').AsString;
    qryTempBar.ParamByName('CODBAR').AsString  := '';
    qryTempBar.ParamByName('CODEMP').AsString  := Self.FieldByName('IMP_CODEMP').AsString;
    qryTempBar.ParamByName('EXBFAT').AsString  := 'S';
    qryTempBar.ParamByName('DESCRI').AsString  := '';
    qryTempBar.ParamByName('TABPRE').AsString  := 'F';
    qryTempBar.ParamByName('LASTRO').AsInteger := 0;
    qryTempBar.ParamByName('CAMADA').AsInteger := 0;
    qryTempBar.ParamByName('EMPMAX').AsInteger := 0;
    qryTempBar.ParamByName('PRINCI').AsInteger := 0;
    qryTempBar.ParamByName('COMPRA').AsInteger := 0;
    qryTempBar.ParamByName('ALTURA').AsFloat   := 0;
    qryTempBar.ParamByName('LARGUR').AsFloat   := 0;
    qryTempBar.ParamByName('PROFUN').AsFloat   := 0;
    qryTempBar.ParamByName('PESOBR').AsFloat   := 0;
    qryTempBar.ParamByName('PESOLQ').AsFloat   := 0;
    qryTempBar.ParamByName('EMBALA').AsFloat   := 1;
    qryTempBar.ParamByName('PREVEN').AsFloat   := 0;
  end;

begin
  Result := True;

  Try
    strAutIncEmb := '';

    qryTempBar := fCriaQuery(nil);

    Try
      //ADICIONA REGISTROS DAS EMBALAGENS - ITEBAR
      If (Not fEmptyStr(Self.FieldByName('IMP_CODBAR').AsString)) Then Begin
        //ADICIONA O IMP_CODBAR

        strTemp := fCampoTabela('CONCAT(AUTOINCREM, "-", BAR_CODBAR)',
                                'ITEBAR',
                                ['BAR_CODEMP',
                                 'BAR_CODITE',
                                 'BAR_PRINCI'],
                                [Self.FieldByName('IMP_CODEMP').AsString,
                                 Self.FieldByName('IMP_CODITE').AsString,
                                 '1']);

        strAutIncEmb := Copy(strTemp, 01, 20);
        strCodBarAtu := Copy(strTemp, 22, Length(strTemp));

        strCodBar := fCampoTabela('AUTOINCREM',
                                  'ITEBAR',
                                  ['BAR_CODBAR',
                                   'BAR_CODITE'],
                                  [Self.FieldByName('IMP_CODBAR').AsString,
                                   Self.FieldByName('IMP_CODITE').AsString]);

        If (strCodBarAtu <> Self.FieldByName('IMP_CODBAR').AsString) And (fEmptyStr(strCodBar)) Then Begin

          qryTempBar.Close;
          qryTempBar.SQL.Clear;
          qryTempBar.SQL.Text := SQL_UPDATE_ITEBAR_PRINCIPAL;
          qryTempBar.ParamByName('CODITE').AsString := Self.FieldByName('IMP_CODITE').AsString;
          qryTempBar.ExecSQL();

          pInicializarQryBar(fEmptyStr(strAutIncEmb));
          qryTempBar.ParamByName('CODBAR').AsString  := Self.FieldByName('IMP_CODBAR').AsString;
          qryTempBar.ParamByName('PRINCI').AsInteger := 1;
          qryTempBar.ExecSQL();

          If (fEmptyStr(strCodBarAtu)) Then
            FMemoLog.Lines.Add('EMBALAGEM (PRINC) PRODUTO (ITEBAR) ADICIONADO AO BD: CÓD. ANT. : ' +
              Self.FieldByName('IMP_CODVEL').AsString +
              ' | CÓD.: '  + Self.FieldByName('IMP_CODITE').AsString +
              ' | CODBAR: ' + Self.FieldByName('IMP_CODBAR').AsString)
          Else
            FMemoLog.Lines.Add('EMBALAGEM (PRINC) PRODUTO (ITEBAR) ADICIONADO AO BD: CÓD. ANT. : ' +
              Self.FieldByName('IMP_CODVEL').AsString +
              ' | CÓD.: '  + Self.FieldByName('IMP_CODITE').AsString +
              ' | CODBAR ANT.: ' + strCodBarAtu +
              ' | CODBAR ATUAL:' + Self.FieldByName('IMP_CODBAR').AsString)
        End;

        //ADICIONA O IMP_BAREMB
        If (Not fEmptyStr(Self.FieldByName('IMP_BAREMB').AsString)) Then
           //(qryTempBar.ParamByName('EMBALA').AsFloat > 0) Then
        Begin

          strAutIncEmb := fCampoTabela('BAR_CODBAR',
                                       'ITEBAR',
                                       ['BAR_CODEMP',
                                        'BAR_CODITE',
                                        'BAR_COMPRA'],
                                       [Self.FieldByName('IMP_CODEMP').AsString,
                                        Self.FieldByName('IMP_CODITE').AsString,
                                        '1']);

          strCodBar := fCampoTabela('AUTOINCREM',
                                    'ITEBAR',
                                    ['BAR_CODBAR',
                                     'BAR_CODITE'],
                                    [Self.FieldByName('IMP_BAREMB').AsString,
                                     Self.FieldByName('IMP_CODITE').AsString]);

          If (strAutIncEmb <> Self.FieldByName('IMP_BAREMB').AsString) And (fEmptyStr(strCodBar)) Then Begin
            qryTempBar.Close;
            qryTempBar.SQL.Clear;
            qryTempBar.SQL.Text := SQL_UPDATE_ITEBAR_PRINCIPAL_COMPRA;
            qryTempBar.ParamByName('CODITE').AsString := Self.FieldByName('IMP_CODITE').AsString;
            qryTempBar.ExecSQL();

            pInicializarQryBar(fEmptyStr(strAutIncEmb));

            qryTempBar.ParamByName('CODBAR').AsString  := Self.FieldByName('IMP_BAREMB').AsString;
            qryTempBar.ParamByName('EMBALA').AsFloat   := qryTempBar.ParamByName('EMBALA').AsFloat;
            qryTempBar.ParamByName('COMPRA').AsInteger := 1;
            qryTempBar.ExecSQL();

            FMemoLog.Lines.Add('EMBALAGEM (COMPRA) PRODUTO (ITEBAR) ADICIONADO AO BD: CÓD. ANT. : ' +
              Self.FieldByName('IMP_CODVEL').AsString +
              ' | CÓD.: '  + Self.FieldByName('IMP_CODITE').AsString +
              ' | CODBAR: ' + Self.FieldByName('IMP_BAREMB').AsString)
          End;
        End;
        fAtualizaBarFabIte(Self.FieldByName('IMP_CODITE').AsString)
      End;
    Except
      On E: Exception Do Begin
        Result := False;
        pMensagensErro(E.Message, '[TImpProduto.fAdicionarIteBar]');
        FMemoLog.Lines.Add(#13#10 + 'ERRO: ' + E.Message + #13#10);
      End;
    End;
  Finally
    FreeAndNil(qryTempBar);
  End;
end;

function TImpProduto.fAdicionarIteGer(blnInserir: Boolean): Boolean;
  Var
    recProdUpdate: TProduto;
    qryTempGer, qryCadEmp: TUniQuery;

  function fGetCamposUpdate: String;
    Var i, intUltimo: Integer;
  begin
    Result := '';
    intUltimo := 0;

    For i := 1 To 7 Do Begin
      If (Copy(fCfgSis('TABIMP', varString), i, 1) = 'S') Then Begin
        Case (TTipoAltPrecoFranq(fCfgSis('PVCSFQ', varInteger))) Of
          taPrecoCusAltPreVen: //Recalcular o preço de Venda
            Begin
              Result := Result + ' ITE_MARBR' + IntToStr(i) + ' = :MARBR' + IntToStr(i) + ', '
                               + ' ITE_PREVE' + IntToStr(i) + ' = :PREVE' + IntToStr(i) + ', ';
            End;

          taPrecoCusAltMargem:
            Begin
              Result := Result + ' ITE_MARBR' + IntToStr(i) + ' = :MARBR' + IntToStr(i) + ', '
                               + ' ITE_PREVE' + IntToStr(i) + ' = :PREVE' + IntToStr(i) + ', ';
            End;

          taPreVenAltMargem: //Recalcular a margem
            Begin
                Result := Result + ' ITE_MARBR' + IntToStr(i) + ' = :MARBR' + IntToStr(i) + ', '
                                 + ' ITE_PREVE' + IntToStr(i) + ' = :PREVE' + IntToStr(i) + ', ';
                intUltimo := i;
            End;
        End;
      End;
    End;

    Case (TTipoAltPrecoFranq(fCfgSis('PVCSFQ', varInteger))) Of
      taPrecoCusAltPreVen,
      taPrecoCusAltMargem: //Recalcular o preço de Venda
        Begin
          Result := Result +
          ' ITE_PRECOM = :PRECOM, ' +
          ' ITE_ICMENT = :ICMENT, ' +
          ' ITE_SUBFED = :SUBFED, ' +
          ' ITE_IPIENT = :IPIENT, ' +
          ' ITE_FREENT = :FREENT, ' +
          ' ITE_VALFRE = :VALFRE, ' +
          ' ITE_ACRFIN = :ACRFIN, ' +
          ' ITE_SUBSTI = :SUBSTI, ' +
          ' ITE_DESADB = :DESADB, ' +
          ' ITE_OUTVAL = :OUTVAL, ' +
          ' ITE_ICMSAI = :ICMSAI, ' +
          ' ITE_IMPFED = :IMPFED, ' +
          ' ITE_DESOPE = :DESOPE, ' +
          ' ITE_PRECUS = :PRECUS, ' +
          ' ITE_DESF01 = :DESF01, ' +
          ' ITE_DESF02 = :DESF02, ' +
          ' ITE_DESF03 = :DESF03, ' +
          ' ITE_DESF04 = :DESF04, ' +
          ' ITE_DESF05 = :DESF05, ' +
          ' ITE_DESF06 = :DESF06, ' +
          ' ITE_TCIFCU = :TCIFCU, ' +
          ' ITE_TSCUST = :TSCUST, ' +
          ' ITE_DEPICO = :DEPICO, ' +
          ' ITE_DEICMS = :DEICMS, ' +
          ' ITE_FATREG = :FATREG  ';
        End;

      taPreVenAltMargem: //Recalcular a margem
        Begin
          Result := AnsiReplaceStr(Result, ':PREVE' + IntToStr(intUltimo) + ', ', ':PREVE' + IntToStr(intUltimo) + ' ');
        End;
    End;
  end;

  function fBuildSetIteger: String;
  var
    strSet: String;

    procedure pCampo(const AstrField, AstrParam: String);
    begin
      strSet := strSet + '  ' + AstrField + ' = :' + AstrParam + ', ';
    end;

  begin
    strSet := '';

    pCampo('ITE_CODVEL', 'CODVEL');
    pCampo('ITE_IMPLIS', 'IMPLIS');
    If Not fCampoExcluido('ITE_COMVAR') Then
      pCampo('ITE_COMVAR', 'COMVAR');
    If Not fCampoExcluido('ITE_COMATA') Then
      pCampo('ITE_COMATA', 'COMATA');
    If Not fCampoExcluido('ITE_COMDIS') Then
      pCampo('ITE_COMDIS', 'COMDIS');
    If Not fCampoExcluido('ITE_DESMAX') Then
      pCampo('ITE_DESMAX', 'DESMAX');
    If Not fCampoExcluido('ITE_DESMSU') Then
      pCampo('ITE_DESMSU', 'DESMSU');
    If Not fCampoExcluido('ITE_MARMIN') Then
      pCampo('ITE_MARMIN', 'MARMIN');
    If Not fCampoExcluido('ITE_MARMSG') Then
      pCampo('ITE_MARMSG', 'MARMSG');
    If Not fCampoExcluido('ITE_MARMGE') Then
      pCampo('ITE_MARMGE', 'MARMGE');
    pCampo('ITE_CPRCEN', 'CPRCEN');
    pCampo('ITE_ABAMLT', 'ABAMLT');
    If Not fCampoExcluido('ITE_ESMIDG') Then
      pCampo('ITE_ESMIDG', 'ESMIDG');
    pCampo('ITE_CODABF', 'CODABF');
    pCampo('ITE_IPISAI', 'IPISAI');
    pCampo('ITE_EXCIPI', 'EXCIPI');
    pCampo('ITE_ABFPIS', 'ABFPIS');
    pCampo('ITE_ABFCOF', 'ABFCOF');
    pCampo('ITE_ABFIPI', 'ABFIPI');
    pCampo('ITE_TIPPRO', 'TIPPRO');
    If Not fCampoExcluido('ITE_ESTMIN') Then
      pCampo('ITE_ESTMIN', 'ESTMIN');
    If Not fCampoExcluido('ITE_ESTMAX') Then
      pCampo('ITE_ESTMAX', 'ESTMAX');
    If Not fCampoExcluido('ITE_LOCFIS') Then
      pCampo('ITE_LOCFIS', 'LOCFIS');
    If Not fCampoExcluido('ITE_LOCSUP') Then
      pCampo('ITE_LOCSUP', 'LOCSUP');
    If Not fCampoExcluido('ITE_DESMGE') Then
      pCampo('ITE_DESMGE', 'DESMGE');
    If Not fCampoExcluido('ITE_COMTB1') Then
      pCampo('ITE_COMTB1', 'COMTB1');
    If Not fCampoExcluido('ITE_COMTB2') Then
      pCampo('ITE_COMTB2', 'COMTB2');
    If Not fCampoExcluido('ITE_COMTB3') Then
      pCampo('ITE_COMTB3', 'COMTB3');
    If Not fCampoExcluido('ITE_COMTB4') Then
      pCampo('ITE_COMTB4', 'COMTB4');
    If Not fCampoExcluido('ITE_COMTB5') Then
      pCampo('ITE_COMTB5', 'COMTB5');
    If Not fCampoExcluido('ITE_COMTB6') Then
      pCampo('ITE_COMTB6', 'COMTB6');
    If Not fCampoExcluido('ITE_COMTB7') Then
      pCampo('ITE_COMTB7', 'COMTB7');
    If (not fCampoExcluido('ITE_NVLGIR')) and (qryCadEmp.FieldByName('CFG_TIPGIR').AsString = 'S') then
      pCampo('ITE_NIVGIR', 'NVLGIR');

    pCampo('ITE_OBRNFE', 'OBRNFE');

    Result := 'UPDATE ITEGER SET ' + strSet;
  end;

  procedure pInicializarQryGer; begin
    qryTempGer.Close();
    qryTempGer.SQL.Clear();

    If (blnInserir) Then
      qryTempGer.SQL.Text := SQL_INSERT_ITEGER
    Else Begin
      qryTempGer.SQL.Text := fBuildSetIteger() + fGetCamposUpdate() + SQL_UPDATE_ITEGER_WHERE;
    End;
  end;

  procedure pInicializarCadEmp; begin
    qryCadEmp.Close();
    qryCadEmp.SQL.Clear();
    qryCadEmp.SQL.Text := 'SELECT EMP_CODEMP, SIS_VALCFG AS CFG_TIPGIR FROM CADEMP LEFT JOIN CFGSIS ON SIS_CODCFG = "CFG_TIPGIR" AND SIS_CODEMP = EMP_CODEMP';
    qryCadEmp.Open();
    qryCadEmp.First();
  end;

  procedure pCalcularCustoPreVenMargem(taTipoAltPrecoFranq: TTipoAltPrecoFranq);
    Var
      i: Integer;
  begin
    //Custo
    If (taTipoAltPrecoFranq In [taPrecoCusAltPreVen, taPrecoCusAltMargem]) Or (blnInserir) Then Begin
      qryTempGer.ParamByName('PRECOM').AsFloat  := Self.FieldByName('IMP_PRECOM').AsFloat;
      qryTempGer.ParamByName('ICMENT').AsFloat  := Self.FieldByName('IMP_ICMENT').AsFloat;
      qryTempGer.ParamByName('SUBFED').AsFloat  := Self.FieldByName('IMP_SUBFED').AsFloat;
      qryTempGer.ParamByName('IPIENT').AsFloat  := Self.FieldByName('IMP_IPIENT').AsFloat;
      qryTempGer.ParamByName('FREENT').AsFloat  := Self.FieldByName('IMP_FREENT').AsFloat;
      qryTempGer.ParamByName('VALFRE').AsFloat  := Self.FieldByName('IMP_VALFRE').AsFloat;
      qryTempGer.ParamByName('ACRFIN').AsFloat  := Self.FieldByName('IMP_ACRFIN').AsFloat;
      qryTempGer.ParamByName('SUBSTI').AsFloat  := Self.FieldByName('IMP_SUBSTI').AsFloat;
      qryTempGer.ParamByName('DESADB').AsFloat  := Self.FieldByName('IMP_DESADB').AsFloat;
      qryTempGer.ParamByName('OUTVAL').AsFloat  := Self.FieldByName('IMP_OUTVAL').AsFloat;
      qryTempGer.ParamByName('ICMSAI').AsFloat  := Self.FieldByName('IMP_ICMSAI').AsFloat;
      qryTempGer.ParamByName('IMPFED').AsFloat  := Self.FieldByName('IMP_IMPFED').AsFloat;
      qryTempGer.ParamByName('DESOPE').AsFloat  := Self.FieldByName('IMP_DESOPE').AsFloat;
      qryTempGer.ParamByName('PRECUS').AsFloat  := Self.FieldByName('IMP_PRECUS').AsFloat;
      qryTempGer.ParamByName('TCIFCU').AsFloat  := Self.FieldByName('IMP_TCIFCU').AsFloat;
      qryTempGer.ParamByName('TSCUST').AsFloat  := Self.FieldByName('IMP_TSCUST').AsFloat;
      qryTempGer.ParamByName('DEPICO').AsFloat  := Self.FieldByName('IMP_DEPICO').AsFloat;
      qryTempGer.ParamByName('DEICMS').AsFloat  := Self.FieldByName('IMP_DEICMS').AsFloat;
      qryTempGer.ParamByName('FATREG').AsFloat  := Self.FieldByName('IMP_FATREG').AsFloat;
    End;

    //Comissão Tabela
    If qryTempGer.FindParam('COMTB1') <> nil Then
      qryTempGer.ParamByName('COMTB1').AsFloat := Self.FieldByName('IMP_COMTB1').AsFloat;

    If qryTempGer.FindParam('COMTB2') <> nil Then
      qryTempGer.ParamByName('COMTB2').AsFloat := Self.FieldByName('IMP_COMTB2').AsFloat;

    If qryTempGer.FindParam('COMTB3') <> nil Then
      qryTempGer.ParamByName('COMTB3').AsFloat := Self.FieldByName('IMP_COMTB3').AsFloat;

    If qryTempGer.FindParam('COMTB4') <> nil Then
      qryTempGer.ParamByName('COMTB4').AsFloat := Self.FieldByName('IMP_COMTB4').AsFloat;

    If qryTempGer.FindParam('COMTB5') <> nil Then
      qryTempGer.ParamByName('COMTB5').AsFloat := Self.FieldByName('IMP_COMTB5').AsFloat;

    If qryTempGer.FindParam('COMTB6') <> nil Then
      qryTempGer.ParamByName('COMTB6').AsFloat := Self.FieldByName('IMP_COMTB6').AsFloat;

    If qryTempGer.FindParam('COMTB7') <> nil Then
      qryTempGer.ParamByName('COMTB7').AsFloat := Self.FieldByName('IMP_COMTB7').AsFloat;

    If ((taTipoAltPrecoFranq In [taPrecoCusAltPreVen, taPrecoCusAltMargem]) Or (blnInserir)) Then Begin
      qryTempGer.ParamByName('DESF01').AsFloat  := Self.FieldByName('IMP_DESF01').AsFloat;
      qryTempGer.ParamByName('DESF02').AsFloat  := Self.FieldByName('IMP_DESF02').AsFloat;
      qryTempGer.ParamByName('DESF03').AsFloat  := Self.FieldByName('IMP_DESF03').AsFloat;
      qryTempGer.ParamByName('DESF04').AsFloat  := Self.FieldByName('IMP_DESF04').AsFloat;
      qryTempGer.ParamByName('DESF05').AsFloat  := Self.FieldByName('IMP_DESF05').AsFloat;
      qryTempGer.ParamByName('DESF06').AsFloat  := Self.FieldByName('IMP_DESF06').AsFloat;
    End;

    For i := 1 To 7 Do Begin
      If (Copy(fCfgSis('TABIMP', varString), i, 1) = 'S') Then Begin
        //Margem
        If (taTipoAltPrecoFranq In [taPrecoCusAltPreVen]) Or (blnInserir) Then Begin
          qryTempGer.ParamByName('MARBR' + IntToStr(i)).AsFloat := Self.FieldByName('IMP_MARBR' + IntToStr(i)).AsFloat;
        End;

        //Preço Venda
        If (taTipoAltPrecoFranq In [taPrecoCusAltMargem, taPreVenAltMargem]) Or (blnInserir) Then Begin
          qryTempGer.ParamByName('PREVE' + IntToStr(i)).AsFloat := Self.FieldByName('IMP_PREVE' + IntToStr(i)).AsFloat;
        End;

        If (Not blnInserir) Then Begin
          Case (taTipoAltPrecoFranq) Of
            taPrecoCusAltPreVen: //Recalcular o preço de Venda
              Begin
                qryTempGer.ParamByName('PREVE' + IntToStr(i)).AsFloat := Self.FieldByName('IMP_PREVE' + IntToStr(i)).AsFloat;
              End;

            taPrecoCusAltMargem,
            taPreVenAltMargem: //Recalcular a margem
              Begin
                qryTempGer.ParamByName('MARBR' + IntToStr(i)).AsFloat := Self.FieldByName('IMP_MARBR' + IntToStr(i)).AsFloat;
              End;
          End;
        End;
      End;
    End;
  end;
begin
  Result := True;

  Try
    qryTempGer := fCriaQuery(nil);
    qryCadEmp  := fCriaQuery(nil);

    //INCLUI OS REGISTROS DA ITEGER, UM REGISTRO PARA CADA EMPRESA NA CADEMP
    Try
      pInicializarCadEmp();

      While (Not qryCadEmp.Eof) Do Begin
        pInicializarQryGer();

        If (blnInserir) Then
          qryTempGer.ParamByName('AUTINC').AsString := fRetAutoIncrem('ITEGER', VS_strCodEmp)
        Else
          recProdUpdate := fGetRecProdutoUpdate(Self.FieldByName('IMP_CODITE').AsString, Self.FieldByName('IMP_CODEMP').AsString, False);

        qryTempGer.ParamByName('CODITE').AsString := Self.FieldByName('IMP_CODITE').AsString;
        qryTempGer.ParamByName('CODEMP').AsString := qryCadEmp.FieldByName('EMP_CODEMP').AsString;

        If (Not fEmptyStr(Self.FieldByName('IMP_IMPLIS').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
          qryTempGer.ParamByName('IMPLIS').AsString := Self.FieldByName('IMP_IMPLIS').AsString
        Else
          qryTempGer.ParamByName('IMPLIS').AsString := recProdUpdate.IMP_IMPLIS;

        If (Not fEmptyStr(Self.FieldByName('IMP_CPRCEN').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
          qryTempGer.ParamByName('CPRCEN').AsString := Self.FieldByName('IMP_IMPLIS').AsString
        Else
          qryTempGer.ParamByName('CPRCEN').AsString := recProdUpdate.IMP_CPRCEN;

        If (Not fEmptyStr(Self.FieldByName('IMP_ABAMLT').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
          qryTempGer.ParamByName('ABAMLT').AsString := Self.FieldByName('IMP_ABAMLT').AsString
        Else
          qryTempGer.ParamByName('ABAMLT').AsString := recProdUpdate.IMP_ABAMLT;

        If qryTempGer.FindParam('ESMIDG') <> nil Then
        Begin
          If (Not fEmptyStr(Self.FieldByName('IMP_ESMIDG').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempGer.ParamByName('ESMIDG').AsString := Self.FieldByName('IMP_ESMIDG').AsString
          Else
            qryTempGer.ParamByName('ESMIDG').AsString := recProdUpdate.IMP_ESMIDG;
        End;

        If (Not fEmptyStr(Self.FieldByName('IMP_EXCIPI').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
          qryTempGer.ParamByName('EXCIPI').AsString := Self.FieldByName('IMP_EXCIPI').AsString
        Else
          qryTempGer.ParamByName('EXCIPI').AsString := recProdUpdate.IMP_EXCIPI;

        If (Not fEmptyStr(Self.FieldByName('IMP_TIPPRO').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
          qryTempGer.ParamByName('TIPPRO').AsString := Self.FieldByName('IMP_TIPPRO').AsString
        Else
          qryTempGer.ParamByName('TIPPRO').AsString := recProdUpdate.IMP_TIPPRO;

        If qryTempGer.FindParam('LOCFIS') <> nil Then
        Begin
          If (Not fEmptyStr(Self.FieldByName('IMP_LOCFIS').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempGer.ParamByName('LOCFIS').AsString := Self.FieldByName('IMP_LOCFIS').AsString
          Else
            qryTempGer.ParamByName('LOCFIS').AsString := recProdUpdate.IMP_LOCFIS;
        End;

        If qryTempGer.FindParam('LOCSUP') <> nil Then
        Begin
          If (Not fEmptyStr(Self.FieldByName('IMP_LOCSUP').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempGer.ParamByName('LOCSUP').AsString := Self.FieldByName('IMP_LOCSUP').AsString
          Else
            qryTempGer.ParamByName('LOCSUP').AsString := recProdUpdate.IMP_LOCSUP;
        End;

        If (Not fEmptyStr(Self.FieldByName('IMP_CODVEL').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
          qryTempGer.ParamByName('CODVEL').AsString := Self.FieldByName('IMP_CODVEL').AsString
        Else
          qryTempGer.ParamByName('CODVEL').AsString := recProdUpdate.IMP_CODVEL;

        If (fCfgSis('TIPABF', varString) = '2') Then Begin
          If (Not fEmptyStr(Self.FieldByName('IMP_CODABF').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempGer.ParamByName('CODABF').AsString := Self.FieldByName('IMP_CODABF').AsString
          Else
            qryTempGer.ParamByName('CODABF').AsString := recProdUpdate.IMP_CODABF;
        End Else
          qryTempGer.ParamByName('CODABF').Clear();

        If (fCfgSis('NFEPEP', varBoolean)) Then Begin
          If (Not fEmptyStr(Self.FieldByName('IMP_OBRNFE').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempGer.ParamByName('OBRNFE').AsString := Self.FieldByName('IMP_OBRNFE').AsString
          Else
            qryTempGer.ParamByName('OBRNFE').AsString := recProdUpdate.IMP_OBRNFE;
        End Else
          qryTempGer.ParamByName('OBRNFE').Clear();

        If (fCfgSis('TPABPC', varString) = '2') Then Begin
          If (Not fEmptyStr(Self.FieldByName('IMP_ABFPIS').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempGer.ParamByName('ABFPIS').AsString := Self.FieldByName('IMP_ABFPIS').AsString
          Else
            qryTempGer.ParamByName('ABFPIS').AsString := recProdUpdate.IMP_ABFPIS;
        End Else
          qryTempGer.ParamByName('ABFPIS').Clear();

        If (fCfgSis('TPABPC', varString) = '2') Then Begin
          If (Not fEmptyStr(Self.FieldByName('IMP_ABFCOF').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempGer.ParamByName('ABFCOF').AsString := Self.FieldByName('IMP_ABFCOF').AsString
          Else
            qryTempGer.ParamByName('ABFCOF').AsString := recProdUpdate.IMP_ABFCOF;
        End Else
          qryTempGer.ParamByName('ABFCOF').Clear();

        If (Not fEmptyStr(Self.FieldByName('IMP_ABFIPI').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
          qryTempGer.ParamByName('ABFIPI').AsString := Self.FieldByName('IMP_ABFIPI').AsString
        Else
          qryTempGer.ParamByName('ABFIPI').AsString := recProdUpdate.IMP_ABFIPI;

        If qryTempGer.FindParam('COMVAR') <> nil Then
          qryTempGer.ParamByName('COMVAR').AsFloat := Self.FieldByName('IMP_COMVAR').AsFloat;
        If qryTempGer.FindParam('COMATA') <> nil Then
          qryTempGer.ParamByName('COMATA').AsFloat := Self.FieldByName('IMP_COMATA').AsFloat;
        If qryTempGer.FindParam('COMDIS') <> nil Then
          qryTempGer.ParamByName('COMDIS').AsFloat := Self.FieldByName('IMP_COMDIS').AsFloat;
        If qryTempGer.FindParam('DESMAX') <> nil Then
          qryTempGer.ParamByName('DESMAX').AsFloat := Self.FieldByName('IMP_DESMAX').AsFloat;
        If qryTempGer.FindParam('DESMSU') <> nil Then
          qryTempGer.ParamByName('DESMSU').AsFloat := Self.FieldByName('IMP_DESMSU').AsFloat;
        If qryTempGer.FindParam('MARMIN') <> nil Then
          qryTempGer.ParamByName('MARMIN').AsFloat := Self.FieldByName('IMP_MARMIN').AsFloat;
        If qryTempGer.FindParam('MARMSG') <> nil Then
          qryTempGer.ParamByName('MARMSG').AsFloat := Self.FieldByName('IMP_MARMSG').AsFloat;
        If qryTempGer.FindParam('MARMGE') <> nil Then
          qryTempGer.ParamByName('MARMGE').AsFloat := Self.FieldByName('IMP_MARMGE').AsFloat;
        If qryTempGer.FindParam('ESTMIN') <> nil Then
          qryTempGer.ParamByName('ESTMIN').AsFloat := Self.FieldByName('IMP_ESTMIN').AsFloat;
        If qryTempGer.FindParam('ESTMAX') <> nil Then
          qryTempGer.ParamByName('ESTMAX').AsFloat := Self.FieldByName('IMP_ESTMAX').AsFloat;
        If qryTempGer.FindParam('DESMGE') <> nil Then
          qryTempGer.ParamByName('DESMGE').AsFloat := Self.FieldByName('IMP_DESMGE').AsFloat;
        If qryTempGer.FindParam('NVLGIR') <> nil Then
          qryTempGer.ParamByName('NVLGIR').AsString := Self.FieldByName('IMP_NVLGIR').AsString;

        qryTempGer.ParamByName('IPISAI').AsFloat  := Self.FieldByName('IMP_IPISAI').AsFloat;

        pCalcularCustoPreVenMargem(TTipoAltPrecoFranq(fCfgSis('PVCSFQ', varInteger)));

        If (blnInserir) Then Begin
          qryTempGer.ParamByName('SALBAL').AsFloat  := 0;
          qryTempGer.ParamByName('ML_BAL').AsFloat  := 0;
          qryTempGer.ParamByName('SALDOS').AsFloat  := 0;
          qryTempGer.ParamByName('SAL_ML').AsFloat  := 0;
          qryTempGer.ParamByName('DTABAL').AsDateTime := fNow() - 1;
        End;

        If (fEmptyStr(qryTempGer.ParamByName('ABFPIS').AsString)) Then
          qryTempGer.ParamByName('ABFPIS').Clear();

        If (fEmptyStr(qryTempGer.ParamByName('ABFCOF').AsString)) Then
          qryTempGer.ParamByName('ABFCOF').Clear();

        If (fEmptyStr(qryTempGer.ParamByName('ABFIPI').AsString)) Then
          qryTempGer.ParamByName('ABFIPI').Clear();

        If (fEmptyStr(qryTempGer.ParamByName('CODABF').AsString)) Then
          qryTempGer.ParamByName('CODABF').Clear();

        qryTempGer.ExecSQL();

        If (blnInserir) Then
          pIncluiRegistroSaldoPedidoCompra(Self.FieldByName('IMP_CODITE').AsString, qryCadEmp.FieldByName('EMP_CODEMP').AsString);

        //Criar A Girite;
        If (blnInserir) Then
           fAdicionarGirIte(qryCadEmp.FieldByName('EMP_CODEMP').AsString,
                            Self.FieldByName('IMP_CODITE').AsString);

        If (blnInserir) Then
          FMemoLog.Lines.Add('PRODUTO (ITEGER) ADICIONADO AO BD: CÓD. ANT. : ' +
            Self.FieldByName('IMP_CODVEL').AsString +
            ' | CÓD.: '  + Self.FieldByName('IMP_CODITE').AsString +
            ' | EMP.: ' + qryCadEmp.FieldByName('EMP_CODEMP').AsString)
        Else
          FMemoLog.Lines.Add('PRODUTO (ITEGER) ALTERADO NO BD: CÓD. ANT. : ' +
            Self.FieldByName('IMP_CODVEL').AsString +
            ' | CÓD.: '  + Self.FieldByName('IMP_CODITE').AsString +
            ' | EMP.: ' + qryCadEmp.FieldByName('EMP_CODEMP').AsString);

        qryCadEmp.Next();
      End;
    Except
      On E : Exception Do Begin
        Result := False;
	  	  pMensagensErro(E.Message, '[TImpProduto.fAdicionarIteGer]');
        FMemoLog.Lines.Add(#13#10 + 'ERRO: ' + E.Message + #13#10);
      End;
    End;
  Finally
    FreeAndNil(qryTempGer);
    FreeAndNil(qryCadEmp);
  End;
end;

function TImpProduto.fGetRecProdutoUpdate(strCodIte, strCodEmp: String; blnCadIte: Boolean): TProduto;
  Var
    qryTemp: TUniQuery;
begin
  Try
    qryTemp := fCriaQuery(nil);

    pLimparTProdutoUpd();

    Try
      qryTemp.Close();
      qryTemp.SQL.Clear();

      If (blnCadIte) Then
        qryTemp.SQL.Text := 'SELECT * FROM CADITE WHERE ITE_CODITE = :CODITE'
      Else
      Begin
        qryTemp.SQL.Text := 'SELECT * FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP';
        qryTemp.ParamByName('CODEMP').AsString := strCodEmp;
      End;

      qryTemp.ParamByName('CODITE').AsString := strCodIte;
      qryTemp.Open();

      If (Not qryTemp.IsEmpty) Then Begin
        With qryTemp Do Begin
          If (blnCadIte) Then
          Begin
            Result.IMP_CODITE := FieldByName('ITE_CODITE').AsString;
            Result.IMP_CODVEL := FieldByName('ITE_CODVEL').AsString;
            Result.IMP_DESITE := FieldByName('ITE_DESITE').AsString;
            Result.IMP_DESSIM := FieldByName('ITE_DESSIM').AsString;
            Result.IMP_DESFAB := FieldByName('ITE_DESFAB').AsString;
            Result.IMP_CODFAB := FieldByName('ITE_CODFAB').AsString;
            Result.IMP_CODFOR := FieldByName('ITE_CODFOR').AsString;
            Result.IMP_REFERE := FieldByName('ITE_REFERE').AsString;
            Result.IMP_CODUNI := FieldByName('ITE_CODUNI').AsString;
            Result.IMP_CODMAR := FieldByName('ITE_CODMAR').AsString;
            Result.IMP_CODGRU := FieldByName('ITE_CODGRU').AsString;
            Result.IMP_CODDEP := FieldByName('ITE_CODDEP').AsString;
            Result.IMP_PRDGRU := FieldByName('ITE_PRDGRU').AsString;
            Result.IMP_CODBAR := FieldByName('ITE_CODBAR').AsString;
            Result.IMP_BAREMB := FieldByName('ITE_BAREMB').AsString;
            Result.IMP_EMBALA := FieldByName('ITE_EMBALA').AsString;
            Result.IMP_APLICA := FieldByName('ITE_APLICA').AsString;
            Result.IMP_ITEATI := FieldByName('ITE_ITEATI').AsString;
            Result.IMP_ITEBAS := FieldByName('ITE_ITEBAS').AsString;
            Result.IMP_ITEPIG := FieldByName('ITE_ITEPIG').AsString;
            Result.IMP_PROEMB := FieldByName('ITE_PROEMB').AsString;
            Result.IMP_VALOBR := FieldByName('ITE_VALOBR').AsString;
            Result.IMP_INFLAM := FieldByName('ITE_INFLAM').AsString;
            Result.IMP_BAREXP := FieldByName('ITE_BAREXP').AsString;
            Result.IMP_PEEFUT := FieldByName('ITE_PEEFUT').AsString;
            Result.IMP_PEFFPR := FieldByName('ITE_PEFFPR').AsString;
            Result.IMP_PEFUTP := FieldByName('ITE_PEFUTP').AsString;
            Result.IMP_MSGLV1 := FieldByName('ITE_MSGLV1').AsString;
            Result.IMP_MSGLV2 := FieldByName('ITE_MSGLV2').AsString;
            Result.IMP_INFGAR := FieldByName('ITE_INFGAR').AsString;
            Result.IMP_ATICOM := FieldByName('ITE_ATICOM').AsString;
            Result.IMP_CPRCEN := FieldByName('ITE_CPRCEN').AsString;
            Result.IMP_RPRENT := FieldByName('ITE_RPRENT').AsString;
            Result.IMP_NVLGIR := FieldByName('ITE_NVLGIR').AsString;
            Result.IMP_ACOOBJ := FieldByName('ITE_ACOOBJ').AsString;
            Result.IMP_REAEND := FieldByName('ITE_REAEND').AsString;
            Result.IMP_CODABF := FieldByName('ITE_CODABF').AsString;
            Result.IMP_CLAIPI := FieldByName('ITE_CLAIPI').AsString;
            Result.IMP_EXCIPI := FieldByName('ITE_EXCIPI').AsString;
            Result.IMP_CODFIN := FieldByName('ITE_CODFIN').AsString;
            Result.IMP_INCPIS := FieldByName('ITE_INCPIS').AsString;
            Result.IMP_COMLUB := FieldByName('ITE_COMLUB').AsString;
            Result.IMP_CODLUB := FieldByName('ITE_CODLUB').AsString;
            Result.IMP_OBRCPF := FieldByName('ITE_OBRCPF').AsString;
            Result.IMP_OBRIBA := FieldByName('ITE_OBRIBA').AsString;
            Result.IMP_ABFPIS := FieldByName('ITE_ABFPIS').AsString;
            Result.IMP_ABFCOF := FieldByName('ITE_ABFCOF').AsString;
            Result.IMP_ABFIPI := FieldByName('ITE_ABFIPI').AsString;
            Result.IMP_CDCEST := FieldByName('ITE_CDCEST').AsString;
            Result.IMP_MENFIS := FieldByName('ITE_MENFIS').AsString;
            Result.IMP_OBRNFE := FieldByName('ITE_OBRNFE').AsString;
            Result.IMP_NUMFCI := FieldByName('ITE_NUMFCI').AsString;
            Result.IMP_PRAPEL := FieldByName('ITE_PRAPEL').AsFloat;
            Result.IMP_PESOIT := FieldByName('ITE_PESOIT').AsFloat;
            Result.IMP_PESLIQ := FieldByName('ITE_PESLIQ').AsFloat;
            Result.IMP_MLTVEN := FieldByName('ITE_MLTVEN').AsFloat;
            Result.IMP_MLTCOM := FieldByName('ITE_MLTCOM').AsFloat;
            Result.IMP_PER_CI := FieldByName('ITE_PER_CI').AsFloat;
            Result.IMP_DIAFOR := FieldByName('ITE_DIAFOR').AsInteger;
            Result.IMP_TMPGAR := FieldByName('ITE_TMPGAR').AsInteger;
            Result.IMP_DTAIMP := 0;
          End
          Else
          Begin
            Result.IMP_CODITE := FieldByName('ITE_CODITE').AsString;
            Result.IMP_CODVEL := FieldByName('ITE_CODVEL').AsString;
            Result.IMP_IMPLIS := FieldByName('ITE_IMPLIS').AsString;
            Result.IMP_CPRCEN := FieldByName('ITE_CPRCEN').AsString;
            Result.IMP_ABAMLT := FieldByName('ITE_ABAMLT').AsString;
            Result.IMP_ESMIDG := FieldByName('ITE_ESMIDG').AsString;
            Result.IMP_CODABF := FieldByName('ITE_CODABF').AsString;
            Result.IMP_EXCIPI := FieldByName('ITE_EXCIPI').AsString;
            Result.IMP_ABFPIS := FieldByName('ITE_ABFPIS').AsString;
            Result.IMP_ABFCOF := FieldByName('ITE_ABFCOF').AsString;
            Result.IMP_ABFIPI := FieldByName('ITE_ABFIPI').AsString;
            Result.IMP_TIPPRO := FieldByName('ITE_TIPPRO').AsString;
            Result.IMP_LOCSUP := FieldByName('ITE_LOCSUP').AsString;
            Result.IMP_COMVAR := FieldByName('ITE_COMVAR').AsFloat;
            Result.IMP_COMATA := FieldByName('ITE_COMATA').AsFloat;
            Result.IMP_COMDIS := FieldByName('ITE_COMDIS').AsFloat;
            Result.IMP_DESMAX := FieldByName('ITE_DESMAX').AsFloat;
            Result.IMP_DESMSU := FieldByName('ITE_DESMSU').AsFloat;
            Result.IMP_MARMIN := FieldByName('ITE_MARMIN').AsFloat;
            Result.IMP_MARMSG := FieldByName('ITE_MARMSG').AsFloat;
            Result.IMP_IPISAI := FieldByName('ITE_IPISAI').AsFloat;
            Result.IMP_PRECOM := FieldByName('ITE_PRECOM').AsFloat;
            Result.IMP_DESF01 := FieldByName('ITE_DESF01').AsFloat;
            Result.IMP_DESF02 := FieldByName('ITE_DESF02').AsFloat;
            Result.IMP_DESF03 := FieldByName('ITE_DESF03').AsFloat;
            Result.IMP_DESF04 := FieldByName('ITE_DESF04').AsFloat;
            Result.IMP_DESF05 := FieldByName('ITE_DESF05').AsFloat;
            Result.IMP_DESF06 := FieldByName('ITE_DESF06').AsFloat;
            Result.IMP_ICMENT := FieldByName('ITE_ICMENT').AsFloat;
            Result.IMP_SUBFED := FieldByName('ITE_SUBFED').AsFloat;
            Result.IMP_IPIENT := FieldByName('ITE_IPIENT').AsFloat;
            Result.IMP_FREENT := FieldByName('ITE_FREENT').AsFloat;
            Result.IMP_VALFRE := FieldByName('ITE_VALFRE').AsFloat;
            Result.IMP_ACRFIN := FieldByName('ITE_ACRFIN').AsFloat;
            Result.IMP_SUBSTI := FieldByName('ITE_SUBSTI').AsFloat;
            Result.IMP_DESADB := FieldByName('ITE_DESADB').AsFloat;
            Result.IMP_OUTVAL := FieldByName('ITE_OUTVAL').AsFloat;
            Result.IMP_ICMSAI := FieldByName('ITE_ICMSAI').AsFloat;
            Result.IMP_IMPFED := FieldByName('ITE_IMPFED').AsFloat;
            Result.IMP_DESOPE := FieldByName('ITE_DESOPE').AsFloat;
            Result.IMP_COMTB1 := FieldByName('ITE_COMTB1').AsFloat;
            Result.IMP_MARBR1 := FieldByName('ITE_MARBR1').AsFloat;
            Result.IMP_PREVE1 := FieldByName('ITE_PREVE1').AsFloat;
            Result.IMP_COMTB2 := FieldByName('ITE_COMTB2').AsFloat;
            Result.IMP_MARBR2 := FieldByName('ITE_MARBR2').AsFloat;
            Result.IMP_PREVE2 := FieldByName('ITE_PREVE2').AsFloat;
            Result.IMP_COMTB3 := FieldByName('ITE_COMTB3').AsFloat;
            Result.IMP_MARBR3 := FieldByName('ITE_MARBR3').AsFloat;
            Result.IMP_PREVE3 := FieldByName('ITE_PREVE3').AsFloat;
            Result.IMP_COMTB4 := FieldByName('ITE_COMTB4').AsFloat;
            Result.IMP_MARBR4 := FieldByName('ITE_MARBR4').AsFloat;
            Result.IMP_PREVE4 := FieldByName('ITE_PREVE4').AsFloat;
            Result.IMP_COMTB5 := FieldByName('ITE_COMTB5').AsFloat;
            Result.IMP_MARBR5 := FieldByName('ITE_MARBR5').AsFloat;
            Result.IMP_PREVE5 := FieldByName('ITE_PREVE5').AsFloat;
            Result.IMP_COMTB6 := FieldByName('ITE_COMTB6').AsFloat;
            Result.IMP_MARBR6 := FieldByName('ITE_MARBR6').AsFloat;
            Result.IMP_PREVE6 := FieldByName('ITE_PREVE6').AsFloat;
            Result.IMP_COMTB7 := FieldByName('ITE_COMTB7').AsFloat;
            Result.IMP_MARBR7 := FieldByName('ITE_MARBR7').AsFloat;
            Result.IMP_PREVE7 := FieldByName('ITE_PREVE7').AsFloat;
            Result.IMP_ESTMIN := FieldByName('ITE_ESTMIN').AsFloat;
            Result.IMP_ESTMAX := FieldByName('ITE_ESTMAX').AsFloat;
            Result.IMP_LOCFIS := FieldByName('ITE_LOCFIS').AsString;
            Result.IMP_DESMGE := FieldByName('ITE_DESMGE').AsFloat;
            Result.IMP_MARMGE := FieldByName('ITE_MARMGE').AsFloat;
            Result.IMP_TCIFCU := FieldByName('ITE_TCIFCU').AsFloat;
            Result.IMP_TSCUST := FieldByName('ITE_TSCUST').AsFloat;
            Result.IMP_DEPICO := FieldByName('ITE_DEPICO').AsFloat;
            Result.IMP_DEICMS := FieldByName('ITE_DEICMS').AsFloat;
            Result.IMP_FATREG := FieldByName('ITE_FATREG').AsFloat;
          End;
        End;
      End;
    Except
      On E : Exception Do
  		  pMensagensErro(E.Message, '[TImportacaoCadastros.fGetRecProdutoUpdate]');
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

function TImpProduto.fAdicionarGirIte(strCodEmp, strCodIte: string): Boolean;
  Var
    qryGirIte: TUniQuery;
    intCampos,
    intAno,
    intPrimeiroAno: Integer;
  function fRetPrimeiroAnoGiro: integer;
  begin
    qryGirIte.SQL.Clear;
    qryGirIte.SQL.Text := 'SELECT MIN(GIR_A_N_O_) AS ANO FROM GIRITE';
    qryGirIte.Open;
    Result := StrToIntDef(qryGirIte.FieldByName('ANO').AsString, YearOf(VS_Date));
    If Result = YearOf(VS_Date) then
      Result := (YearOf(VS_Date))-1;
  End;

Begin
  Result := True;
  Try
    Try
      qryGirIte := fCriaQuery;
      intPrimeiroAno := fRetPrimeiroAnoGiro;
      qryGirIte.SQL.Clear;
      qryGirIte.SQL.Text := 'SELECT * FROM GIRITE WHERE FALSE';
      qryGirIte.Open;

      For intAno := intPrimeiroAno To YearOf(VS_Date) Do
      Begin
        qryGirIte.Insert;
        For intCampos := 0 To qryGirIte.FieldCount -1 Do
          If qryGirIte.Fields[intCampos].DataType In [ftWord, ftFloat, ftInteger] Then
            qryGirIte.Fields[intCampos].Value := 0;

        qryGirIte.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('GIRITE', VS_strCodEmp);
        qryGirIte.FieldByName('GIR_CODITE').AsString := strCodIte;
        qryGirIte.FieldByName('GIR_CODEMP').AsString := strCodEmp;
        qryGirIte.FieldByName('GIR_A_N_O_').AsString := IntToStr(intAno);
        qryGirIte.Post;
      End;
    Except
      On e: Exception do
      Begin
        Result := False;
        Raise Exception.Create(e.Message + ' Falha ao inserir Giro do Item');
      End;
    End;
  Finally
    FreeAndNil(qryGirIte);
  End;
End;

function TImpProduto.fMarcarImportado: Boolean;
  Var
    qryTemp: TUniQuery;

  procedure pInicializarQry; begin
    qryTemp.Close();
    qryTemp.SQL.Clear();
    qryTemp.SQL.Text := SQL_UPDATE_IMPPRO;
  end;
begin
  Result := True;

  Try
    qryTemp := fCriaQuery(nil);

    Try
      pInicializarQry();

      qryTemp.ParamByName('CODITE').AsString  := Self.FieldByName('IMP_CODVEL').AsString;
      qryTemp.ParamByName('DESITE').AsString  := Self.FieldByName('IMP_DESITE').AsString;
      qryTemp.ParamByName('CODIMP').AsInteger := Self.FieldByName('IMP_CODIMP').AsInteger;
      qryTemp.ParamByName('DTAIMP').AsDate := VS_Date;

      qryTemp.ExecSQL();
    Finally
      FreeAndNil(qryTemp);
    End;
  Except
    On E : Exception Do Begin
      Result := False;
		  pMensagensErro(E.Message, '[TImpProduto.fMarcarImportado]');

      FMemoLog.Lines.Add(#13#10 + 'ERRO: ' + E.Message + #13#10);
    End;
  End;
end;

function TImpProduto.fSalvarRegistros: Boolean;
  Var
    qryTempIte: TUniQuery;

  function fBuildSetCadite: String;
  begin
    Result := 'UPDATE CADITE SET ' +
                          '  ITE_CODVEL = :CODVEL, ' +
                          '  ITE_CODEMP = :CODEMP, ' +
                          '  ITE_DESITE = :DESITE, ' +
                          '  ITE_DESSIM = :DESSIM, ' +
                          '  ITE_DESFAB = :DESFAB, ' +
                          '  ITE_CODFAB = :CODFAB, ' +
                          '  ITE_CODFOR = :CODFOR, ' +
                          '  ITE_REFERE = :REFERE, ' +
                          '  ITE_CODUNI = :CODUNI, ' +
                          '  ITE_UNICOM = :UNICOM, ' +
                          '  ITE_CODMAR = :CODMAR, ' +
                          '  ITE_CODGRU = :CODGRU, ' +
                          '  ITE_CODDEP = :CODDEP, ' +
                          '  ITE_PRDGRU = :PRDGRU, ' +
                          '  ITE_PRAPEL = :PRAPEL, ' +
                          '  ITE_PESOIT = :PESOIT, ' +
                          '  ITE_PESLIQ = :PESLIQ, ' +
                          '  ITE_CODBAR = :CODBAR, ' +
                          '  ITE_BAREMB = :BAREMB, ' +
                          '  ITE_EMBALA = :EMBALA, ' +
                          '  ITE_APLICA = :APLICA, ' +
                          '  ITE_MLTVEN = :MLTVEN, ' +
                          '  ITE_MLTCOM = :MLTCOM, ' +
                          '  ITE_ITEATI = :ITEATI, ' +
                          '  ITE_ITEBAS = :ITEBAS, ' +
                          '  ITE_ITEPIG = :ITEPIG, ' +
                          '  ITE_PROEMB = :PROEMB, ' +
                          '  ITE_VALOBR = :VALOBR, ' +
                          '  ITE_INFLAM = :INFLAM, ' +
                          '  ITE_PEEFUT = :PEEFUT, ' +
                          '  ITE_PEFFPR = :PEFFPR, ' +
                          '  ITE_PEFUTP = :PEFUTP, ' +
                          '  ITE_MSGLV1 = :MSGLV1, ' +
                          '  ITE_MSGLV2 = :MSGLV2, ' +
                          '  ITE_INFGAR = :INFGAR, ' +
                          '  ITE_ATICOM = :ATICOM, ' +
                          '  ITE_CPRCEN = :CPRCEN, ' +
                          '  ITE_DIAFOR = :DIAFOR, ' +
                          '  ITE_ACOOBJ = :ACOOBJ, ' +
                          '  ITE_CODABF = :CODABF, ' +
                          '  ITE_CLAIPI = :CLAIPI, ' +
                          '  ITE_EXCIPI = :EXCIPI, ' +
                          '  ITE_CODFIN = :CODFIN, ' +
                          '  ITE_INCPIS = :INCPIS, ' +
                          '  ITE_COMLUB = :COMLUB, ' +
                          '  ITE_CODLUB = :CODLUB, ' +
                          '  ITE_OBRCPF = :OBRCPF, ' +
                          '  ITE_OBRIBA = :OBRIBA, ' +
                          '  ITE_ABFPIS = :ABFPIS, ' +
                          '  ITE_ABFCOF = :ABFCOF, ' +
                          '  ITE_ABFIPI = :ABFIPI, ' +
                          '  ITE_CDCEST = :CDCEST, ' +
                          '  ITE_MENFIS = :MENFIS, ' +
                          '  ITE_OBRNFE = :OBRNFE, ' +
                          '  ITE_PER_CI = :PER_CI, ' +
                          '  ITE_CODOPE = :CODOPE, ' +
                          '  ITE_DTACAD = :DTACAD, ' +
                          '  ITE_DTAALT = :DTAALT, ' +
                          '  ITE_NUMFCI = :NUMFCI  ';
    If Not fCampoExcluido('ITE_BAREXP') Then
      Result := Result + '  ,ITE_BAREXP = :BAREXP ';
    If not fCampoExcluido('ITE_TMPGAR') Then
      Result := Result + '  ,ITE_TMPGAR = :TMPGAR ';
    If Not fCampoExcluido('ITE_RPRENT') Then
      Result := Result + '  ,ITE_RPRENT = :RPRENT ';
    If not fCampoExcluido('ITE_NVLGIR') And Not fCfgSis('TIPGIR', varBoolean) Then
      Result := Result + '  ,ITE_NVLGIR = :NVLGIR ';
    If not fCampoExcluido('ITE_REAEND') Then
      Result := Result + '  ,ITE_REAEND = :REAEND ';
    Result := Result + '  WHERE ITE_CODITE = :CODITE ';
  end;

  procedure pInicializarQryIte; begin
    qryTempIte.Close();
    qryTempIte.SQL.Clear();

    If (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
      qryTempIte.SQL.Text := SQL_INSERT_CADITE
    Else If (Self.FieldByName('IMP_TIPOPE').AsString = 'U') Then
      qryTempIte.SQL.Text := fBuildSetCadite()
    Else If (Self.FieldByName('IMP_TIPOPE').AsString = 'D') Then
      qryTempIte.SQL.Text := SQL_DELETE_CADITE;
  end;

  procedure pVerificarUpdateRegistro;
    Var
      strTemp: String;
  begin
    //SE FOR TIPOPE = 'D' E NÃO TEM REGISTRO > ALTERA PARA TIPOPE = "I"
    If (Self.FieldByName('IMP_TIPOPE').AsString = 'U') And
       (Not fEmptyStr(Self.FieldByName('IMP_CODITE').AsString)) Then Begin

      strTemp := fCampoTabela('ITE_CODITE', 'CADITE', ['ITE_CODITE'],
        [Self.FieldByName('IMP_CODITE').AsString]);

      If (fEmptyStr(strTemp)) Then Begin
        Self.Edit();
        Self.FieldByName('IMP_TIPOPE').AsString := 'I';
        Self.Post();

        FMemoLog.Lines.Add('ERRO: CÓDIGO DE PRODUTO NÃO ENCONTRADO. OPERAÇÃO ALTERADA DE ALTERAÇÃO PARA INCLUSÃO. ' +
          'CÓD. PRODUTO:' + Self.FieldByName('IMP_CODITE').AsString);
      End;
    End;

    //SE FOR TIPOPE = 'I' E TEM REGISTRO > ALTERA PARA TIPOPE = "U"
    If (Self.FieldByName('IMP_TIPOPE').AsString = 'I') And
       (Not fEmptyStr(Self.FieldByName('IMP_CODITE').AsString)) Then Begin

      strTemp := fCampoTabela('ITE_CODITE', 'CADITE', ['ITE_CODITE'],
        [Self.FieldByName('IMP_CODITE').AsString]);

      If (Not fEmptyStr(strTemp)) Then Begin
        Self.Edit();
        Self.FieldByName('IMP_TIPOPE').AsString := 'U';
        Self.Post();

        FMemoLog.Lines.Add('ERRO: CÓDIGO DE PRODUTO NÃO ENCONTRADO. OPERAÇÃO ALTERADA DE INCLUSÃO PARA ALTERAÇÃO. ' +
          'CÓD. PRODUTO:' + Self.FieldByName('IMP_CODITE').AsString);
      End;
    End;
  end;

  function fCodigoProdutoValido: Boolean;
  begin
    //SE IMP_CODITE FOR INVÁLIDO, PULA O REGISTRO
    Result := True;

    If (Not fEmptyStr(Self.FieldByName('IMP_CODITE').AsString)) Then Begin
      If (Length(Self.FieldByName('IMP_CODITE').AsString) > fTamCodIte) Then
        Result := False
      Else Begin
        Try
          StrToInt(Self.FieldByName('IMP_CODITE').AsString);
        Except
          On E : Exception Do
            Result := False;
        End;
      End;

      If (Not Result) Then
        FMemoLog.Lines.Add('ERRO: CÓDIGO DE PRODUTO É INVÁLIDO: ' +
          Self.FieldByName('IMP_CODITE').AsString);
    End;
  end;

begin
  Result := True;

  Try
    qryTempIte := fCriaQuery(nil);

    Try
      Self.First();
      pInicializarPrgDetalhe();

      While (Not Self.Eof) Do Begin

        If (Not fCodigoProdutoValido()) Then Begin
          pIncrementarPositionProgressos();

          Self.Next();
          Continue;
        End;

        pVerificarUpdateRegistro();

        pInicializarQryIte();

        If (fEmptyStr(Self.FieldByName('IMP_CODAUT').AsString)) And
           (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then Begin
          //CÓDIGO INFORMADO NO CAMPO 'IMP_CODITE' NÃO CONSTA NA CADITE
          //PORTANTO, SERÁ ADICIONADO UM NOVO PRODUTO COM O CÓDIGO INFORMADO
          //NO CAMPO 'IMP_CODITE'. SE O CAMPO VIER VAZIO, CRIAR UM CÓDIGO PELA 'PROCOD'
          If (fEmptyStr(Self.FieldByName('IMP_CODITE').AsString)) Then
          Begin
            Self.Edit;

            Repeat
              Self.FieldByName('IMP_CODITE').AsString := fAtualizaProCod('CADITE', 'ITE_CODITE');
            Until (fEmptyStr(fCampoTabela('ITE_CODITE', 'CADITE', ['ITE_CODITE'], [qryTempIte.ParamByName('CODITE').AsString])));
          End
          Else
          Begin
            qryTempIte.ParamByName('CODITE').AsString := Self.FieldByName('IMP_CODITE').AsString;
          End;
        End;

        If (Self.FieldByName('IMP_TIPOPE').AsString <> 'D') Then Begin
          If (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('AUTINC').AsString := fRetAutoIncrem('CADITE', VS_strCodEmp)
          Else If (Self.FieldByName('IMP_TIPOPE').AsString = 'U') Then
            recProdUpdate := fGetRecProdutoUpdate(Self.FieldByName('IMP_CODITE').AsString, Self.FieldByName('IMP_CODEMP').AsString, True);

          If (Not fEmptyStr(Self.FieldByName('IMP_CODITE').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('CODITE').AsString := Self.FieldByName('IMP_CODITE').AsString
          Else
            qryTempIte.ParamByName('CODITE').AsString := recProdUpdate.IMP_CODITE;

          If (Not fEmptyStr(Self.FieldByName('IMP_CODVEL').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('CODVEL').AsString := Self.FieldByName('IMP_CODVEL').AsString
          Else
            qryTempIte.ParamByName('CODVEL').AsString := recProdUpdate.IMP_CODVEL;

          qryTempIte.ParamByName('CODEMP').AsString := Self.FieldByName('IMP_CODEMP').AsString;

          If (Not fEmptyStr(Self.FieldByName('IMP_DESITE').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('DESITE').AsString := Self.FieldByName('IMP_DESITE').AsString
          Else
            qryTempIte.ParamByName('DESITE').AsString := recProdUpdate.IMP_DESITE;

          If (Not fEmptyStr(Self.FieldByName('IMP_DESSIM').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('DESSIM').AsString := Self.FieldByName('IMP_DESSIM').AsString
          Else
            qryTempIte.ParamByName('DESSIM').AsString := recProdUpdate.IMP_DESSIM;

          If (Not fEmptyStr(Self.FieldByName('IMP_DESFAB').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('DESFAB').AsString := Self.FieldByName('IMP_DESFAB').AsString
          Else
            qryTempIte.ParamByName('DESFAB').AsString := recProdUpdate.IMP_DESFAB;

          If (Not fEmptyStr(Self.FieldByName('IMP_CODFAB').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('CODFAB').AsString := Self.FieldByName('IMP_CODFAB').AsString
          Else
            qryTempIte.ParamByName('CODFAB').AsString := recProdUpdate.IMP_CODFAB;

          If (Not fEmptyStr(Self.FieldByName('IMP_REFERE').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('REFERE').AsString := Self.FieldByName('IMP_REFERE').AsString
          Else
            qryTempIte.ParamByName('REFERE').AsString := recProdUpdate.IMP_REFERE;

          If (Not fEmptyStr(Self.FieldByName('IMP_CODBAR').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('CODBAR').AsString := Self.FieldByName('IMP_CODBAR').AsString
          Else
            qryTempIte.ParamByName('CODBAR').AsString := recProdUpdate.IMP_CODBAR;

          If (Not fEmptyStr(Self.FieldByName('IMP_BAREMB').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('BAREMB').AsString := Self.FieldByName('IMP_BAREMB').AsString
          Else
            qryTempIte.ParamByName('BAREMB').AsString := recProdUpdate.IMP_BAREMB;

          If (Not fEmptyStr(Self.FieldByName('IMP_EMBALA').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('EMBALA').AsString := Self.FieldByName('IMP_EMBALA').AsString
          Else
            qryTempIte.ParamByName('EMBALA').AsString := recProdUpdate.IMP_EMBALA;

          If (Not fEmptyStr(Self.FieldByName('IMP_APLICA').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('APLICA').AsString := Self.FieldByName('IMP_APLICA').AsString
          Else
            qryTempIte.ParamByName('APLICA').AsString := recProdUpdate.IMP_APLICA;

          If (Self.FieldByName('IMP_MLTVEN').AsFloat <> 0) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('MLTVEN').AsFloat := Self.FieldByName('IMP_MLTVEN').AsFloat
          Else
            qryTempIte.ParamByName('MLTVEN').AsFloat := recProdUpdate.IMP_MLTVEN;

          If (Self.FieldByName('IMP_MLTCOM').AsFloat <> 0) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('MLTCOM').AsFloat := Self.FieldByName('IMP_MLTCOM').AsFloat
          Else
            qryTempIte.ParamByName('MLTCOM').AsFloat := recProdUpdate.IMP_MLTCOM;

          If (Not fEmptyStr(Self.FieldByName('IMP_ITEATI').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('ITEATI').AsString := Self.FieldByName('IMP_ITEATI').AsString
          Else
            qryTempIte.ParamByName('ITEATI').AsString := recProdUpdate.IMP_ITEATI;

          If (Not fEmptyStr(Self.FieldByName('IMP_ITEBAS').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('ITEBAS').AsString := Self.FieldByName('IMP_ITEBAS').AsString
          Else
            qryTempIte.ParamByName('ITEBAS').AsString := recProdUpdate.IMP_ITEBAS;

          If (Not fEmptyStr(Self.FieldByName('IMP_ITEPIG').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('ITEPIG').AsString := Self.FieldByName('IMP_ITEPIG').AsString
          Else
            qryTempIte.ParamByName('ITEPIG').AsString := recProdUpdate.IMP_ITEPIG;

          If (Not fEmptyStr(Self.FieldByName('IMP_PROEMB').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('PROEMB').AsString := Self.FieldByName('IMP_PROEMB').AsString
          Else
            qryTempIte.ParamByName('PROEMB').AsString := recProdUpdate.IMP_PROEMB;

          If (Not fEmptyStr(Self.FieldByName('IMP_VALOBR').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('VALOBR').AsString := Self.FieldByName('IMP_VALOBR').AsString
          Else
            qryTempIte.ParamByName('VALOBR').AsString := recProdUpdate.IMP_VALOBR;

          If (Not fEmptyStr(Self.FieldByName('IMP_INFLAM').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('INFLAM').AsString := Self.FieldByName('IMP_INFLAM').AsString
          Else
            qryTempIte.ParamByName('INFLAM').AsString := recProdUpdate.IMP_INFLAM;

          If qryTempIte.FindParam('BAREXP') <> nil Then
          Begin
            If (Not fEmptyStr(Self.FieldByName('IMP_BAREXP').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
              qryTempIte.ParamByName('BAREXP').AsString := Self.FieldByName('IMP_BAREXP').AsString
            Else
              qryTempIte.ParamByName('BAREXP').AsString := recProdUpdate.IMP_BAREXP;
          End;

          If (Not fEmptyStr(Self.FieldByName('IMP_PEEFUT').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('PEEFUT').AsString := Self.FieldByName('IMP_PEEFUT').AsString
          Else
            qryTempIte.ParamByName('PEEFUT').AsString := recProdUpdate.IMP_PEEFUT;

          If (Not fEmptyStr(Self.FieldByName('IMP_PEFFPR').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('PEFFPR').AsString := Self.FieldByName('IMP_PEFFPR').AsString
          Else
            qryTempIte.ParamByName('PEFFPR').AsString := recProdUpdate.IMP_PEFFPR;

          If (Not fEmptyStr(Self.FieldByName('IMP_PEFUTP').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('PEFUTP').AsString := Self.FieldByName('IMP_PEFUTP').AsString
          Else
            qryTempIte.ParamByName('PEFUTP').AsString := recProdUpdate.IMP_PEFUTP;

          If (Not fEmptyStr(Self.FieldByName('IMP_MSGLV1').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('MSGLV1').AsString := Self.FieldByName('IMP_MSGLV1').AsString
          Else
            qryTempIte.ParamByName('MSGLV1').AsString := recProdUpdate.IMP_MSGLV1;

          If (Not fEmptyStr(Self.FieldByName('IMP_MSGLV2').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('MSGLV2').AsString := Self.FieldByName('IMP_MSGLV2').AsString
          Else
            qryTempIte.ParamByName('MSGLV2').AsString := recProdUpdate.IMP_MSGLV2;

          If qryTempIte.FindParam('TMPGAR') <> nil Then
          Begin
            If (Self.FieldByName('IMP_TMPGAR').AsInteger <> 0) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
              qryTempIte.ParamByName('TMPGAR').AsInteger := Self.FieldByName('IMP_TMPGAR').AsInteger
            Else
              qryTempIte.ParamByName('TMPGAR').AsInteger := recProdUpdate.IMP_TMPGAR;
          End;

          If (Not fEmptyStr(Self.FieldByName('IMP_INFGAR').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('INFGAR').AsString := Self.FieldByName('IMP_INFGAR').AsString
          Else
            qryTempIte.ParamByName('INFGAR').AsString := recProdUpdate.IMP_INFGAR;

          If (Not fEmptyStr(Self.FieldByName('IMP_ATICOM').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('ATICOM').AsString := Self.FieldByName('IMP_ATICOM').AsString
          Else
            qryTempIte.ParamByName('ATICOM').AsString := recProdUpdate.IMP_ATICOM;

          If (Not fEmptyStr(Self.FieldByName('IMP_CPRCEN').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('CPRCEN').AsString := Self.FieldByName('IMP_CPRCEN').AsString
          Else
            qryTempIte.ParamByName('CPRCEN').AsString := recProdUpdate.IMP_CPRCEN;

          If (Self.FieldByName('IMP_DIAFOR').AsInteger <> 0) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('DIAFOR').AsInteger := Self.FieldByName('IMP_DIAFOR').AsInteger
          Else
            qryTempIte.ParamByName('DIAFOR').AsInteger := recProdUpdate.IMP_DIAFOR;

          If qryTempIte.FindParam('RPRENT') <> nil Then
          Begin
            If (Not fEmptyStr(Self.FieldByName('IMP_RPRENT').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
              qryTempIte.ParamByName('RPRENT').AsString := Self.FieldByName('IMP_RPRENT').AsString
            Else
              qryTempIte.ParamByName('RPRENT').AsString := recProdUpdate.IMP_RPRENT;
          End;

          If qryTempIte.FindParam('NVLGIR') <> nil Then
          Begin
            If (Not fEmptyStr(Self.FieldByName('IMP_NVLGIR').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
              qryTempIte.ParamByName('NVLGIR').AsString := Self.FieldByName('IMP_NVLGIR').AsString
            Else
              qryTempIte.ParamByName('NVLGIR').AsString := recProdUpdate.IMP_NVLGIR;
          End;

          If (Not fEmptyStr(Self.FieldByName('IMP_ACOOBJ').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('ACOOBJ').AsString := Self.FieldByName('IMP_ACOOBJ').AsString
          Else
            qryTempIte.ParamByName('ACOOBJ').AsString := recProdUpdate.IMP_ACOOBJ;

          If qryTempIte.FindParam('REAEND') <> nil Then
          Begin
            If (Not fEmptyStr(Self.FieldByName('IMP_REAEND').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
              qryTempIte.ParamByName('REAEND').AsString := Self.FieldByName('IMP_REAEND').AsString
            Else
              qryTempIte.ParamByName('REAEND').AsString := recProdUpdate.IMP_REAEND;
          End;

          If (Not fEmptyStr(Self.FieldByName('IMP_CLAIPI').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('CLAIPI').AsString := Self.FieldByName('IMP_CLAIPI').AsString
          Else
            qryTempIte.ParamByName('CLAIPI').AsString := recProdUpdate.IMP_CLAIPI;

          If (Not fEmptyStr(Self.FieldByName('IMP_EXCIPI').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('EXCIPI').AsString := Self.FieldByName('IMP_EXCIPI').AsString
          Else
            qryTempIte.ParamByName('EXCIPI').AsString := recProdUpdate.IMP_EXCIPI;

          If (Not fEmptyStr(Self.FieldByName('IMP_INCPIS').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('INCPIS').AsString := Self.FieldByName('IMP_INCPIS').AsString
          Else
            qryTempIte.ParamByName('INCPIS').AsString := recProdUpdate.IMP_INCPIS;

          If (Not fEmptyStr(Self.FieldByName('IMP_COMLUB').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('COMLUB').AsString := Self.FieldByName('IMP_COMLUB').AsString
          Else
            qryTempIte.ParamByName('COMLUB').AsString := recProdUpdate.IMP_COMLUB;

          If (Not fEmptyStr(Self.FieldByName('IMP_OBRCPF').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('OBRCPF').AsString := Self.FieldByName('IMP_OBRCPF').AsString
          Else
            qryTempIte.ParamByName('OBRCPF').AsString := recProdUpdate.IMP_OBRCPF;

          If (Not fEmptyStr(Self.FieldByName('IMP_OBRIBA').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('OBRIBA').AsString := Self.FieldByName('IMP_OBRIBA').AsString
          Else
            qryTempIte.ParamByName('OBRIBA').AsString := recProdUpdate.IMP_OBRIBA;

          If (Not fEmptyStr(Self.FieldByName('IMP_MENFIS').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('MENFIS').AsString := Self.FieldByName('IMP_MENFIS').AsString
          Else
            qryTempIte.ParamByName('MENFIS').AsString := recProdUpdate.IMP_MENFIS;

          If (Not fEmptyStr(Self.FieldByName('IMP_OBRNFE').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('OBRNFE').AsString := Self.FieldByName('IMP_OBRNFE').AsString
          Else
            qryTempIte.ParamByName('OBRNFE').AsString := recProdUpdate.IMP_OBRNFE;

          If (Self.FieldByName('IMP_PER_CI').AsFloat <> 0) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('PER_CI').AsFloat := Self.FieldByName('IMP_PER_CI').AsFloat
          Else
            qryTempIte.ParamByName('PER_CI').AsFloat := recProdUpdate.IMP_PER_CI;

          If (Not fEmptyStr(Self.FieldByName('IMP_NUMFCI').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('NUMFCI').AsString := Self.FieldByName('IMP_NUMFCI').AsString
          Else
            qryTempIte.ParamByName('NUMFCI').AsString := recProdUpdate.IMP_NUMFCI;

          If (Self.FieldByName('IMP_PRAPEL').AsFloat <> 0) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('PRAPEL').AsFloat  := Self.FieldByName('IMP_PRAPEL').AsFloat
          Else
            qryTempIte.ParamByName('PRAPEL').AsFloat  := recProdUpdate.IMP_PRAPEL;

          If (Self.FieldByName('IMP_PESOIT').AsFloat <> 0) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('PESOIT').AsFloat  := Self.FieldByName('IMP_PESOIT').AsFloat
          Else
            qryTempIte.ParamByName('PESOIT').AsFloat  := recProdUpdate.IMP_PESOIT;

          If (Self.FieldByName('IMP_PESLIQ').AsFloat <> 0) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('PESLIQ').AsFloat  := Self.FieldByName('IMP_PESLIQ').AsFloat
          Else
            qryTempIte.ParamByName('PESLIQ').AsFloat  := recProdUpdate.IMP_PESLIQ;

          If (Not fEmptyStr(Self.FieldByName('IMP_AUTFOR').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('CODFOR').AsString := Self.FieldByName('IMP_AUTFOR').AsString
          Else
            qryTempIte.ParamByName('CODFOR').AsString := recProdUpdate.IMP_CODFOR;

          If (Not fEmptyStr(Self.FieldByName('IMP_UNIAUT').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('CODUNI').AsString := Self.FieldByName('IMP_UNIAUT').AsString
          Else
            qryTempIte.ParamByName('CODUNI').AsString := recProdUpdate.IMP_CODUNI;

          If (Not fEmptyStr(Self.FieldByName('IMP_UCPAUT').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('UNICOM').AsString := Self.FieldByName('IMP_UCPAUT').AsString
          Else
            qryTempIte.ParamByName('UNICOM').AsString := recProdUpdate.IMP_UNICOM;

          If (Not fEmptyStr(Self.FieldByName('IMP_MARAUT').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('CODMAR').AsString := Self.FieldByName('IMP_MARAUT').AsString
          Else
            qryTempIte.ParamByName('CODMAR').AsString := recProdUpdate.IMP_CODMAR;

          If (Not fEmptyStr(Self.FieldByName('IMP_GRUAUT').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('CODGRU').AsString := Self.FieldByName('IMP_GRUAUT').AsString
          Else
            qryTempIte.ParamByName('CODGRU').AsString := recProdUpdate.IMP_CODGRU;

          If (Not fEmptyStr(Self.FieldByName('IMP_DEPAUT').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('CODDEP').AsString := Self.FieldByName('IMP_DEPAUT').AsString
          Else
            qryTempIte.ParamByName('CODDEP').AsString := recProdUpdate.IMP_CODDEP;

          If (Not fEmptyStr(Self.FieldByName('IMP_GRPAUT').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('PRDGRU').AsString := Self.FieldByName('IMP_GRPAUT').AsString
          Else
            qryTempIte.ParamByName('PRDGRU').AsString := recProdUpdate.IMP_PRDGRU;

          If (fCfgSis('TIPABF', varString) = '1') Then Begin
            If (Not fEmptyStr(Self.FieldByName('IMP_CODABF').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
              qryTempIte.ParamByName('CODABF').AsString := Self.FieldByName('IMP_CODABF').AsString
            Else
              qryTempIte.ParamByName('CODABF').AsString := recProdUpdate.IMP_CODABF;
          End Else
            qryTempIte.ParamByName('CODABF').Clear();

          If (fCfgSis('TPABPC', varString) = '1') Then Begin
            If (Not fEmptyStr(Self.FieldByName('IMP_ABFPIS').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
              qryTempIte.ParamByName('ABFPIS').AsString := Self.FieldByName('IMP_ABFPIS').AsString
            Else
              qryTempIte.ParamByName('ABFPIS').AsString := recProdUpdate.IMP_ABFPIS;
          End Else
            qryTempIte.ParamByName('ABFPIS').Clear();

          If (fCfgSis('TPABPC', varString) = '1') Then Begin
            If (Not fEmptyStr(Self.FieldByName('IMP_ABFCOF').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
              qryTempIte.ParamByName('ABFCOF').AsString := Self.FieldByName('IMP_ABFCOF').AsString
            Else
              qryTempIte.ParamByName('ABFCOF').AsString := recProdUpdate.IMP_ABFCOF;
          End Else
            qryTempIte.ParamByName('ABFCOF').Clear();

          If (Not fEmptyStr(Self.FieldByName('IMP_ABFIPI').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('ABFIPI').AsString := Self.FieldByName('IMP_ABFIPI').AsString
          Else
            qryTempIte.ParamByName('ABFIPI').AsString := recProdUpdate.IMP_ABFIPI;

          If (Not fEmptyStr(Self.FieldByName('IMP_CDCEST').AsString)) Or (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('CDCEST').AsString := Self.FieldByName('IMP_CDCEST').AsString
          Else
            qryTempIte.ParamByName('CDCEST').AsString := recProdUpdate.IMP_CDCEST;

          If (fEmptyStr(qryTempIte.ParamByName('CODFOR').AsString)) Then qryTempIte.ParamByName('CODFOR').Clear();
          If (fEmptyStr(qryTempIte.ParamByName('CODUNI').AsString)) Then qryTempIte.ParamByName('CODUNI').Clear();
          If (fEmptyStr(qryTempIte.ParamByName('UNICOM').AsString)) Then qryTempIte.ParamByName('UNICOM').Clear();
          If (fEmptyStr(qryTempIte.ParamByName('CODMAR').AsString)) Then qryTempIte.ParamByName('CODMAR').Clear();
          If (fEmptyStr(qryTempIte.ParamByName('CODGRU').AsString)) Then qryTempIte.ParamByName('CODGRU').Clear();
          If (fEmptyStr(qryTempIte.ParamByName('CODDEP').AsString)) Then qryTempIte.ParamByName('CODDEP').Clear();
          If (fEmptyStr(qryTempIte.ParamByName('PRDGRU').AsString)) Then qryTempIte.ParamByName('PRDGRU').Clear();
          If (fEmptyStr(qryTempIte.ParamByName('ABFPIS').AsString)) Then qryTempIte.ParamByName('ABFPIS').Clear();
          If (fEmptyStr(qryTempIte.ParamByName('ABFCOF').AsString)) Then qryTempIte.ParamByName('ABFCOF').Clear();
          If (fEmptyStr(qryTempIte.ParamByName('ABFIPI').AsString)) Then qryTempIte.ParamByName('ABFIPI').Clear();
          If (fEmptyStr(qryTempIte.ParamByName('CODABF').AsString)) Then qryTempIte.ParamByName('CODABF').Clear();
          If (fEmptyStr(qryTempIte.ParamByName('CDCEST').AsString)) Then qryTempIte.ParamByName('CDCEST').Clear();

          qryTempIte.ParamByName('CODFIN').Clear();
          qryTempIte.ParamByName('CODLUB').Clear();

          qryTempIte.ParamByName('CODOPE').AsString   := strLoginUsuarioLogado;

          If (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTempIte.ParamByName('DTACAD').AsDateTime := fNow();

          qryTempIte.ParamByName('DTAALT').AsDateTime := fNow();

          qryTempIte.ExecSQL();

          //INCLUI OS REGISTROS DA ITEGER, UM REGISTRO PARA CADA EMPRESA NA CADEMP
          Result := Result And fAdicionarIteGer(Self.FieldByName('IMP_TIPOPE').AsString = 'I');

          //ADICIONA REGISTROS DAS EMBALAGENS - ITEBAR
          Result := Result And fAdicionarIteBar();

          fMarcarImportado();

          If (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            FMemoLog.Lines.Add('PRODUTO ADICIONADO AO BD: CÓD. ANT. : ' +
              Self.FieldByName('IMP_CODVEL').AsString +
              ' | CÓD.: ' + Self.FieldByName('IMP_CODITE').AsString)
          Else
            FMemoLog.Lines.Add('PRODUTO ALTERADO NO BD: CÓD. ANT. : ' +
              Self.FieldByName('IMP_CODVEL').AsString +
              ' | CÓD.: ' + Self.FieldByName('IMP_CODITE').AsString);
        End Else If (Not Self.FIgnExcPrd) Then Begin
          //FAZER DELETE DO REGISTRO
          Try
            qryTempIte.ParamByName('CODITE').AsString := Self.FieldByName('IMP_CODITE').AsString;

            qryTempIte.ExecSQL();

            fMarcarImportado();

            FMemoExclusao.Lines.Add('PRODUTO REMOVIDO DO BD: CÓD. ANT. : ' +
              Self.FieldByName('IMP_CODVEL').AsString +
              ' | CÓD.: ' + Self.FieldByName('IMP_CODITE').AsString);
          Except
            FMemoExclusao.Lines.Add('PRODUTO NÃO FOI REMOVIDO DO BD: CÓD. ANT. : ' +
              Self.FieldByName('IMP_CODVEL').AsString +
              ' | CÓD.: ' + Self.FieldByName('IMP_CODITE').AsString +
              '. VERIFIQUE SE O MESMO POSSUI MOVIMENTAÇÃO!');
          End;
        End;

        Self.Edit();
        Self.FieldByName('IMP_CODITE').AsString := Self.FieldByName('IMP_CODITE').AsString;
        Self.FieldByName('IMP_CODAUT').AsString := Self.FieldByName('IMP_CODITE').AsString;
        Self.Post();

        pIncrementarPositionProgressos();
        Self.Next();
      End;
    Finally
      FreeAndNil(qryTempIte);
    End;
  Except
    On E : Exception Do Begin
      Result := False;
		  pMensagensErro(E.Message, '[TImpProduto.fSalvarRegistros]');
      FMemoLog.Lines.Add(#13#10 + 'ERRO: ' + E.Message + #13#10);
    End;
  End;
end;

procedure TImpProduto.pAdicionar(params: TRecParamAdicionar);
  Var
    i: Integer;
    strTemp: String;

  function fRetPrecoCusto: Double;
    Var
      cpcParams: TParCalculaPrecoCusto;
  begin
    Try
      cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao, True, True);

      With cpcParams, Self Do Begin
        curPreCom := FieldByName('IMP_PRECOM').AsFloat;
        curDesF01 := FieldByName('IMP_DESF01').AsFloat;
        curDesF02 := FieldByName('IMP_DESF02').AsFloat;
        curDesF03 := FieldByName('IMP_DESF03').AsFloat;
        curDesF04 := FieldByName('IMP_DESF04').AsFloat;
        curDesF05 := FieldByName('IMP_DESF05').AsFloat;
        curDesF06 := FieldByName('IMP_DESF06').AsFloat;
        curICMSEnt:= FieldByName('IMP_ICMENT').AsFloat;
        curIPIEnt := FieldByName('IMP_IPIENT').AsFloat;
        curFrete  := FieldByName('IMP_FREENT').AsFloat;
        curAcrFin := FieldByName('IMP_ACRFIN').AsFloat;
        curSubsti := FieldByName('IMP_SUBSTI').AsFloat;
        curValFre := FieldByName('IMP_VALFRE').AsFloat;
        curDesAdb := FieldByName('IMP_DESADB').AsFloat;
        curSubFed := FieldByName('IMP_SUBFED').AsFloat;

        if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
        begin
          curTCIFCu := FieldByName('IMP_TCIFCU').AsFloat;
          curTSCust := FieldByName('IMP_TSCUST').AsFloat;
          curDePiCo := FieldByName('IMP_DEPICO').AsFloat;
          curDeICMS := FieldByName('IMP_DEICMS').AsFloat;
          curFatReg := FieldByName('IMP_FATREG').AsFloat;
        end
        else
        begin
          curTCIFCu := 0;
          curTSCust := 0;
          curDePiCo := 0;
          curDeICMS := 0;
          curFatReg := 0;
        end;
      End;

      Result := cpcParams.fCalculaPrecoCusto(false);
    Finally
      FreeAndNil(cpcParams);
    End;
  End;

begin
  If (fEmptyStr(params.recProduto.IMP_DESITE)) Then Exit;

  If (Not fEmptyStr(params.recProduto.IMP_CODITE)) Then
    strTemp := fCampoTabela('ITE_CODITE', 'CADITE', ['ITE_CODITE'], [params.recProduto.IMP_CODITE])
  Else
    strTemp := '';

  Self.Append();
  Self.FieldByName('ID').AsInteger := params.intID;
  Self.FieldByName('IMP_CODITE').AsString := params.recProduto.IMP_CODITE;
  Self.FieldByName('IMP_CODAUT').AsString := strTemp;
  Self.FieldByName('IMP_CODEMP').AsString := VS_strCodEmp;
  Self.FieldByName('IMP_CODVEL').AsString := params.recProduto.IMP_CODVEL;
  Self.FieldByName('IMP_DESITE').AsString := params.recProduto.IMP_DESITE;
  Self.FieldByName('IMP_DESSIM').AsString := params.recProduto.IMP_DESSIM;
  Self.FieldByName('IMP_DESFAB').AsString := params.recProduto.IMP_DESFAB;
  Self.FieldByName('IMP_CODFAB').AsString := params.recProduto.IMP_CODFAB;
  Self.FieldByName('IMP_CODFOR').AsString := params.recProduto.IMP_CODFOR;
  Self.FieldByName('IMP_C_G_C_').AsString := params.recProduto.IMP_C_G_C_;
  Self.FieldByName('IMP_REFERE').AsString := params.recProduto.IMP_REFERE;
  Self.FieldByName('IMP_CODUNI').AsString := params.recProduto.IMP_CODUNI;
  Self.FieldByName('IMP_SIGUNI').AsString := params.recProduto.IMP_SIGUNI;
  Self.FieldByName('IMP_UNICOM').AsString := params.recProduto.IMP_UNICOM;
  Self.FieldByName('IMP_SIGCOM').AsString := params.recProduto.IMP_SIGCOM;
  Self.FieldByName('IMP_CODMAR').AsString := params.recProduto.IMP_CODMAR;
  Self.FieldByName('IMP_DESMAR').AsString := params.recProduto.IMP_DESMAR;
  Self.FieldByName('IMP_CODGRU').AsString := params.recProduto.IMP_CODGRU;
  Self.FieldByName('IMP_DESGRU').AsString := Trim(params.recProduto.IMP_DESGRU);
  Self.FieldByName('IMP_DESLIN').AsString := Trim(params.recProduto.IMP_DESLIN);
  Self.FieldByName('IMP_CODDEP').AsString := params.recProduto.IMP_CODDEP;
  Self.FieldByName('IMP_DESCRI').AsString := params.recProduto.IMP_DESCRI;
  Self.FieldByName('IMP_PRDGRU').AsString := params.recProduto.IMP_PRDGRU;
  Self.FieldByName('IMP_CODBAR').AsString := params.recProduto.IMP_CODBAR;
  Self.FieldByName('IMP_BAREMB').AsString := params.recProduto.IMP_BAREMB;
  Self.FieldByName('IMP_EMBALA').AsString := params.recProduto.IMP_EMBALA;
  Self.FieldByName('IMP_APLICA').AsString := params.recProduto.IMP_APLICA;
  Self.FieldByName('IMP_IMPLIS').AsString := params.recProduto.IMP_IMPLIS;
  Self.FieldByName('IMP_ITEATI').AsString := params.recProduto.IMP_ITEATI;
  Self.FieldByName('IMP_ITEBAS').AsString := params.recProduto.IMP_ITEBAS;
  Self.FieldByName('IMP_ITEPIG').AsString := params.recProduto.IMP_ITEPIG;
  Self.FieldByName('IMP_PROEMB').AsString := params.recProduto.IMP_PROEMB;
  Self.FieldByName('IMP_VALOBR').AsString := params.recProduto.IMP_VALOBR;
  Self.FieldByName('IMP_INFLAM').AsString := params.recProduto.IMP_INFLAM;
  Self.FieldByName('IMP_BAREXP').AsString := params.recProduto.IMP_BAREXP;
  Self.FieldByName('IMP_PEEFUT').AsString := params.recProduto.IMP_PEEFUT;
  Self.FieldByName('IMP_PEFFPR').AsString := params.recProduto.IMP_PEFFPR;
  Self.FieldByName('IMP_PEFUTP').AsString := params.recProduto.IMP_PEFUTP;
  Self.FieldByName('IMP_MSGLV1').AsString := params.recProduto.IMP_MSGLV1;
  Self.FieldByName('IMP_MSGLV2').AsString := params.recProduto.IMP_MSGLV2;
  Self.FieldByName('IMP_INFGAR').AsString := params.recProduto.IMP_INFGAR;
  Self.FieldByName('IMP_ATICOM').AsString := params.recProduto.IMP_ATICOM;
  Self.FieldByName('IMP_CPRCEN').AsString := params.recProduto.IMP_CPRCEN;
  Self.FieldByName('IMP_RPRENT').AsString := params.recProduto.IMP_RPRENT;
  Self.FieldByName('IMP_ABAMLT').AsString := params.recProduto.IMP_ABAMLT;
  Self.FieldByName('IMP_NVLGIR').AsString := params.recProduto.IMP_NVLGIR;
  Self.FieldByName('IMP_ESMIDG').AsString := params.recProduto.IMP_ESMIDG;
  Self.FieldByName('IMP_ACOOBJ').AsString := params.recProduto.IMP_ACOOBJ;
  Self.FieldByName('IMP_REAEND').AsString := params.recProduto.IMP_REAEND;
  Self.FieldByName('IMP_CODABF').AsString := params.recProduto.IMP_CODABF;
  Self.FieldByName('IMP_CLAIPI').AsString := params.recProduto.IMP_CLAIPI;
  Self.FieldByName('IMP_EXCIPI').AsString := params.recProduto.IMP_EXCIPI;
  Self.FieldByName('IMP_CODFIN').AsString := params.recProduto.IMP_CODFIN;
  Self.FieldByName('IMP_INCPIS').AsString := params.recProduto.IMP_INCPIS;
  Self.FieldByName('IMP_COMLUB').AsString := params.recProduto.IMP_COMLUB;
  Self.FieldByName('IMP_CODLUB').AsString := params.recProduto.IMP_CODLUB;
  Self.FieldByName('IMP_OBRCPF').AsString := params.recProduto.IMP_OBRCPF;
  Self.FieldByName('IMP_OBRIBA').AsString := params.recProduto.IMP_OBRIBA;
  Self.FieldByName('IMP_ABFPIS').AsString := params.recProduto.IMP_ABFPIS;
  Self.FieldByName('IMP_ABFCOF').AsString := params.recProduto.IMP_ABFCOF;
  Self.FieldByName('IMP_ABFIPI').AsString := params.recProduto.IMP_ABFIPI;
  Self.FieldByName('IMP_CDCEST').AsString := params.recProduto.IMP_CDCEST;
  Self.FieldByName('IMP_MENFIS').AsString := params.recProduto.IMP_MENFIS;
  Self.FieldByName('IMP_OBRNFE').AsString := params.recProduto.IMP_OBRNFE;
  Self.FieldByName('IMP_TIPPRO').AsString := params.recProduto.IMP_TIPPRO;
  Self.FieldByName('IMP_NUMFCI').AsString := params.recProduto.IMP_NUMFCI;
  Self.FieldByName('IMP_LOCSUP').AsString := params.recProduto.IMP_LOCSUP;
  Self.FieldByName('IMP_DESGRP').AsString := params.recProduto.IMP_DESGRP;
  Self.FieldByName('IMP_PRAPEL').AsFloat  := params.recProduto.IMP_PRAPEL;
  Self.FieldByName('IMP_PESOIT').AsFloat  := params.recProduto.IMP_PESOIT;
  Self.FieldByName('IMP_PESLIQ').AsFloat  := params.recProduto.IMP_PESLIQ;
  Self.FieldByName('IMP_MLTVEN').AsFloat  := params.recProduto.IMP_MLTVEN;
  Self.FieldByName('IMP_MLTCOM').AsFloat  := params.recProduto.IMP_MLTCOM;
  Self.FieldByName('IMP_COMVAR').AsFloat  := params.recProduto.IMP_COMVAR;
  Self.FieldByName('IMP_COMATA').AsFloat  := params.recProduto.IMP_COMATA;
  Self.FieldByName('IMP_COMDIS').AsFloat  := params.recProduto.IMP_COMDIS;
  Self.FieldByName('IMP_DESMAX').AsFloat  := params.recProduto.IMP_DESMAX;
  Self.FieldByName('IMP_DESMSU').AsFloat  := params.recProduto.IMP_DESMSU;
  Self.FieldByName('IMP_MARMIN').AsFloat  := params.recProduto.IMP_MARMIN;
  Self.FieldByName('IMP_MARMSG').AsFloat  := params.recProduto.IMP_MARMSG;
  Self.FieldByName('IMP_MARMGE').AsFloat  := params.recProduto.IMP_MARMGE;
  Self.FieldByName('IMP_IPISAI').AsFloat  := params.recProduto.IMP_IPISAI;
  Self.FieldByName('IMP_PER_CI').AsFloat  := params.recProduto.IMP_PER_CI;
  Self.FieldByName('IMP_PRECOM').AsFloat  := params.recProduto.IMP_PRECOM;
  Self.FieldByName('IMP_DESF01').AsFloat  := params.recProduto.IMP_DESF01;
  Self.FieldByName('IMP_DESF02').AsFloat  := params.recProduto.IMP_DESF02;
  Self.FieldByName('IMP_DESF03').AsFloat  := params.recProduto.IMP_DESF03;
  Self.FieldByName('IMP_DESF04').AsFloat  := params.recProduto.IMP_DESF04;
  Self.FieldByName('IMP_DESF05').AsFloat  := params.recProduto.IMP_DESF05;
  Self.FieldByName('IMP_DESF06').AsFloat  := params.recProduto.IMP_DESF06;
  Self.FieldByName('IMP_ICMENT').AsFloat  := params.recProduto.IMP_ICMENT;
  Self.FieldByName('IMP_SUBFED').AsFloat  := params.recProduto.IMP_SUBFED;
  Self.FieldByName('IMP_IPIENT').AsFloat  := params.recProduto.IMP_IPIENT;
  Self.FieldByName('IMP_FREENT').AsFloat  := params.recProduto.IMP_FREENT;
  Self.FieldByName('IMP_VALFRE').AsFloat  := params.recProduto.IMP_VALFRE;
  Self.FieldByName('IMP_ACRFIN').AsFloat  := params.recProduto.IMP_ACRFIN;
  Self.FieldByName('IMP_SUBSTI').AsFloat  := params.recProduto.IMP_SUBSTI;
  Self.FieldByName('IMP_DESADB').AsFloat  := params.recProduto.IMP_DESADB;
  Self.FieldByName('IMP_OUTVAL').AsFloat  := params.recProduto.IMP_OUTVAL;
  Self.FieldByName('IMP_ICMSAI').AsFloat  := params.recProduto.IMP_ICMSAI;
  Self.FieldByName('IMP_IMPFED').AsFloat  := params.recProduto.IMP_IMPFED;
  Self.FieldByName('IMP_DESOPE').AsFloat  := params.recProduto.IMP_DESOPE;
  Self.FieldByName('IMP_COMTB1').AsFloat  := params.recProduto.IMP_COMTB1;
  Self.FieldByName('IMP_MARBR1').AsFloat  := params.recProduto.IMP_MARBR1;
  Self.FieldByName('IMP_PREVE1').AsFloat  := params.recProduto.IMP_PREVE1;
  Self.FieldByName('IMP_COMTB2').AsFloat  := params.recProduto.IMP_COMTB2;
  Self.FieldByName('IMP_MARBR2').AsFloat  := params.recProduto.IMP_MARBR2;
  Self.FieldByName('IMP_PREVE2').AsFloat  := params.recProduto.IMP_PREVE2;
  Self.FieldByName('IMP_COMTB3').AsFloat  := params.recProduto.IMP_COMTB3;
  Self.FieldByName('IMP_MARBR3').AsFloat  := params.recProduto.IMP_MARBR3;
  Self.FieldByName('IMP_PREVE3').AsFloat  := params.recProduto.IMP_PREVE3;
  Self.FieldByName('IMP_COMTB4').AsFloat  := params.recProduto.IMP_COMTB4;
  Self.FieldByName('IMP_MARBR4').AsFloat  := params.recProduto.IMP_MARBR4;
  Self.FieldByName('IMP_PREVE4').AsFloat  := params.recProduto.IMP_PREVE4;
  Self.FieldByName('IMP_COMTB5').AsFloat  := params.recProduto.IMP_COMTB5;
  Self.FieldByName('IMP_MARBR5').AsFloat  := params.recProduto.IMP_MARBR5;
  Self.FieldByName('IMP_PREVE5').AsFloat  := params.recProduto.IMP_PREVE5;
  Self.FieldByName('IMP_COMTB6').AsFloat  := params.recProduto.IMP_COMTB6;
  Self.FieldByName('IMP_MARBR6').AsFloat  := params.recProduto.IMP_MARBR6;
  Self.FieldByName('IMP_PREVE6').AsFloat  := params.recProduto.IMP_PREVE6;
  Self.FieldByName('IMP_COMTB7').AsFloat  := params.recProduto.IMP_COMTB7;
  Self.FieldByName('IMP_MARBR7').AsFloat  := params.recProduto.IMP_MARBR7;
  Self.FieldByName('IMP_PREVE7').AsFloat  := params.recProduto.IMP_PREVE7;
  Self.FieldByName('IMP_ESTMIN').AsFloat  := params.recProduto.IMP_ESTMIN;
  Self.FieldByName('IMP_ESTMAX').AsFloat  := params.recProduto.IMP_ESTMAX;
  Self.FieldByName('IMP_LOCFIS').AsString := params.recProduto.IMP_LOCFIS;
  Self.FieldByName('IMP_DESMGE').AsFloat  := params.recProduto.IMP_DESMGE;
  Self.FieldByName('IMP_DIAFOR').AsFloat  := params.recProduto.IMP_DIAFOR;
  Self.FieldByName('IMP_TIPOPE').AsString := params.recProduto.IMP_TIPOPE;
  Self.FieldByName('IMP_TMPGAR').AsInteger := params.recProduto.IMP_TMPGAR;
  Self.FieldByName('IMP_CODIMP').AsInteger := params.recProduto.IMP_CODIMP;
  Self.FieldByName('IMP_TCIFCU').AsFloat  := params.recProduto.IMP_TCIFCU;
  Self.FieldByName('IMP_TSCUST').AsFloat  := params.recProduto.IMP_TSCUST;
  Self.FieldByName('IMP_DEPICO').AsFloat  := params.recProduto.IMP_DEPICO;
  Self.FieldByName('IMP_DEICMS').AsFloat  := params.recProduto.IMP_DEICMS;
  Self.FieldByName('IMP_FATREG').AsFloat  := params.recProduto.IMP_FATREG;
  Self.FieldByName('IMP_DTAIMP').Value     := null;

  Self.FieldByName('IMP_PRECUS').AsFloat  := fRetPrecoCusto();

  For i := 1 To 7 Do Begin
    If (params.recProduto.IMP_TIPOPE = 'U') Then Begin
      If (Copy(fCfgSis('TABIMP', varString), i, 1) = 'S') Then Begin
        Case (TTipoAltPrecoFranq(fCfgSis('PVCSFQ', varInteger))) Of
          taPrecoCusAltPreVen: //Recalcular o preço de Venda
            Begin
              Self.FieldByName('IMP_PREVE' + IntToStr(i)).AsFloat := fCalculaPrecoVenda(1,         //Calcula 1 Preco de Venda  e  2 Margem Bruta
                                                                                        Self.FieldByName('IMP_PRECUS').AsFloat + Self.FieldByName('IMP_OUTVAL').AsFloat,
                                                                                        Self.FieldByName('IMP_PREVE' + IntToStr(i)).AsFloat,
                                                                                        Self.FieldByName('IMP_MARBR' + IntToStr(i)).AsFloat,
                                                                                        Self.FieldByName('IMP_ICMSAI').AsFloat,
                                                                                        Self.FieldByName('IMP_IMPFED').AsFloat,
                                                                                        Self.FieldByName('IMP_DESOPE').AsFloat,
                                                                                        Self.FieldByName('IMP_COMTB' + IntToStr(i)).AsFloat);

              FMemoLog.Lines.Add('CALCULADO PREÇO DE VENDA (TABELA ' + IntToStr(i) + '): CÓDIGO ANTERIOR: ' +
                    params.recProduto.IMP_CODVEL + ' | CÓD.: ' + strTemp);
            End;

          taPrecoCusAltMargem,
          taPreVenAltMargem: //Recalcular a margem
            Begin
              Self.FieldByName('IMP_MARBR' + IntToStr(i)).AsFloat := fCalculaPrecoVenda(2,         //Calcula 1 Preco de Venda  e  2 Margem Bruta
                                                                                        Self.FieldByName('IMP_PRECUS').AsFloat + Self.FieldByName('IMP_OUTVAL').AsFloat,
                                                                                        Self.FieldByName('IMP_PREVE' + IntToStr(i)).AsFloat,
                                                                                        Self.FieldByName('IMP_MARBR' + IntToStr(i)).AsFloat,
                                                                                        Self.FieldByName('IMP_ICMSAI').AsFloat,
                                                                                        Self.FieldByName('IMP_IMPFED').AsFloat,
                                                                                        Self.FieldByName('IMP_DESOPE').AsFloat,
                                                                                        Self.FieldByName('IMP_COMTB' + IntToStr(i)).AsFloat);

              FMemoLog.Lines.Add('CALCULADA MARGEM BRUTA (TABELA ' + IntToStr(i) + '): CÓDIGO ANTERIOR: ' +
                    params.recProduto.IMP_CODVEL + ' | CÓD.: ' + strTemp);
            End;
        End;
      End;
    End;
  End;

  Self.Post();

  FMemoLog.Lines.Add('PRODUTO ADICIONADO NO DATASET: CÓDIGO ANTERIOR: ' +
    params.recProduto.IMP_CODVEL + ' | CÓD.: ' + strTemp);
end;

procedure TImpProduto.pCriarCampos;
begin
  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'ID'; DataType := ftInteger; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_CODIMP'; DataType := ftInteger; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_CODEMP'; DataType := ftString; Size := 03; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_CODITE'; DataType := ftString; Size := 50; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_CODAUT'; DataType := ftString; Size := 05; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_CODVEL'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_DESITE'; DataType := ftString; Size := 70; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_DESSIM'; DataType := ftString; Size := 70; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_DESFAB'; DataType := ftString; Size := 70; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_CODFAB'; DataType := ftString; Size := 25; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_CODFOR'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_AUTFOR'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_C_G_C_'; DataType := ftString; Size := 18; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_REFERE'; DataType := ftString; Size := 16; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_CODUNI'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_SIGUNI'; DataType := ftString; Size := 04; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_UNICOM'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_UNIAUT'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_GRPAUT'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_UCPAUT'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_SIGCOM'; DataType := ftString; Size := 04; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_CODMAR'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_MARAUT'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_DESMAR'; DataType := ftString; Size := 30; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_GRUAUT'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_CODGRU'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_DESGRU'; DataType := ftString; Size := 70; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_DESLIN'; DataType := ftString; Size := 70; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_DEPAUT'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_CODDEP'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_DESCRI'; DataType := ftString; Size := 40; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_PRDGRU'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_CODBAR'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_BAREMB'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_IMPLIS'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_ITEATI'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_ITEBAS'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_ITEPIG'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_PROEMB'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_VALOBR'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_INFLAM'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_BAREXP'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_PEEFUT'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_PEFFPR'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_PEFUTP'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_MSGLV1'; DataType := ftString; Size := 50; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_MSGLV2'; DataType := ftString; Size := 50; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_INFGAR'; DataType := ftString; Size := 50; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_ATICOM'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_CPRCEN'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_RPRENT'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_ABAMLT'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_NVLGIR'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_ESMIDG'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_ACOOBJ'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_REAEND'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_CODABF'; DataType := ftString; Size := IIf(fCfgSis('USASAN') = 'S', 7, 3); Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_CLAIPI'; DataType := ftString; Size := 10; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_EXCIPI'; DataType := ftString; Size := 03; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_CODFIN'; DataType := ftString; Size := 10; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_INCPIS'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_COMLUB'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_CODLUB'; DataType := ftString; Size := 09; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_OBRCPF'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_OBRIBA'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_ABFPIS'; DataType := ftString; Size := 03; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_ABFCOF'; DataType := ftString; Size := 03; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_ABFIPI'; DataType := ftString; Size := 03; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_CDCEST'; DataType := ftString; Size := 07; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_MENFIS'; DataType := ftString; Size := 80; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_OBRNFE'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_TIPPRO'; DataType := ftString; Size := 02; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_NUMFCI'; DataType := ftString; Size := 50; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_LOCSUP'; DataType := ftString; Size := 30; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_DESGRP'; DataType := ftString; Size := 40; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_APLICA'; DataType := ftString; Size := 5000; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_PRAPEL'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_PESOIT'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_PESLIQ'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_EMBALA'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_MLTVEN'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_MLTCOM'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_COMVAR'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_COMATA'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_COMDIS'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_DESMAX'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_DESMSU'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_MARMIN'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_MARMSG'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_TMPGAR'; DataType := ftInteger; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_IPISAI'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_PER_CI'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_PRECOM'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_DESF01'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_DESF02'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_DESF03'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_DESF04'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_DESF05'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_DESF06'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_ICMENT'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_SUBFED'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_IPIENT'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_FREENT'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_VALFRE'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_ACRFIN'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_SUBSTI'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_DESADB'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_OUTVAL'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_ICMSAI'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_IMPFED'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_DESOPE'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_COMTB1'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_MARBR1'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_PREVE1'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_COMTB2'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_MARBR2'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_PREVE2'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_COMTB3'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_MARBR3'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_PREVE3'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_COMTB4'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_MARBR4'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_PREVE4'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_COMTB5'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_MARBR5'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_PREVE5'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_COMTB6'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_MARBR6'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_PREVE6'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_COMTB7'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_MARBR7'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_PREVE7'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_ESTMIN'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_ESTMAX'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_LOCFIS'; DataType := ftString; Size := 30; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_DESMGE'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_MARMGE'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_DTAIMP'; DataType := ftDateTime; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_DIAFOR'; DataType := ftInteger; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_TIPOPE'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_PRECUS'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_TCIFCU'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_TSCUST'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_DEPICO'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_DEICMS'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_FATREG'; DataType := ftFloat; Required := False;
  End;
end;

procedure TImpProduto.pLimparTProdutoUpd;
begin
  recProdUpdate.IMP_CODITE := '';
  recProdUpdate.IMP_CODVEL := '';
  recProdUpdate.IMP_DESITE := '';
  recProdUpdate.IMP_DESSIM := '';
  recProdUpdate.IMP_DESFAB := '';
  recProdUpdate.IMP_CODFAB := '';
  recProdUpdate.IMP_CODFOR := '';
  recProdUpdate.IMP_C_G_C_ := '';
  recProdUpdate.IMP_REFERE := '';
  recProdUpdate.IMP_CODUNI := '';
  recProdUpdate.IMP_SIGUNI := '';
  recProdUpdate.IMP_UNICOM := '';
  recProdUpdate.IMP_SIGCOM := '';
  recProdUpdate.IMP_CODMAR := '';
  recProdUpdate.IMP_DESMAR := '';
  recProdUpdate.IMP_CODGRU := '';
  recProdUpdate.IMP_DESGRU := '';
  recProdUpdate.IMP_DESLIN := '';
  recProdUpdate.IMP_CODDEP := '';
  recProdUpdate.IMP_DESCRI := '';
  recProdUpdate.IMP_PRDGRU := '';
  recProdUpdate.IMP_CODBAR := '';
  recProdUpdate.IMP_BAREMB := '';
  recProdUpdate.IMP_EMBALA := '';
  recProdUpdate.IMP_APLICA := '';
  recProdUpdate.IMP_IMPLIS := '';
  recProdUpdate.IMP_ITEATI := '';
  recProdUpdate.IMP_ITEBAS := '';
  recProdUpdate.IMP_ITEPIG := '';
  recProdUpdate.IMP_PROEMB := '';
  recProdUpdate.IMP_VALOBR := '';
  recProdUpdate.IMP_INFLAM := '';
  recProdUpdate.IMP_BAREXP := '';
  recProdUpdate.IMP_PEEFUT := '';
  recProdUpdate.IMP_PEFFPR := '';
  recProdUpdate.IMP_PEFUTP := '';
  recProdUpdate.IMP_MSGLV1 := '';
  recProdUpdate.IMP_MSGLV2 := '';
  recProdUpdate.IMP_INFGAR := '';
  recProdUpdate.IMP_ATICOM := '';
  recProdUpdate.IMP_CPRCEN := '';
  recProdUpdate.IMP_RPRENT := '';
  recProdUpdate.IMP_ABAMLT := '';
  recProdUpdate.IMP_NVLGIR := '';
  recProdUpdate.IMP_ESMIDG := '';
  recProdUpdate.IMP_ACOOBJ := '';
  recProdUpdate.IMP_REAEND := '';
  recProdUpdate.IMP_CODABF := '';
  recProdUpdate.IMP_CLAIPI := '';
  recProdUpdate.IMP_EXCIPI := '';
  recProdUpdate.IMP_CODFIN := '';
  recProdUpdate.IMP_INCPIS := '';
  recProdUpdate.IMP_COMLUB := '';
  recProdUpdate.IMP_CODLUB := '';
  recProdUpdate.IMP_OBRCPF := '';
  recProdUpdate.IMP_OBRIBA := '';
  recProdUpdate.IMP_ABFPIS := '';
  recProdUpdate.IMP_ABFCOF := '';
  recProdUpdate.IMP_ABFIPI := '';
  recProdUpdate.IMP_CDCEST := '';
  recProdUpdate.IMP_MENFIS := '';
  recProdUpdate.IMP_OBRNFE := '';
  recProdUpdate.IMP_TIPPRO := '';
  recProdUpdate.IMP_NUMFCI := '';
  recProdUpdate.IMP_LOCSUP := '';
  recProdUpdate.IMP_DESGRP := '';
  recProdUpdate.IMP_TIPOPE := '';
  recProdUpdate.IMP_PRAPEL := 0;
  recProdUpdate.IMP_PESOIT := 0;
  recProdUpdate.IMP_PESLIQ := 0;
  recProdUpdate.IMP_MLTVEN := 0;
  recProdUpdate.IMP_MLTCOM := 0;
  recProdUpdate.IMP_COMVAR := 0;
  recProdUpdate.IMP_COMATA := 0;
  recProdUpdate.IMP_COMDIS := 0;
  recProdUpdate.IMP_DESMAX := 0;
  recProdUpdate.IMP_DESMSU := 0;
  recProdUpdate.IMP_MARMIN := 0;
  recProdUpdate.IMP_MARMSG := 0;
  recProdUpdate.IMP_MARMGE := 0;
  recProdUpdate.IMP_IPISAI := 0;
  recProdUpdate.IMP_PER_CI := 0;
  recProdUpdate.IMP_PRECOM := 0;
  recProdUpdate.IMP_DESF01 := 0;
  recProdUpdate.IMP_DESF02 := 0;
  recProdUpdate.IMP_DESF03 := 0;
  recProdUpdate.IMP_DESF04 := 0;
  recProdUpdate.IMP_DESF05 := 0;
  recProdUpdate.IMP_DESF06 := 0;
  recProdUpdate.IMP_ICMENT := 0;
  recProdUpdate.IMP_SUBFED := 0;
  recProdUpdate.IMP_IPIENT := 0;
  recProdUpdate.IMP_FREENT := 0;
  recProdUpdate.IMP_VALFRE := 0;
  recProdUpdate.IMP_ACRFIN := 0;
  recProdUpdate.IMP_SUBSTI := 0;
  recProdUpdate.IMP_DESADB := 0;
  recProdUpdate.IMP_OUTVAL := 0;
  recProdUpdate.IMP_ICMSAI := 0;
  recProdUpdate.IMP_IMPFED := 0;
  recProdUpdate.IMP_DESOPE := 0;
  recProdUpdate.IMP_COMTB1 := 0;
  recProdUpdate.IMP_MARBR1 := 0;
  recProdUpdate.IMP_PREVE1 := 0;
  recProdUpdate.IMP_COMTB2 := 0;
  recProdUpdate.IMP_MARBR2 := 0;
  recProdUpdate.IMP_PREVE2 := 0;
  recProdUpdate.IMP_COMTB3 := 0;
  recProdUpdate.IMP_MARBR3 := 0;
  recProdUpdate.IMP_PREVE3 := 0;
  recProdUpdate.IMP_COMTB4 := 0;
  recProdUpdate.IMP_MARBR4 := 0;
  recProdUpdate.IMP_PREVE4 := 0;
  recProdUpdate.IMP_COMTB5 := 0;
  recProdUpdate.IMP_MARBR5 := 0;
  recProdUpdate.IMP_PREVE5 := 0;
  recProdUpdate.IMP_COMTB6 := 0;
  recProdUpdate.IMP_MARBR6 := 0;
  recProdUpdate.IMP_PREVE6 := 0;
  recProdUpdate.IMP_COMTB7 := 0;
  recProdUpdate.IMP_MARBR7 := 0;
  recProdUpdate.IMP_PREVE7 := 0;
  recProdUpdate.IMP_ESTMIN := 0;
  recProdUpdate.IMP_ESTMAX := 0;
  recProdUpdate.IMP_LOCFIS := '';
  recProdUpdate.IMP_DESMGE := 0;
  recProdUpdate.IMP_DIAFOR := 0;
  recProdUpdate.IMP_TMPGAR := 0;
  recProdUpdate.IMP_CODIMP := 0;
  recProdUpdate.IMP_DTAIMP := 0;
  recProdUpdate.IMP_TCIFCU := 0;
  recProdUpdate.IMP_TSCUST := 0;
  recProdUpdate.IMP_DEPICO := 0;
  recProdUpdate.IMP_DEICMS := 0;
  recProdUpdate.IMP_FATREG := 0;
end;

{ TClasseBase }

constructor TClasseBase.Create(AOwner: TComponent; mmoLog, mmoExclusao: TMemoFocus; pgrGeral, pgrDetalhe: TProgressBar);
begin
  inherited Create(AOwner);
  Self.SetParentComponent(TWinControl(AOwner));

  pCriarCampos();

  Self.CreateDataSet();
  Self.Open();

  FIgnExcFor := False;
  FIgnExcPrd := False;

  If (Assigned(mmoLog)) Then
    FMemoLog := mmoLog
  Else
    FMemoLog := nil;

  If (Assigned(mmoExclusao)) Then
    FMemoExclusao := mmoExclusao
  Else
    FMemoExclusao := nil;

  If (Assigned(pgrGeral)) Then
    FPgrGeral := pgrGeral
  Else
    FPgrGeral := nil;

  If (Assigned(pgrDetalhe)) Then
    FPgrDetalhe := pgrDetalhe
  Else
    FPgrDetalhe := nil;
end;

procedure TClasseBase.pConfirmarVinculoRegistroExistente(strCamCodigo, strCamCodVel,
  strCamCodAut, strTabela: String);
begin
  Try
    Self.DisableControls();
    Self.First();

    While (Not Self.Eof) Do Begin
      If (fEmptyStr(Self.FieldByName(strCamCodigo).AsString)) Or
         (
           (Not fEmptyStr(Self.FieldByName(strCamCodigo).AsString)) And
           (Self.FieldByName(strCamCodigo).AsString <> Self.FieldByName(strCamCodAut).AsString)
         ) Then Begin

        Self.Edit();
        Self.FieldByName(strCamCodigo).AsString := Self.FieldByName(strCamCodAut).AsString;
        Self.Post();

        FMemoLog.Lines.Add(strTabela + ' VINCULADO A UM EXISTENTE NO DTS: CÓD. ANT.: ' +
          Self.FieldByName(strCamCodVel).AsString +
          ' | CÓD.: ' + Self.FieldByName(strCamCodAut).AsString);
      End;

      Self.Next();
    End;
  Finally
    Self.EnableControls();
  End;
end;

procedure TClasseBase.pDesfazerVinculosRegistroExistente(strCamCodigo, strCamCodVel, strCamCodAut: String);
begin
  Try
    Self.DisableControls();

    Self.Filtered := False;
    Self.Filter   := strCamCodAut + ' <> ' + strCamCodVel;
    Self.Filtered := True;

    Self.First();

    While (Not Self.Eof) Do Begin
      If (fEmptyStr(Self.FieldByName(strCamCodigo).AsString)) Or
         (
           (Not fEmptyStr(Self.FieldByName(strCamCodigo).AsString)) And
           (Self.FieldByName(strCamCodigo).AsString <> Self.FieldByName(strCamCodAut).AsString)
         ) Then Begin
        Self.Edit();
        Self.FieldByName(strCamCodAut).AsString := Self.FieldByName(strCamCodigo).AsString;
        Self.Post();
      End;

      Self.Next();
    End;
  Finally
    Self.Filtered := False;
    Self.Filter   := '';
    Self.EnableControls();
  End;
end;

procedure TClasseBase.pIncrementarPositionProgressos;
var
  blnProcessMessages: Boolean;
begin
  blnProcessMessages := False;
  If (Assigned(FPgrGeral)) Then
  Begin
    FPgrGeral.Position := FPgrGeral.Position + 1;
    blnProcessMessages := FPgrGeral.Position Mod 20 = 0;
  End;

  If (Assigned(FPgrDetalhe)) Then
  Begin
    FPgrDetalhe.Position := FPgrDetalhe.Position + 1;
    blnProcessMessages := FPgrDetalhe.Position Mod 20 = 0;
  End;

  If blnProcessMessages Then
    Application.ProcessMessages;
end;

procedure TClasseBase.pInicializarPrgDetalhe;
begin
  If (Assigned(FPgrDetalhe)) Then Begin
    FPgrDetalhe.Min := 0;
    FPgrDetalhe.Max := Self.RecordCount;
    FPgrDetalhe.Position := 0;
  End;
end;

function TClasseBase.fCampoExcluido(const AstrCampo: String): Boolean;
var
  intI: Integer;
begin
  Result := True;
  for intI := 0 to High(FArrCamposSelecionados) do
    if SameText(FArrCamposSelecionados[intI], AstrCampo) then
    begin
      Result := False;
      Break;
    end;
end;

procedure TClasseBase.pLimparClient;
begin
  If (Self.Active) And (Not Self.IsEmpty) Then Begin
    Self.EmptyDataSet();

    FMemoLog.Lines.Clear();
  End;
end;

procedure TClasseBase.pLimparRegistroExistente(strCodVel, strCodigo, strCamCodVel, strCamCodAut, strTabela: String);
begin
  If (Self.Locate(strCamCodVel, strCodVel, [])) Then Begin
    Self.Edit();
    Self.FieldByName(strCamCodAut).AsString := '';
    Self.Post();

    FMemoLog.Lines.Add(strTabela + ' VÍNCULO REMOVIDO NO DTS: CÓD. ANT.: ' +
      Self.FieldByName(strCamCodVel).AsString +
      ' | CÓD. REMOVIDO: ' + strCodigo);
  End;
end;

procedure TClasseBase.pVincularRegistroExistente(strCodVel, strCodigo, strCamCodVel, strCamCodAut, strTabela: String);
begin
  If (Self.Locate(strCamCodVel, strCodVel, [])) Then Begin
    Self.Edit();
    Self.FieldByName(strCamCodAut).AsString := strCodigo;
    Self.Post();
  End;
end;

{ TCadLinGru }

function TCadLinGru.fCadastrarLinha: Boolean;
  Var
    strCodigo: String;
    qryTemp: TUniQuery;
begin
  Result := False;

  Try
    qryTemp := fCriaQuery(nil);

    Try
      qryTemp.Close();
      qryTemp.SQL.Clear();
      qryTemp.SQL.Text := SQL_INSERT_CADGRU;

      strCodigo := Copy(Self.FieldByName('GRU_CODVEL').AsString, 1, 3) + '000';

      qryTemp.ParamByName('AUTINC').AsString   := fRetAutoIncrem('CADGRU', VS_strCodEmp);
      qryTemp.ParamByName('CODGRU').AsString   := strCodigo;
      qryTemp.ParamByName('CODVEL').AsString   := Self.FieldByName('GRU_CODVEL').AsString;
      qryTemp.ParamByName('DESGRU').AsString   := Self.FieldByName('GRU_DESLIN').AsString;
      qryTemp.ParamByName('CODEMP').AsString   := Self.FieldByName('GRU_CODEMP').AsString;
      qryTemp.ParamByName('CODVEL').AsString   := Self.FieldByName('GRU_CODVEL').AsString;
      qryTemp.ParamByName('DRELIN').AsString   := '';
      qryTemp.ParamByName('DREGRU').AsString   := Self.FieldByName('GRU_DREGRU').AsString;
      qryTemp.ParamByName('DETLIN').AsString   := '';
      qryTemp.ParamByName('DETGRU').AsString   := Self.FieldByName('GRU_DETGRU').AsString;
      qryTemp.ParamByName('SGETGR').AsString   := Self.FieldByName('GRU_SGETGR').AsString;
      qryTemp.ParamByName('PERCOM').AsFloat    := Self.FieldByName('GRU_PERCOM').AsFloat;
      qryTemp.ParamByName('TIPGRU').AsInteger  := Self.FieldByName('GRU_TIPGRU').AsInteger;
      qryTemp.ParamByName('ULTALT').AsDateTime := Self.FieldByName('GRU_ULTALT').AsDateTime;
      qryTemp.ExecSQL();

      FMemoLog.Lines.Add(#13#10 + 'CADASTRO DA LINHA ' + strCodigo + ' REALIZADO COM SUCESSO!' + #13#10);

      Result := True;
    Except
      On E : Exception Do Begin
        pMensagensErro(E.Message, '[TCadLinGru.fCadastrarLinha]');

        FMemoLog.Lines.Add(#13#10 + 'ERRO: ' + E.Message + #13#10);
      End;
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

function TCadLinGru.fGrupoExiste: Boolean;
  Var
    strCodigo: String;
begin
  strCodigo := fCampoTabela('GRU_CODGRU', 'CADGRU', ['GRU_CODGRU'], [Self.FieldByName('GRU_CODVEL').AsString]);
  Result    := (Not fEmptyStr(strCodigo));
end;

function TCadLinGru.fLinhaExiste: Boolean;
  Var
    strCodigo: String;
begin
  strCodigo := fCampoTabela('GRU_CODGRU', 'CADGRU', ['GRU_CODGRU'], [Copy(Self.FieldByName('GRU_CODVEL').AsString, 1, 3) + '000']);
  Result    := (Not fEmptyStr(strCodigo));
end;

function TCadLinGru.fSalvarRegistros: Boolean;
  Var
    qryTemp: TUniQuery;

  procedure pInicializarQry; begin
    qryTemp.Close();
    qryTemp.SQL.Clear();
    qryTemp.SQL.Text := SQL_INSERT_CADGRU;
  end;

begin
  Result := True;

  Try
    qryTemp := fCriaQuery(nil);

    Try
      Self.First();
      pInicializarPrgDetalhe();

      While (Not Self.Eof) Do Begin
        pInicializarQry();

        pVerificarCadastroLinha();

        If (fEmptyStr(Self.FieldByName('GRU_CODAUT').AsString)) And (Not Self.fGrupoExiste()) Then Begin
          qryTemp.ParamByName('CODGRU').AsString := Self.FieldByName('GRU_CODVEL').AsString ;

          Self.Edit();
          Self.FieldByName('GRU_CODGRU').AsString := qryTemp.ParamByName('CODGRU').AsString;
          Self.FieldByName('GRU_CODAUT').AsString := qryTemp.ParamByName('CODGRU').AsString;
          Self.Post();
        End Else Begin
          //ATUALIZAR OS REGISTROS A SEREM IMPORTADOS COM O CÓDIGO RESPECTIVO
          pIncrementarPositionProgressos();
          Self.Next();
          Continue;
        End;

        qryTemp.ParamByName('AUTINC').AsString   := fRetAutoIncrem('CADGRU', VS_strCodEmp);
        qryTemp.ParamByName('CODVEL').AsString   := Self.FieldByName('GRU_CODVEL').AsString;
        qryTemp.ParamByName('DESGRU').AsString   := Self.FieldByName('GRU_DESGRU').AsString;
        qryTemp.ParamByName('CODEMP').AsString   := Self.FieldByName('GRU_CODEMP').AsString;
        qryTemp.ParamByName('CODVEL').AsString   := Self.FieldByName('GRU_CODVEL').AsString;
        qryTemp.ParamByName('DRELIN').AsString   := Self.FieldByName('GRU_DRELIN').AsString;
        qryTemp.ParamByName('DREGRU').AsString   := Self.FieldByName('GRU_DREGRU').AsString;
        qryTemp.ParamByName('DETLIN').AsString   := Self.FieldByName('GRU_DETLIN').AsString;
        qryTemp.ParamByName('DETGRU').AsString   := Self.FieldByName('GRU_DETGRU').AsString;
        qryTemp.ParamByName('SGETGR').AsString   := Self.FieldByName('GRU_SGETGR').AsString;
        qryTemp.ParamByName('PERCOM').AsFloat    := Self.FieldByName('GRU_PERCOM').AsFloat;
        qryTemp.ParamByName('TIPGRU').AsInteger  := Self.FieldByName('GRU_TIPGRU').AsInteger;
        qryTemp.ParamByName('ULTALT').AsDateTime := Self.FieldByName('GRU_ULTALT').AsDateTime;

        qryTemp.ExecSQL();

        FMemoLog.Lines.Add('LINHA/GRUPO ADICIONADO AO BD: CÓD. ANT. : ' +
          Self.FieldByName('GRU_CODVEL').AsString +
          ' | CÓD.: ' + Self.FieldByName('GRU_CODGRU').AsString);

        pIncrementarPositionProgressos();
        Self.Next();
      End;
    Finally
      FreeAndNil(qryTemp);
    End;
  Except
    On E : Exception Do Begin
      Result := False;
		  pMensagensErro(E.Message, '[TCadLinGru.fSalvarRegistros]');

      FMemoLog.Lines.Add(#13#10 + 'ERRO: ' + E.Message + #13#10);
    End;
  End;
end;

procedure TCadLinGru.pAdicionar(params: TRecParamAdicionar);
  Var
    strTemp: String;
begin
  If (fEmptyStr(params.strDescricao)) Then Exit;

  If (Self.Locate('GRU_CODVEL;GRU_DESGRU;GRU_DESLIN', VarArrayOf([params.strCodigo, params.strDescricao, params.strDescricao2]), [])) Then
    Exit;

  Try
    strTemp := fCampoTabela('GRU_CODGRU', 'CADGRU', ['GRU_CODVEL'], [params.strCodigo]);

    If (fEmptyStr(strTemp)) Then Begin
      strTemp := fCampoTabela('GRU_CODGRU', 'CADGRU', ['GRU_CODGRU'], [params.strCodigo]);
    End;

    Self.Append();
    Self.FieldByName('ID').AsInteger := params.intID;
    Self.FieldByName('GRU_CODGRU').AsString   := strTemp;
    Self.FieldByName('GRU_CODAUT').AsString   := strTemp;
    Self.FieldByName('GRU_CODVEL').AsString   := params.strCodigo;
    Self.FieldByName('GRU_DESGRU').AsString   := Trim(params.strDescricao);
    Self.FieldByName('GRU_CODEMP').AsString   := VS_strCodEmp;
    Self.FieldByName('AUTOINCREM').AsString   := '';
    Self.FieldByName('GRU_DRELIN').AsString   := Trim(params.strDescricao2);
    Self.FieldByName('GRU_DETLIN').AsString   := Trim(params.strDescricao2);
    Self.FieldByName('GRU_DESLIN').AsString   := Trim(params.strDescricao2);
    Self.FieldByName('GRU_DREGRU').AsString   := '';
    Self.FieldByName('GRU_DETGRU').AsString   := '';
    Self.FieldByName('GRU_SGETGR').AsString   := '';
    Self.FieldByName('GRU_PERCOM').AsFloat    := 0;
    Self.FieldByName('GRU_TIPGRU').AsInteger  := 0;
    Self.FieldByName('GRU_ULTALT').AsDateTime := 0;
    Self.Post();

    FMemoLog.Lines.Add('LINHA/GRUPO ADICIONADO NO DATASET: CÓDIGO ANTERIOR: ' + params.strCodigo +
      ' | CÓD.: ' + strTemp);
  Except
    On E : Exception Do
		  pMensagensErro(E.Message, '[TCadLinGru.pAdicionar]');
  End;
end;

procedure TCadLinGru.pCriarCampos;
begin
  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'ID'; DataType := ftInteger; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'GRU_CODGRU'; DataType := ftString; Size := 06; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'GRU_CODAUT'; DataType := ftString; Size := 06; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'GRU_DESGRU'; DataType := ftString; Size := 70; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'GRU_CODEMP'; DataType := ftString; Size := 03; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'AUTOINCREM'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'GRU_CODVEL'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'GRU_DRELIN'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'GRU_DREGRU'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'GRU_DETLIN'; DataType := ftString; Size := 70; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'GRU_DESLIN'; DataType := ftString; Size := 70; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'GRU_DETGRU'; DataType := ftString; Size := 10; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'GRU_SGETGR'; DataType := ftString; Size := 10; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'GRU_PERCOM'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'GRU_TIPGRU'; DataType := ftInteger; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'GRU_ULTALT'; DataType := ftDateTime; Required := False;
  End;
end;

procedure TCadLinGru.pVerificarCadastroLinha;
begin
  If (Not Self.fLinhaExiste()) Then
    Self.fCadastrarLinha();
end;

{ TCadMar }
function TCadMar.fSalvarRegistros: Boolean;
  Var
    qryTemp: TUniQuery;

  procedure pInicializarQry; begin
    qryTemp.Close();
    qryTemp.SQL.Clear();
    qryTemp.SQL.Text := SQL_INSERT_CADMAR;
  end;

begin
  Result := True;

  Try
    qryTemp := fCriaQuery(nil);

    Try
      Self.First();
      pInicializarPrgDetalhe();

      While (Not Self.Eof) Do Begin
        pInicializarQry();

        If (fEmptyStr(Self.FieldByName('MAR_CODAUT').AsString)) Then Begin
          Repeat
            qryTemp.ParamByName('CODMAR').AsString := fAtualizaProCod('CADMAR', 'MAR_CODMAR');
          Until (fEmptyStr(fCampoTabela('MAR_CODMAR', 'CADMAR', ['MAR_CODMAR'], [qryTemp.ParamByName('CODMAR').AsString])));

          Self.Edit();
          Self.FieldByName('MAR_CODMAR').AsString := qryTemp.ParamByName('CODMAR').AsString;
          Self.FieldByName('MAR_CODAUT').AsString := qryTemp.ParamByName('CODMAR').AsString;
          Self.Post();
        End Else Begin
          //ATUALIZAR OS REGISTROS A SEREM IMPORTADOS COM O CÓDIGO RESPECTIVO
          pIncrementarPositionProgressos();
          Self.Next();
          Continue;
        End;

        qryTemp.ParamByName('AUTINC').AsString   := fRetAutoIncrem('CADMAR', VS_strCodEmp);
        qryTemp.ParamByName('CODVEL').AsString   := Self.FieldByName('MAR_CODVEL').AsString;
        qryTemp.ParamByName('DESMAR').AsString   := Self.FieldByName('MAR_DESMAR').AsString;
        qryTemp.ParamByName('CODEMP').AsString   := Self.FieldByName('MAR_CODEMP').AsString;
        qryTemp.ParamByName('CODGRU').AsString   := Self.FieldByName('MAR_CODGRU').AsString;
        qryTemp.ParamByName('FATCUS').AsFloat    := Self.FieldByName('MAR_FATCUS').AsFloat;
        qryTemp.ParamByName('ULTALT').AsDateTime := Self.FieldByName('MAR_ULTALT').AsDateTime;

        qryTemp.ExecSQL();

        FMemoLog.Lines.Add('MARCA ADICIONADA AO BANCO DE DADOS: CÓDIGO ANTERIOR : ' +
          Self.FieldByName('MAR_CODVEL').AsString +
          ' | CÓD.: ' + Self.FieldByName('MAR_CODMAR').AsString);

        pIncrementarPositionProgressos();
        Self.Next();
      End;
    Finally
      FreeAndNil(qryTemp);
    End;
  Except
    On E : Exception Do Begin
      Result := False;
		  pMensagensErro(E.Message, '[TCadDep.fSalvarRegistros]');

      FMemoLog.Lines.Add(#13#10 + 'ERRO: ' + E.Message + #13#10);
    End;
  End;
end;

procedure TCadMar.pAdicionar(params: TRecParamAdicionar);
  Var
    strTemp: String;
begin
  If (fEmptyStr(params.strDescricao)) Then Exit;

  If (Self.Locate('MAR_CODVEL;MAR_DESMAR', VarArrayOf([params.strCodigo, params.strDescricao]), [])) Then
    Exit;

  Try
    strTemp := fCampoTabela('MAR_CODMAR', 'CADMAR', ['MAR_CODVEL', 'MAR_DESMAR'],
      [params.strCodigo, params.strDescricao]);

    If (fEmptyStr(strTemp)) Then Begin
      strTemp := fCampoTabela('MAR_CODMAR', 'CADMAR', ['MAR_CODMAR', 'MAR_DESMAR'],
        [params.strCodigo, params.strDescricao]);
    End;

    Self.Append();
    Self.FieldByName('ID').AsInteger := params.intID;
    Self.FieldByName('MAR_CODMAR').AsString   := strTemp;
    Self.FieldByName('MAR_CODAUT').AsString   := strTemp;
    Self.FieldByName('MAR_CODVEL').AsString   := params.strCodigo;
    Self.FieldByName('MAR_DESMAR').AsString   := params.strDescricao;
    Self.FieldByName('MAR_CODEMP').AsString   := VS_strCodEmp;
    Self.FieldByName('AUTOINCREM').AsString   := '';
    Self.FieldByName('MAR_CODGRU').AsString   := '';
    Self.FieldByName('MAR_FATCUS').AsFloat    := 0;
    Self.FieldByName('MAR_ULTALT').AsDateTime := 0;

    Self.Post();

    FMemoLog.Lines.Add('MARCA ADICIONADA AO DATASET: CÓDIGO ANTERIOR: ' + params.strCodigo +
      ' | CÓD.: ' + strTemp);
  Except
    On E : Exception Do
		  pMensagensErro(E.Message, '[TCadMar.pAdicionar]');
  End;
end;

procedure TCadMar.pCriarCampos;
begin
  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'ID'; DataType := ftInteger; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'MAR_CODMAR'; DataType := ftString; Size := 06; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'MAR_CODAUT'; DataType := ftString; Size := 06; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'MAR_DESMAR'; DataType := ftString; Size := 30; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'MAR_CODEMP'; DataType := ftString; Size := 03; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'AUTOINCREM'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'MAR_CODGRU'; DataType := ftString; Size := 03; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'MAR_CODVEL'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'MAR_FATCUS'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'MAR_ULTALT'; DataType := ftDateTime; Required := False;
  End;
end;

{ TCadUni }

function TCadUni.fSalvarRegistros: Boolean;
  Var
    qryTemp: TUniQuery;
    intAlfa: Integer;

  procedure pInicializarQry; begin
    qryTemp.Close();
    qryTemp.SQL.Clear();
    qryTemp.SQL.Text := SQL_INSERT_CADUNI;
  end;

begin
  Result := True;

  Try
    qryTemp := fCriaQuery(nil);

    Try
      Self.First();
      pInicializarPrgDetalhe();

      While (Not Self.Eof) Do Begin

        pInicializarQry();

        If (fEmptyStr(Self.FieldByName('UNI_CODAUT').AsString)) Then
        Begin

          {27 = AA}
          intAlfa := 27;

          Repeat

            qryTemp.ParamByName('CODUNI').AsString := fAtualizaProCod('CADUNI', 'UNI_CODUNI');

            {Gerar códigos ALFA apartir do 99}
            If (qryTemp.ParamByName('CODUNI').AsString = '99') And
               Not fEmptyStr(fCampoTabela('UNI_CODUNI', 'CADUNI', ['UNI_CODUNI'], [qryTemp.ParamByName('CODUNI').AsString])) Then
            Begin

              qryTemp.ParamByName('CODUNI').AsString := fGetLetraAlfa(intAlfa);

              while Not fEmptyStr(fCampoTabela('UNI_CODUNI', 'CADUNI', ['UNI_CODUNI'], [qryTemp.ParamByName('CODUNI').AsString])) do
              begin
                intAlfa := intAlfa + 1;
                qryTemp.ParamByName('CODUNI').AsString := fGetLetraAlfa(intAlfa);
              end;

            End;

          Until (fEmptyStr(fCampoTabela('UNI_CODUNI', 'CADUNI', ['UNI_CODUNI'], [qryTemp.ParamByName('CODUNI').AsString])));

          Self.Edit();
          Self.FieldByName('UNI_CODUNI').AsString := qryTemp.ParamByName('CODUNI').AsString;
          Self.FieldByName('UNI_CODAUT').AsString := qryTemp.ParamByName('CODUNI').AsString;
          Self.Post();

        End Else Begin
          //ATUALIZAR OS REGISTROS A SEREM IMPORTADOS COM O CÓDIGO RESPECTIVO
          pIncrementarPositionProgressos();
          Self.Next();
          Continue;
        End;

        qryTemp.ParamByName('AUTINC').AsString   := fRetAutoIncrem('CADUNI', VS_strCodEmp);
        qryTemp.ParamByName('CODVEL').AsString   := Self.FieldByName('UNI_CODVEL').AsString;
        qryTemp.ParamByName('DESUNI').AsString   := Self.FieldByName('UNI_DESUNI').AsString;
        qryTemp.ParamByName('CODEMP').AsString   := Self.FieldByName('UNI_CODEMP').AsString;
        qryTemp.ParamByName('ITEFRA').AsString   := Self.FieldByName('UNI_ITEFRA').AsString;
        qryTemp.ParamByName('SIGUNI').AsString   := Self.FieldByName('UNI_SIGUNI').AsString;
        qryTemp.ParamByName('METFAT').AsString   := Self.FieldByName('UNI_METFAT').AsString;
        qryTemp.ParamByName('DREUNI').AsString   := Self.FieldByName('UNI_DREUNI').AsString;
        qryTemp.ParamByName('DETUNI').AsString   := Self.FieldByName('UNI_DETUNI').AsString;
        qryTemp.ParamByName('KILLIT').AsString   := Self.FieldByName('UNI_KILLIT').AsString;
        qryTemp.ParamByName('PEAPBE').AsString   := Self.FieldByName('UNI_PEAPBE').AsString;
        qryTemp.ParamByName('PESLIT').AsFloat    := Self.FieldByName('UNI_PESLIT').AsFloat;
        qryTemp.ParamByName('ULTALT').AsDateTime := Self.FieldByName('UNI_ULTALT').AsDateTime;

        qryTemp.ExecSQL();

        FMemoLog.Lines.Add('UNIDADE ADICIONADA AO BANCO DE DADOS: CÓDIGO ANTERIOR : ' +
          Self.FieldByName('UNI_CODVEL').AsString +
          ' | CÓD.: ' + Self.FieldByName('UNI_CODUNI').AsString);

        pIncrementarPositionProgressos();
        Self.Next();
      End;
    Finally
      FreeAndNil(qryTemp);
    End;
  Except
    On E : Exception Do Begin
      Result := False;
		  pMensagensErro(E.Message, '[TCadUni.fSalvarRegistros]');

      FMemoLog.Lines.Add(#13#10 + 'ERRO: ' + E.Message + #13#10);
    End;
  End;
end;

procedure TCadUni.pAdicionar(params: TRecParamAdicionar);
  Var
    strTemp: String;
begin
  If (fEmptyStr(params.strDescricao)) Then Exit;

  If (Self.Locate('UNI_CODVEL;UNI_SIGUNI', VarArrayOf([params.strCodigo, params.strDescricao]), [])) Then
    Exit;

  Try
    strTemp := fCampoTabela('UNI_CODUNI', 'CADUNI', ['UNI_CODVEL', 'UNI_SIGUNI'],
      [params.strCodigo, params.strDescricao]);

    If (fEmptyStr(strTemp)) Then Begin
      strTemp := fCampoTabela('UNI_CODUNI', 'CADUNI', ['UNI_CODUNI', 'UNI_SIGUNI'],
        [params.strCodigo, params.strDescricao]);
    End;

    Self.Append();
    Self.FieldByName('ID').AsInteger := params.intID;
    Self.FieldByName('UNI_CODUNI').AsString   := strTemp;
    Self.FieldByName('UNI_CODAUT').AsString   := strTemp;
    Self.FieldByName('UNI_CODVEL').AsString   := params.strCodigo;
    Self.FieldByName('UNI_DESUNI').AsString   := params.strDescricao;
    Self.FieldByName('UNI_CODEMP').AsString   := VS_strCodEmp;
    Self.FieldByName('AUTOINCREM').AsString   := '';
    Self.FieldByName('UNI_ITEFRA').AsString   := '';
    Self.FieldByName('UNI_SIGUNI').AsString   := params.strDescricao;
    Self.FieldByName('UNI_METFAT').AsString   := 'N';
    Self.FieldByName('UNI_DREUNI').AsString   := '';
    Self.FieldByName('UNI_DETUNI').AsString   := '';
    Self.FieldByName('UNI_KILLIT').AsString   := '';
    Self.FieldByName('UNI_PEAPBE').AsString   := 'N';
    Self.FieldByName('UNI_PESLIT').AsFloat    := 0;
    Self.FieldByName('UNI_ULTALT').Clear();

    Self.Post();

    FMemoLog.Lines.Add('UNIDADE ADICIONADA AO DATASET: CÓDIGO ANTERIOR: ' + params.strCodigo +
      ' | CÓD.: ' + strTemp);
  Except
    On E : Exception Do
		  pMensagensErro(E.Message, '[TCadUni.pAdicionar]');
  End;
end;

procedure TCadUni.pCriarCampos;
begin
  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'ID'; DataType := ftInteger; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'UNI_CODUNI'; DataType := ftString; Size := 02; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'UNI_CODAUT'; DataType := ftString; Size := 02; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'UNI_CODVEL'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'UNI_DESUNI'; DataType := ftString; Size := 15; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'UNI_CODEMP'; DataType := ftString; Size := 03; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'AUTOINCREM'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'UNI_ITEFRA'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'UNI_SIGUNI'; DataType := ftString; Size := 06; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'UNI_METFAT'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'UNI_DREUNI'; DataType := ftString; Size := 10; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'UNI_DETUNI'; DataType := ftString; Size := 10; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'UNI_KILLIT'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'UNI_PEAPBE'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'UNI_PESLIT'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'UNI_ULTALT'; DataType := ftDateTime; Required := False;
  End;
end;

{ TGrpPrd }

function TGrpPrd.fSalvarRegistros: Boolean;
  Var
    qryTemp: TUniQuery;

  procedure pInicializarQry; begin
    qryTemp.Close();
    qryTemp.SQL.Clear();
    qryTemp.SQL.Text := SQL_INSERT_GRPPRD;
  end;

begin
  Result := True;

  Try
    qryTemp := fCriaQuery(nil);

    Try
      Self.First();
      pInicializarPrgDetalhe();

      While (Not Self.Eof) Do Begin
        pInicializarQry();

        If (fEmptyStr(Self.FieldByName('PRD_CODAUT').AsString)) Then Begin
          Repeat
            qryTemp.ParamByName('CODGRU').AsString := fAtualizaProCod('GRPPRD', 'PRD_CODGRU');
          Until (fEmptyStr(fCampoTabela('PRD_CODGRU', 'GRPPRD', ['PRD_CODGRU'], [qryTemp.ParamByName('CODGRU').AsString])));

          Self.Edit();
          Self.FieldByName('PRD_CODGRU').AsString := qryTemp.ParamByName('CODGRU').AsString;
          Self.FieldByName('PRD_CODAUT').AsString := qryTemp.ParamByName('CODGRU').AsString;
          Self.Post();
        End Else Begin
          //ATUALIZAR OS REGISTROS A SEREM IMPORTADOS COM O CÓDIGO RESPECTIVO
          pIncrementarPositionProgressos();
          Self.Next();
          Continue;
        End;

        qryTemp.ParamByName('AUTINC').AsString := fRetAutoIncrem('GRPPRD', VS_strCodEmp);
        qryTemp.ParamByName('CODVEL').AsString := Self.FieldByName('PRD_CODVEL').AsString;
        qryTemp.ParamByName('DESGRU').AsString := Self.FieldByName('PRD_DESGRU').AsString;
        qryTemp.ParamByName('CODEMP').AsString := Self.FieldByName('PRD_CODEMP').AsString;

        qryTemp.ExecSQL();

        FMemoLog.Lines.Add('GRUPO DE PRODUTO ADICIONADO AO BD: CÓD. ANT. : ' +
          Self.FieldByName('PRD_CODVEL').AsString +
          ' | CÓD.: ' + Self.FieldByName('PRD_CODGRU').AsString);

        pIncrementarPositionProgressos();
        Self.Next();
      End;
    Finally
      FreeAndNil(qryTemp);
    End;
  Except
    On E : Exception Do Begin
      Result := False;
		  pMensagensErro(E.Message, '[TGrpPrd.fSalvarRegistros]');

      FMemoLog.Lines.Add(#13#10 + 'ERRO: ' + E.Message + #13#10);
    End;
  End;
end;

procedure TGrpPrd.pAdicionar(params: TRecParamAdicionar);
  Var
    strTemp: String;
begin
  If (fEmptyStr(params.strDescricao)) Then Exit;

  If (Self.Locate('PRD_CODVEL;PRD_DESGRU', VarArrayOf([params.strCodigo, params.strDescricao]), [])) Then
    Exit;

  Try
    strTemp := fCampoTabela('PRD_CODGRU', 'GRPPRD', ['PRD_CODVEL', 'PRD_DESGRU'],
      [params.strCodigo, params.strDescricao]);

    If (fEmptyStr(strTemp)) Then Begin
      strTemp := fCampoTabela('PRD_CODGRU', 'GRPPRD', ['PRD_CODGRU', 'PRD_DESGRU'],
        [params.strCodigo, params.strDescricao]);
    End;

    Self.Append();
    Self.FieldByName('ID').AsInteger := params.intID;
    Self.FieldByName('PRD_CODGRU').AsString   := strTemp;
    Self.FieldByName('PRD_CODAUT').AsString   := strTemp;
    Self.FieldByName('PRD_CODVEL').AsString   := params.strCodigo;
    Self.FieldByName('PRD_DESGRU').AsString   := params.strDescricao;
    Self.FieldByName('PRD_CODEMP').AsString   := VS_strCodEmp;
    Self.FieldByName('AUTOINCREM').AsString   := '';

    Self.Post();

    FMemoLog.Lines.Add('GRUPO DE PRODUTO ADICIONADO AO DTS: CÓD. ANT.: ' + params.strCodigo +
      ' | CÓD.: ' + strTemp);
  Except
    On E : Exception Do
		  pMensagensErro(E.Message, '[TGrpPrd.pAdicionar]');
  End;
end;

procedure TGrpPrd.pCriarCampos;
begin
  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'ID'; DataType := ftInteger; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'PRD_CODGRU'; DataType := ftString; Size := 05; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'PRD_CODAUT'; DataType := ftString; Size := 05; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'PRD_CODVEL'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'PRD_DESGRU'; DataType := ftString; Size := 40; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'PRD_CODEMP'; DataType := ftString; Size := 03; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'AUTOINCREM'; DataType := ftString; Size := 20; Required := False;
  End;
end;

{ TCadAti }

function TCadAti.fSalvarRegistros: Boolean;
  Var
    qryTemp: TUniQuery;

  procedure pInicializarQry; begin
    qryTemp.Close();
    qryTemp.SQL.Clear();
    qryTemp.SQL.Text := SQL_INSERT_CADATI;
  end;

begin
  Result := True;

  Try
    qryTemp := fCriaQuery(nil);

    Try
      Self.First();
      pInicializarPrgDetalhe();

      While (Not Self.Eof) Do Begin
        pInicializarQry();

        If (fEmptyStr(Self.FieldByName('ATI_CODAUT').AsString)) Then Begin
          Repeat
            qryTemp.ParamByName('CODATI').AsString := fAtualizaProCod('CADATI', 'ATI_CODATI');
          Until (fEmptyStr(fCampoTabela('ATI_CODATI', 'CADATI', ['ATI_CODATI'], [qryTemp.ParamByName('CODATI').AsString])));

          Self.Edit();
          Self.FieldByName('ATI_CODATI').AsString := qryTemp.ParamByName('CODATI').AsString;
          Self.FieldByName('ATI_CODAUT').AsString := qryTemp.ParamByName('CODATI').AsString;
          Self.Post();
        End Else Begin
          //ATUALIZAR OS REGISTROS A SEREM IMPORTADOS COM O CÓDIGO RESPECTIVO
          pIncrementarPositionProgressos();
          Self.Next();
          Continue;
        End;

        qryTemp.ParamByName('AUTINC').AsString   := fRetAutoIncrem('CADATI', VS_strCodEmp);
        qryTemp.ParamByName('CODVEL').AsString   := Self.FieldByName('ATI_CODVEL').AsString;
        qryTemp.ParamByName('DESATI').AsString   := Self.FieldByName('ATI_DESATI').AsString;
        qryTemp.ParamByName('CODEMP').AsString   := Self.FieldByName('ATI_CODEMP').AsString;
        qryTemp.ParamByName('TABPRE').AsString   := Self.FieldByName('ATI_TABPRE').AsString;
        qryTemp.ParamByName('CODGAT').AsString   := Self.FieldByName('ATI_CODGAT').AsString;
        qryTemp.ParamByName('CODJON').AsString   := Self.FieldByName('ATI_CODJON').AsString;
        qryTemp.ParamByName('PERCOM').AsFloat    := Self.FieldByName('ATI_PERCOM').AsFloat;
        qryTemp.ParamByName('RENPRE').AsFloat    := Self.FieldByName('ATI_RENPRE').AsFloat;
        qryTemp.ParamByName('ULTALT').AsDateTime := Self.FieldByName('ATI_ULTALT').AsDateTime;

        qryTemp.ExecSQL();

        FMemoLog.Lines.Add('ATIVIDADE ADICIONADA AO BANCO DE DADOS: CÓDIGO ANTERIOR : ' +
          Self.FieldByName('ATI_CODVEL').AsString +
          ' | CÓD.: ' + Self.FieldByName('ATI_CODATI').AsString);

        pIncrementarPositionProgressos();
        Self.Next();
      End;
    Finally
      FreeAndNil(qryTemp);
    End;
  Except
    On E : Exception Do Begin
      Result := False;
		  pMensagensErro(E.Message, '[TCadAti.fSalvarRegistros]');

      FMemoLog.Lines.Add(#13#10 + 'ERRO: ' + E.Message + #13#10);
    End;
  End;
end;

procedure TCadAti.pAdicionar(params: TRecParamAdicionar);
  Var
    strTemp: String;
begin
  If (fEmptyStr(params.strDescricao)) Then Exit;

  If (Self.Locate('ATI_CODVEL;ATI_DESATI', VarArrayOf([params.strCodigo, params.strDescricao]), [])) Then
    Exit;

  Try
    strTemp := fCampoTabela('ATI_CODATI', 'CADATI', ['ATI_CODVEL', 'ATI_DESATI'],
      [params.strCodigo, params.strDescricao]);

    If (fEmptyStr(strTemp)) Then Begin
      strTemp := fCampoTabela('ATI_CODATI', 'CADATI', ['ATI_CODATI', 'ATI_DESATI'],
        [params.strCodigo, params.strDescricao]);
    End;

    Self.Append();
    Self.FieldByName('ID').AsInteger := params.intID;
    Self.FieldByName('ATI_CODATI').AsString   := strTemp;
    Self.FieldByName('ATI_CODAUT').AsString   := strTemp;
    Self.FieldByName('ATI_CODVEL').AsString   := params.strCodigo;
    Self.FieldByName('ATI_DESATI').AsString   := params.strDescricao;
    Self.FieldByName('ATI_CODEMP').AsString   := VS_strCodEmp;
    Self.FieldByName('AUTOINCREM').AsString   := '';
    Self.FieldByName('ATI_TABPRE').AsString   := '';
    Self.FieldByName('ATI_CODGAT').AsString   := '';
    Self.FieldByName('ATI_CODJON').AsString   := '';
    Self.FieldByName('ATI_PERCOM').AsFloat    := 0;
    Self.FieldByName('ATI_RENPRE').AsFloat    := 0;
    Self.FieldByName('ATI_ULTALT').AsDateTime := 0;

    Self.Post();

    FMemoLog.Lines.Add('ATIVIDADE ADICIONADA AO DATASET: CÓDIGO ANTERIOR: ' + params.strCodigo +
      ' | CÓD.: ' + strTemp);
  Except
    On E : Exception Do
		  pMensagensErro(E.Message, '[TCadAti.pAdicionar]');
  End;
end;

procedure TCadAti.pCriarCampos;
begin
  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'ID'; DataType := ftInteger; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'ATI_CODATI'; DataType := ftString; Size := 03; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'ATI_CODAUT'; DataType := ftString; Size := 03; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'ATI_DESATI'; DataType := ftString; Size := 70; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'ATI_CODEMP'; DataType := ftString; Size := 03; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'AUTOINCREM'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'ATI_TABPRE'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'ATI_CODVEL'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'ATI_CODGAT'; DataType := ftString; Size := 03; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'ATI_CODJON'; DataType := ftString; Size := 02; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'ATI_PERCOM'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'ATI_RENPRE'; DataType := ftFloat; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'ATI_ULTALT'; DataType := ftDateTime; Required := False;
  End;
end;

{ TImpFornecedor }

function TImpFornecedor.fMarcarImportado: Boolean;
  Var
    qryTemp: TUniQuery;

  procedure pInicializarQry; begin
    qryTemp.Close();
    qryTemp.SQL.Clear();
    qryTemp.SQL.Text := SQL_UPDATE_IMPFOR;
  end;
begin
  Result := True;

  Try
    qryTemp := fCriaQuery(nil);

    Try
      pInicializarQry();

      qryTemp.ParamByName('NOMFOR').AsString := Self.FieldByName('IMP_NOMFOR').AsString;
      qryTemp.ParamByName('C_G_C_').AsString := Self.FieldByName('IMP_C_G_C_').AsString;
      qryTemp.ParamByName('CODIMP').AsString := Self.FieldByName('IMP_CODIMP').AsString;
      qryTemp.ParamByName('DTAIMP').AsDate := VS_Date;

      qryTemp.ExecSQL();
    Finally
      FreeAndNil(qryTemp);
    End;
  Except
    On E : Exception Do Begin
      Result := False;
		  pMensagensErro(E.Message, '[TImpFornecedor.fMarcarImportado]');

      FMemoLog.Lines.Add(#13#10 + 'ERRO: ' + E.Message + #13#10);
    End;
  End;
end;

function TImpFornecedor.fSalvarRegistros: Boolean;
  Var
    qryTemp: TUniQuery;
    strC_G_C_ : String;
  procedure pInicializarQry; begin
    qryTemp.Close();
    qryTemp.SQL.Clear();

    If (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
      qryTemp.SQL.Text := SQL_INSERT_CADFOR
    Else If (Self.FieldByName('IMP_TIPOPE').AsString = 'U') Then
      qryTemp.SQL.Text := SQL_UPDATE_CADFOR
    Else If (Self.FieldByName('IMP_TIPOPE').AsString = 'D') Then
      qryTemp.SQL.Text := SQL_DELETE_CADFOR;
  end;

begin
  Result := True;

  Try
    qryTemp := fCriaQuery(nil);

    Try
      Self.First();
      pInicializarPrgDetalhe();

      While (Not Self.Eof) Do Begin
        pInicializarQry();

        If (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
        Begin
          Self.Edit;

          Repeat
            Self.FieldByName('IMP_CODFOR').AsString := fAtualizaProCod('CADFOR', 'FOR_CODFOR');
          Until (fEmptyStr(fCampoTabela('FOR_CODFOR', 'CADFOR', ['FOR_CODFOR'], [Self.FieldByName('IMP_CODFOR').AsString])));

          qryTemp.ParamByName('AUTINC').AsString   := fRetAutoIncrem('CADFOR', VS_strCodEmp);

          qryTemp.ParamByName('080000').Clear();
        End;

        If (Self.FieldByName('IMP_TIPOPE').AsString <> 'D') Then Begin
          qryTemp.ParamByName('CODCID').AsString   := fCampoTabela('CID_CODCID', 'CADCID', ['CID_CODCOR'],
                                                                   [Self.FieldByName('IMP_CODCOR').AsString]);
          If (fEmptyStr(qryTemp.ParamByName('CODCID').AsString)) Then
            qryTemp.ParamByName('CODCID').AsString := fCampoTabela('CID_CODCID', 'CADCID', ['CID_C_E_P_'],
                                                                   [Self.FieldByName('IMP_C_E_P_').AsString]);

          qryTemp.ParamByName('CODFOR').AsString   := Self.FieldByName('IMP_CODFOR').AsString;
          qryTemp.ParamByName('NOMFOR').AsString   := Self.FieldByName('IMP_NOMFOR').AsString;
          qryTemp.ParamByName('NOMFAN').AsString   := Self.FieldByName('IMP_NOMFAN').AsString;
          qryTemp.ParamByName('ENDERE').AsString   := Self.FieldByName('IMP_ENDERE').AsString;
          qryTemp.ParamByName('BAIRRO').AsString   := Self.FieldByName('IMP_BAIRRO').AsString;
          qryTemp.ParamByName('C_E_P_').AsString   := Self.FieldByName('IMP_C_E_P_').AsString;

          strC_G_C_ := Self.FieldByName('IMP_C_G_C_').AsString;
          If fValidaCnpjCpf('1', strC_G_C_ , False, False, False) Then
            qryTemp.ParamByName('CGCCPF').AsString   := '1'
          Else
          begin
            strC_G_C_ := Copy(strC_G_C_, Length(strC_G_C_) - 10, Length(strC_G_C_));
            If fValidaCnpjCpf('2',strC_G_C_ , False, False, False) Then
              qryTemp.ParamByName('CGCCPF').AsString   := '2'
            Else
            begin
              fMensagem('ATENÇÃO', Self.FieldByName('IMP_C_G_C_').AsString + ' não é um Número de CNPJ/CPF válido!', ['&Ok']);
              qryTemp.ParamByName('CGCCPF').Clear;
            end;
          end;

          qryTemp.ParamByName('C_G_C_').AsString   := strC_G_C_;
          qryTemp.ParamByName('CONTAT').AsString   := Self.FieldByName('IMP_CONTAT').AsString;
          qryTemp.ParamByName('FONE01').AsString   := Self.FieldByName('IMP_FONE01').AsString;
          qryTemp.ParamByName('FONE02').AsString   := Self.FieldByName('IMP_FONE02').AsString;
          qryTemp.ParamByName('EMAIL_').AsString   := Self.FieldByName('IMP_EMAIL_').AsString;
          qryTemp.ParamByName('EMAIL2').AsString   := Self.FieldByName('IMP_EMAIL2').AsString;
          qryTemp.ParamByName('EMAIL3').AsString   := Self.FieldByName('IMP_EMAIL3').AsString;
          qryTemp.ParamByName('HOMEPA').AsString   := Self.FieldByName('IMP_HOMEPA').AsString;
          qryTemp.ParamByName('CNDPAG').AsString   := Self.FieldByName('IMP_CNDPAG').AsString;
          qryTemp.ParamByName('CODEMP').AsString   := Self.FieldByName('IMP_CODEMP').AsString;
          qryTemp.ParamByName('MATREV').AsString   := Self.FieldByName('IMP_MATREV').AsString;
          qryTemp.ParamByName('OBSERV').AsString   := Self.FieldByName('IMP_OBSERV').AsString;
          qryTemp.ParamByName('CODVEL').AsString   := Self.FieldByName('IMP_CODVEL').AsString;
          qryTemp.ParamByName('STATUS').AsString   := 'A';
          qryTemp.ParamByName('ENDNUM').AsString   := Self.FieldByName('IMP_ENDNUM').AsString;
          qryTemp.ParamByName('ENDCOM').AsString   := Self.FieldByName('IMP_ENDCOM').AsString;
          qryTemp.ParamByName('SIMPAU').AsString   := Self.FieldByName('IMP_SIMPAU').AsString;
          qryTemp.ParamByName('NUMCEL').AsString   := Self.FieldByName('IMP_NUMCEL').AsString;
          qryTemp.ParamByName('VLRED2').AsString   := Self.FieldByName('IMP_VLRED2').AsString;
          qryTemp.ParamByName('EMAPED').AsString   := Self.FieldByName('IMP_EMAPED').AsString;
          qryTemp.ParamByName('ACOOBJ').AsString   := Self.FieldByName('IMP_ACOOBJ').AsString;
          qryTemp.ParamByName('ZONFRA').AsString   := Self.FieldByName('IMP_ZONFRA').AsString;
          qryTemp.ParamByName('OBSCMP').AsString   := Self.FieldByName('IMP_OBSCMP').AsString;
          qryTemp.ParamByName('SUFRAM').AsString   := Self.FieldByName('IMP_SUFRAM').AsString;
          qryTemp.ParamByName('DIAENT').AsInteger  := Self.FieldByName('IMP_DIAENT').AsInteger;
          qryTemp.ParamByName('CARPAG').AsInteger  := Self.FieldByName('IMP_CARPAG').AsInteger;
          qryTemp.ParamByName('DESVIS').AsFloat    := Self.FieldByName('IMP_DESVIS').AsFloat;

          If (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            qryTemp.ParamByName('DTACAD').AsDateTime := fNow();

          qryTemp.ParamByName('ULTALT').AsDateTime := fNow();
          qryTemp.ParamByName('DTAALT').AsDateTime := fNow();

          If (fEmptyStr(Self.FieldByName('IMP_ATIAUT').AsString)) Then
            qryTemp.ParamByName('CODATI').Clear()
          Else
            qryTemp.ParamByName('CODATI').AsString   := Self.FieldByName('IMP_ATIAUT').AsString;

          If (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then Begin
            qryTemp.ParamByName('QTDETI').AsFloat := 0;
            qryTemp.ParamByName('PERCOM').AsFloat := 0;
            qryTemp.ParamByName('MINORC').AsFloat := 0;
            qryTemp.ParamByName('PERFCX').AsFloat := 0;
          End;

          qryTemp.ExecSQL();

          fMarcarImportado();

          Self.Edit();
          Self.FieldByName('IMP_CODFOR').AsString := qryTemp.ParamByName('CODFOR').AsString;
          Self.FieldByName('IMP_CODAUT').AsString := qryTemp.ParamByName('CODFOR').AsString;
          Self.Post();

          If (Self.FieldByName('IMP_TIPOPE').AsString = 'I') Then
            FMemoLog.Lines.Add('FORNECEDOR ADICIONADO AO BD: CÓD. ANT. : ' +
              Self.FieldByName('IMP_CODVEL').AsString +
              ' | CÓD.: ' + Self.FieldByName('IMP_CODAUT').AsString)
          Else
            FMemoLog.Lines.Add('FORNECEDOR ALTERADO NO BD: CÓD. ANT. : ' +
              Self.FieldByName('IMP_CODVEL').AsString +
              ' | CÓD.: ' + Self.FieldByName('IMP_CODAUT').AsString);
        End Else If (Not Self.FIgnExcFor) Then Begin
          //FAZER DELETE DO REGISTRO
          Try
            qryTemp.ParamByName('C_G_C_').AsString := Self.FieldByName('IMP_C_G_C_').AsString;
            qryTemp.ParamByName('NOMFOR').AsString := Self.FieldByName('IMP_NOMFOR').AsString;

            qryTemp.ExecSQL();

            fMarcarImportado();

            FMemoExclusao.Lines.Add('FORNECEDOR REMOVIDO DO BD: CÓD. ANT. : ' +
              Self.FieldByName('IMP_CODVEL').AsString +
              ' | CÓD.: ' + Self.FieldByName('IMP_CODAUT').AsString);
          Except
            FMemoExclusao.Lines.Add('FORNECEDOR REMOVIDO DO BD: CÓD. ANT. : ' +
              Self.FieldByName('IMP_CODVEL').AsString +
              ' | CÓD.: ' + Self.FieldByName('IMP_CODAUT').AsString +
              '. VERIFIQUE SE O MESMO POSSUI MOVIMENTAÇÃO!');
          End;
        End;

        pIncrementarPositionProgressos();
        Self.Next();
      End;
    Finally
      FreeAndNil(qryTemp);
    End;
  Except
    On E : Exception Do Begin
      Result := False;
		  pMensagensErro(E.Message, '[TImpFornecedor.fSalvarRegistros]');

      FMemoLog.Lines.Add(#13#10 + 'ERRO: ' + E.Message + #13#10);
    End;
  End;
end;

procedure TImpFornecedor.pAdicionar(params: TRecParamAdicionar);
  Var
    strTemp: String;
begin
  If (fEmptyStr(params.recFornecedor.IMP_NOMFOR)) Then Exit;

  strTemp := fCampoTabela('FOR_CODFOR', 'CADFOR', ['FOR_CODVEL', 'FOR_NOMFOR'],
                          [params.recFornecedor.IMP_C_G_C_, params.recFornecedor.IMP_NOMFOR]);

  If (fEmptyStr(strTemp)) Then Begin
    strTemp := fCampoTabela('FOR_CODFOR', 'CADFOR', ['FOR_C_G_C_', 'FOR_NOMFOR'],
                            [params.recFornecedor.IMP_C_G_C_, params.recFornecedor.IMP_NOMFOR]);
  End;

  Self.Append();
  Self.FieldByName('ID').AsInteger := params.intID;
  Self.FieldByName('IMP_CODFOR').AsString   := strTemp;
  Self.FieldByName('IMP_CODAUT').AsString   := strTemp;
  Self.FieldByName('IMP_CODVEL').AsString   := params.recFornecedor.IMP_C_G_C_;
  Self.FieldByName('IMP_VLRED2').AsString   := params.recFornecedor.IMP_VLRED2;
  Self.FieldByName('IMP_SIMPAU').AsString   := params.recFornecedor.IMP_SIMPAU;
  Self.FieldByName('IMP_ACOOBJ').AsString   := params.recFornecedor.IMP_ACOOBJ;
  Self.FieldByName('IMP_MATREV').AsString   := params.recFornecedor.IMP_MATREV;
  Self.FieldByName('IMP_ZONFRA').AsString   := params.recFornecedor.IMP_ZONFRA;
  Self.FieldByName('IMP_CODEMP').AsString   := VS_strCodEmp;
  Self.FieldByName('IMP_ATIAUT').AsString   := '';
  Self.FieldByName('IMP_CODATI').AsString   := params.recFornecedor.IMP_CODATI;
  Self.FieldByName('IMP_OBSERV').AsString   := params.recFornecedor.IMP_OBSERV;
  Self.FieldByName('IMP_OBSCMP').AsString   := params.recFornecedor.IMP_OBSCMP;
  Self.FieldByName('IMP_ENDNUM').AsString   := params.recFornecedor.IMP_ENDNUM;
  Self.FieldByName('IMP_NUMCEL').AsString   := params.recFornecedor.IMP_NUMCEL;
  Self.FieldByName('IMP_FONE01').AsString   := params.recFornecedor.IMP_FONE01;
  Self.FieldByName('IMP_FONE02').AsString   := params.recFornecedor.IMP_FONE02;
  Self.FieldByName('IMP_EMAPED').AsString   := params.recFornecedor.IMP_EMAPED;
  Self.FieldByName('IMP_EMAIL_').AsString   := params.recFornecedor.IMP_EMAIL_;
  Self.FieldByName('IMP_C_G_C_').AsString   := params.recFornecedor.IMP_C_G_C_;
  Self.FieldByName('IMP_SUFRAM').AsString   := params.recFornecedor.IMP_SUFRAM;
  Self.FieldByName('IMP_CONTAT').AsString   := params.recFornecedor.IMP_CONTAT;
  Self.FieldByName('IMP_CNDPAG').AsString   := params.recFornecedor.IMP_CNDPAG;
  Self.FieldByName('IMP_EMAIL3').AsString   := params.recFornecedor.IMP_EMAIL3;
  Self.FieldByName('IMP_EMAIL2').AsString   := params.recFornecedor.IMP_EMAIL2;
  Self.FieldByName('IMP_ENDCOM').AsString   := params.recFornecedor.IMP_ENDCOM;
  Self.FieldByName('IMP_HOMEPA').AsString   := params.recFornecedor.IMP_HOMEPA;
  Self.FieldByName('IMP_NOMFOR').AsString   := params.recFornecedor.IMP_NOMFOR;
  Self.FieldByName('IMP_BAIRRO').AsString   := params.recFornecedor.IMP_BAIRRO;
  Self.FieldByName('IMP_ENDERE').AsString   := params.recFornecedor.IMP_ENDERE;
  Self.FieldByName('IMP_NOMFAN').AsString   := params.recFornecedor.IMP_NOMFAN;
  Self.FieldByName('IMP_DESATI').AsString   := params.recFornecedor.IMP_DESATI;
  Self.FieldByName('IMP_C_E_P_').AsString   := params.recFornecedor.IMP_C_E_P_;
  Self.FieldByName('IMP_CODCOR').AsInteger  := params.recFornecedor.IMP_CODCOR;
  Self.FieldByName('IMP_DIAENT').AsInteger  := params.recFornecedor.IMP_DIAENT;
  Self.FieldByName('IMP_CARPAG').AsInteger  := params.recFornecedor.IMP_CARPAG;
  Self.FieldByName('IMP_CODIMP').AsInteger  := params.recFornecedor.IMP_CODIMP;
  Self.FieldByName('IMP_DESVIS').AsFloat    := params.recFornecedor.IMP_DESVIS;
  Self.FieldByName('IMP_DTAIMP').AsDateTime := params.recFornecedor.IMP_DTAIMP;
  Self.FieldByName('IMP_TIPOPE').AsString   := params.recFornecedor.IMP_TIPOPE;
  Self.Post();

  FMemoLog.Lines.Add('FORNECEDOR ADICIONADO NO DATASET: CPF/CNPJ: ' +
    params.recFornecedor.IMP_C_G_C_ + ' | CÓDIGO AUTCOM: ' + strTemp);
end;

procedure TImpFornecedor.pCriarCampos;
begin
  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'ID'; DataType := ftInteger; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_CODIMP'; DataType := ftInteger; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_CODFOR'; DataType := ftString; Size := 08; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_CODAUT'; DataType := ftString; Size := 08; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_CODEMP'; DataType := ftString; Size := 03; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_CODVEL'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_VLRED2'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_SIMPAU'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_ACOOBJ'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_MATREV'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_ZONFRA'; DataType := ftString; Size := 01; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_CODATI'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_ATIAUT'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_OBSERV'; DataType := ftString; Size := 5000; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_OBSCMP'; DataType := ftString; Size := 5000; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_ENDNUM'; DataType := ftString; Size := 10; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_NUMCEL'; DataType := ftString; Size := 15; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_FONE01'; DataType := ftString; Size := 15; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_FONE02'; DataType := ftString; Size := 15; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_EMAPED'; DataType := ftString; Size := 150; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_EMAIL_'; DataType := ftString; Size := 150; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_C_G_C_'; DataType := ftString; Size := 18; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_SUFRAM'; DataType := ftString; Size := 20; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_CONTAT'; DataType := ftString; Size := 25; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_CNDPAG'; DataType := ftString; Size := 38; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_EMAIL3'; DataType := ftString; Size := 50; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_EMAIL2'; DataType := ftString; Size := 50; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_ENDCOM'; DataType := ftString; Size := 50; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_HOMEPA'; DataType := ftString; Size := 50; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_NOMFOR'; DataType := ftString; Size := 60; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_BAIRRO'; DataType := ftString; Size := 60; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_ENDERE'; DataType := ftString; Size := 60; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_NOMFAN'; DataType := ftString; Size := 60; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_DESATI'; DataType := ftString; Size := 70; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_C_E_P_'; DataType := ftString; Size := 09; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_CODCOR'; DataType := ftInteger; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_DIAENT'; DataType := ftInteger; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_CARPAG'; DataType := ftInteger; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_DESVIS'; DataType := ftInteger; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_DTAIMP'; DataType := ftDateTime; Required := False;
  End;

  With Self.FieldDefs.AddFieldDef Do Begin
    Name := 'IMP_TIPOPE'; DataType := ftString; Size := 01; Required := False;
  End;
end;

end.
