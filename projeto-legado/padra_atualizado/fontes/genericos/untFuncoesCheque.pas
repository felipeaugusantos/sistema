{***************************************}
{* UNIT CRIADA PARA GRAVAÇÃO DO LOGCHQ *}
{* PARA NÃO ADICIONAR A UNIT CADCHQ AO *}
{* PROJETO DA LIBTRANSCODIGOS, ISSO    *}
{* ACARRETARIA EM TER QUE ADICIONAR    *}
{* VÁRIAS OUTRAS UNITS QUE NÃO SERIÃO  *}
{* UTILIZADAS NESTE PROJETO.           *}
{************************************JU*}

unit untFuncoesCheque; remover ass: alexandre

interface
uses
  SysUtils, Classes, DB,   Uni, Variants,
  frxClass, frxDBSet, frxDMPExport, StrUtils;

{*******************************************}
{* REGISTRO UTILIZADO PARA GRAVAR O LOGCHQ *}
{****************************************JU*}
Type
  TEstruturaLogChq = Record
    strCodBco : String;
    strNumAge : String;
    strConCor : String;
    strNumChq : String;
    strCodCli : String;
    strNomEmi : String;
    strEndere : String;
    strTelEmi : String;
    strCGCCPF : String;
    strC_G_C_ : String;
    dtaDtaCad : TDateTime;
    dtaDtaVen : TDateTime;
    fltValChq : Double;
    strHist01 : String;
    strHist02 : String;
    strCtaDep : String;
    dtaDtaDep : TDateTime;
    strDocDep : String;
    strCodPor : String;
    strCodCta : String;
    dtaDtaDev : TDateTime;
    strMotDev : String;
    dtaDtaRdp : TDateTime;
    strForRep : String;
    strObsRep : String;
    dtaDtaRep : TDateTime;
    intResCai : Integer;
    strCodEmp : String;
    strNumNot : String;
    dtaDtaCus : TDateTime;
    strPorCus : String;
    strDocume : String;
    strIncCtr : String;
    strHistor : String;
    strDocCus : String;
    strLotCus : String;
    strPorDeb : String;
    strCtaDeb : String;
    strMotDv2 : String;
    dtaDtaDp2 : TDateTime;
    dtaDtaDv2 : TDateTime;
    strSeqCom : String;
    dtaDtaTra : TDateTime;
    intSeqCon : Integer;
    strEmpRcx : String;
    intDevDef : Integer;
    strCodVen : String;
    intSeqTrf : Integer;
    strDupDev : String;
    strDupDep : String;
    strCtdPsv : String;
    strCtdBsv : String;
    strPrdBsv : String;
    strCdcTsv : String;
    strCdpRsv : String;
    strTelChe : String;
    strTelNum : String;
    strSeqDep : String;
    strCodOpe : String;
    strCodCmc : String;
    strHisLog : String;
    strNomTab : String;
End;

Type TRegistroLogChq = Array of TEstruturaLogChq;

function fGravaLogChq(arrLogChq: TRegistroLogChq): Boolean;

function fInsereLogChqArr(Var arrLogChq : TRegistroLogChq;
                          strCodBco : String;
                          strNumAge : String;
                          strConCor : String;
                          strNumChq : String;
                          strCodCli : String;
                          strNomEmi : String;
                          strEndere : String;
                          strTelEmi : String;
                          strCGCCPF : String;
                          strC_G_C_ : String;
                          dtaDtaCad : TDateTime;
                          dtaDtaVen : TDateTime;
                          fltValChq : Double;
                          strHist01 : String;
                          strHist02 : String;
                          strCtaDep : String;
                          dtaDtaDep : TDateTime;
                          strDocDep : String;
                          strCodPor : String;
                          strCodCta : String;
                          dtaDtaDev : TDateTime;
                          strMotDev : String;
                          dtaDtaRdp : TDateTime;
                          strForRep : String;
                          strObsRep : String;
                          dtaDtaRep : TDateTime;
                          intResCai : Integer;
                          strCodEmp : String;
                          strNumNot : String;
                          dtaDtaCus : TDateTime;
                          strPorCus : String;
                          strDocume : String;
                          strIncCtr : String;
                          strHistor : String;
                          strDocCus : String;
                          strLotCus : String;
                          strPorDeb : String;
                          strCtaDeb : String;
                          strMotDv2 : String;
                          dtaDtaDp2 : TDateTime;
                          dtaDtaDv2 : TDateTime;
                          strSeqCom : String;
                          dtaDtaTra : TDateTime;
                          intSeqCon : Integer;
                          strEmpRcx : String;
                          strHisLog : String;
                          strNomTab : String = 'CADCHQ';
                          intDevDef : Integer = 0;
                          strCodVen : String = '';
                          intSeqTrf : Integer = 0;
                          strDupDev : String = '';
                          strDupDep : String = '';
                          strCtdPsv : String = '';
                          strCtdBsv : String = '';
                          strPrdBsv : String = '';
                          strCdcTsv : String = '';
                          strCdpRsv : String = '';
                          strTelChe : String = '';
                          strTelNum : String = '';
                          strSeqDep : String = '';
                          strCodOpe : String = '';
                          strCodCmc : String = ''): Boolean;

implementation

uses untFuncoesSimples;

function fGravaLogChq(arrLogChq: TRegistroLogChq): Boolean;
  Var
    intIndex : Integer;
    strSQL   : String;
    qryGenChq: TUniQuery;
begin

  If Length(arrLogChq) = 0 Then
  Begin
    Result := True;
    Exit;
  End;

  qryGenChq := fCriaQuery;

  Result := False;

  For intIndex := 0 To Length(arrLogChq)-1 Do
  Begin
    strSQL := '';
    strSQL := strSQL + 'INSERT INTO ';
    strSQL := strSQL + '  LOGCHQ ';
    strSQL := strSQL + '( ';
    strSQL := strSQL + '  CHQ_CODBCO, ';
    strSQL := strSQL + '  CHQ_NUMAGE, ';
    strSQL := strSQL + '  CHQ_CONCOR, ';
    strSQL := strSQL + '  CHQ_NUMCHQ, ';
    strSQL := strSQL + '  CHQ_CODCLI, ';
    strSQL := strSQL + '  CHQ_NOMEMI, ';
    strSQL := strSQL + '  CHQ_ENDERE, ';
    strSQL := strSQL + '  CHQ_TELEMI, ';
    strSQL := strSQL + '  CHQ_CGCCPF, ';
    strSQL := strSQL + '  CHQ_C_G_C_, ';

    If arrLogChq[intIndex].dtaDtaCad > 0 Then
      strSQL := strSQL + '  CHQ_DTACAD, ';

    If arrLogChq[intIndex].dtaDtaVen > 0 Then
      strSQL := strSQL + '  CHQ_DTAVEN, ';

    strSQL := strSQL + '  CHQ_VALCHQ, ';
    strSQL := strSQL + '  CHQ_HIST01, ';
    strSQL := strSQL + '  CHQ_HIST02, ';
    strSQL := strSQL + '  CHQ_CTADEP, ';

    If arrLogChq[intIndex].dtaDtaDep > 0 Then
      strSQL := strSQL + '  CHQ_DTADEP, ';

    strSQL := strSQL + '  CHQ_DOCDEP, ';
    strSQL := strSQL + '  CHQ_CODPOR, ';
    strSQL := strSQL + '  CHQ_CODCTA, ';

    If arrLogChq[intIndex].dtaDtaDev > 0 Then
      strSQL := strSQL + '  CHQ_DTADEV, ';

    strSQL := strSQL + '  CHQ_MOTDEV, ';

    If arrLogChq[intIndex].dtaDtaRdp > 0 Then
      strSQL := strSQL + '  CHQ_DTARDP, ';

    strSQL := strSQL + '  CHQ_FORREP, ';
    strSQL := strSQL + '  CHQ_OBSREP, ';

    If arrLogChq[intIndex].dtaDtaRep > 0 Then
      strSQL := strSQL + '  CHQ_DTAREP, ';

    strSQL := strSQL + '  CHQ_RESCAI, ';
    strSQL := strSQL + '  CHQ_CODEMP, ';
    strSQL := strSQL + '  AUTOINCREM, ';
    strSQL := strSQL + '  CHQ_NUMNOT, ';

    If arrLogChq[intIndex].dtaDtaCus > 0 Then
      strSQL := strSQL + '  CHQ_DTACUS, ';

    strSQL := strSQL + '  CHQ_PORCUS, ';
    strSQL := strSQL + '  CHQ_DOCUME, ';
    strSQL := strSQL + '  CHQ_INCCTR, ';
    strSQL := strSQL + '  CHQ_HISTOR, ';
    strSQL := strSQL + '  CHQ_DOCCUS, ';
    strSQL := strSQL + '  CHQ_LOTCUS, ';
    strSQL := strSQL + '  CHQ_PORDEB, ';
    strSQL := strSQL + '  CHQ_CTADEB, ';
    strSQL := strSQL + '  CHQ_MOTDV2, ';

    If arrLogChq[intIndex].dtaDtaDp2 > 0 Then
      strSQL := strSQL + '  CHQ_DTADP2, ';

    If arrLogChq[intIndex].dtaDtaDv2 > 0 Then
      strSQL := strSQL + '  CHQ_DTADV2, ';

    strSQL := strSQL + '  CHQ_SEQCOM, ';

    If arrLogChq[intIndex].dtaDtaTra > 0 Then
      strSQL := strSQL + '  CHQ_DTATRA, ';

    strSQL := strSQL + '  CHQ_SEQCON, ';
    strSQL := strSQL + '  CHQ_EMPRCX, ';
    strSQL := strSQL + '  CHQ_DEVDEF, ';
    strSQL := strSQL + '  CHQ_CODVEN, ';
    strSQL := strSQL + '  CHQ_SEQTRF, ';
    strSQL := strSQL + '  CHQ_DUPDEV, ';
    strSQL := strSQL + '  CHQ_DUPDEP, ';
    strSQL := strSQL + '  CHQ_CTDPSV, ';
    strSQL := strSQL + '  CHQ_CTDBSV, ';
    strSQL := strSQL + '  CHQ_PRDBSV, ';
    strSQL := strSQL + '  CHQ_CDCTSV, ';
    strSQL := strSQL + '  CHQ_CDPRSV, ';
    strSQL := strSQL + '  CHQ_TELCHE, ';
    strSQL := strSQL + '  CHQ_TELNUM, ';
    strSQL := strSQL + '  CHQ_SEQDEP, ';
    strSQL := strSQL + '  CHQ_CODOPE, ';
    strSQL := strSQL + '  CHQ_CODCMC, ';
    strSQL := strSQL + '  CHQ_DTALOG, ';
    strSQL := strSQL + '  CHQ_HORLOG, ';
    strSQL := strSQL + '  CHQ_OPELOG, ';
    strSQL := strSQL + '  CHQ_HISLOG, ';
    strSQL := strSQL + '  CHQ_NOMTAB) ';
    strSQL := strSQL + 'VALUES ( ';
    strSQL := strSQL + '  :CODBCO, ';
    strSQL := strSQL + '  :NUMAGE, ';
    strSQL := strSQL + '  :CONCOR, ';
    strSQL := strSQL + '  :NUMCHQ, ';
    strSQL := strSQL + '  :CODCLI, ';
    strSQL := strSQL + '  :NOMEMI, ';
    strSQL := strSQL + '  :ENDERE, ';
    strSQL := strSQL + '  :TELEMI, ';
    strSQL := strSQL + '  :CGCCPF, ';
    strSQL := strSQL + '  :C_G_C_, ';

    If arrLogChq[intIndex].dtaDtaCad > 0 Then
      strSQL := strSQL + '  :DTACAD, ';

    If arrLogChq[intIndex].dtaDtaVen > 0 Then
      strSQL := strSQL + '  :DTAVEN, ';

    strSQL := strSQL + '  :VALCHQ, ';
    strSQL := strSQL + '  :HIST01, ';
    strSQL := strSQL + '  :HIST02, ';
    strSQL := strSQL + '  :CTADEP, ';

    If arrLogChq[intIndex].dtaDtaDep > 0 Then
      strSQL := strSQL + '  :DTADEP, ';

    strSQL := strSQL + '  :DOCDEP, ';
    strSQL := strSQL + '  :CODPOR, ';
    strSQL := strSQL + '  :CODCTA, ';

    If arrLogChq[intIndex].dtaDtaDev > 0 Then
      strSQL := strSQL + '  :DTADEV, ';

    strSQL := strSQL + '  :MOTDEV, ';

    If arrLogChq[intIndex].dtaDtaRdp > 0 Then
      strSQL := strSQL + '  :DTARDP, ';

    strSQL := strSQL + '  :FORREP, ';
    strSQL := strSQL + '  :OBSREP, ';

    If arrLogChq[intIndex].dtaDtaRep > 0 Then
      strSQL := strSQL + '  :DTAREP, ';

    strSQL := strSQL + '  :RESCAI, ';
    strSQL := strSQL + '  :CODEMP, ';
    strSQL := strSQL + '  :AUTINC, ';
    strSQL := strSQL + '  :NUMNOT, ';

    If arrLogChq[intIndex].dtaDtaCus > 0 Then
      strSQL := strSQL + '  :DTACUS, ';

    strSQL := strSQL + '  :PORCUS, ';
    strSQL := strSQL + '  :DOCUME, ';
    strSQL := strSQL + '  :INCCTR, ';
    strSQL := strSQL + '  :HISTOR, ';
    strSQL := strSQL + '  :DOCCUS, ';
    strSQL := strSQL + '  :LOTCUS, ';
    strSQL := strSQL + '  :PORDEB, ';
    strSQL := strSQL + '  :CTADEB, ';
    strSQL := strSQL + '  :MOTDV2, ';

    If arrLogChq[intIndex].dtaDtaDp2 > 0 Then
      strSQL := strSQL + '  :DTADP2, ';

    If arrLogChq[intIndex].dtaDtaDv2 > 0 Then
      strSQL := strSQL + '  :DTADV2, ';

    strSQL := strSQL + '  :SEQCOM, ';

    If arrLogChq[intIndex].dtaDtaTra > 0 Then
      strSQL := strSQL + '  :DTATRA, ';

    strSQL := strSQL + '  :SEQCON, ';
    strSQL := strSQL + '  :EMPRCX, ';
    strSQL := strSQL + '  :DEVDEF, ';
    strSQL := strSQL + '  :CODVEN, ';
    strSQL := strSQL + '  :SEQTRF, ';
    strSQL := strSQL + '  :DUPDEV, ';
    strSQL := strSQL + '  :DUPDEP, ';
    strSQL := strSQL + '  :CTDPSV, ';
    strSQL := strSQL + '  :CTDBSV, ';
    strSQL := strSQL + '  :PRDBSV, ';
    strSQL := strSQL + '  :CDCTSV, ';
    strSQL := strSQL + '  :CDPRSV, ';
    strSQL := strSQL + '  :TELCHE, ';
    strSQL := strSQL + '  :TELNUM, ';
    strSQL := strSQL + '  :SEQDEP, ';
    strSQL := strSQL + '  :CODOPE, ';
    strSQL := strSQL + '  :CODCMC, ';
    strSQL := strSQL + '  :DTALOG, ';
    strSQL := strSQL + '  :HORLOG, ';
    strSQL := strSQL + '  :OPELOG, ';
    strSQL := strSQL + '  :HISLOG, ';
    strSQL := strSQL + '  :NOMTAB) ';

    Try
      With qryGenChq Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODBCO').AsString   := arrLogChq[intIndex].strCodBco;
        ParamByName('NUMAGE').AsString   := arrLogChq[intIndex].strNumAge;
        ParamByName('CONCOR').AsString   := arrLogChq[intIndex].strConCor;
        ParamByName('NUMCHQ').AsString   := arrLogChq[intIndex].strNumChq;
        ParamByName('CODCLI').AsString   := arrLogChq[intIndex].strCodCli;
        ParamByName('NOMEMI').AsString   := arrLogChq[intIndex].strNomEmi;
        ParamByName('ENDERE').AsString   := arrLogChq[intIndex].strEndere;
        ParamByName('TELEMI').AsString   := arrLogChq[intIndex].strTelEmi;
        ParamByName('CGCCPF').AsString   := arrLogChq[intIndex].strCGCCPF;
        ParamByName('C_G_C_').AsString   := arrLogChq[intIndex].strC_G_C_;

        If arrLogChq[intIndex].dtaDtaCad > 0 Then
          ParamByName('DTACAD').AsDateTime := arrLogChq[intIndex].dtaDtaCad;

        If arrLogChq[intIndex].dtaDtaVen > 0 Then
          ParamByName('DTAVEN').AsDateTime := arrLogChq[intIndex].dtaDtaVen;

        ParamByName('VALCHQ').AsFloat    := arrLogChq[intIndex].fltValChq;
        ParamByName('HIST01').AsString   := arrLogChq[intIndex].strHist01;
        ParamByName('HIST02').AsString   := arrLogChq[intIndex].strHist02;
        ParamByName('CTADEP').AsString   := arrLogChq[intIndex].strCtaDep;

        If arrLogChq[intIndex].dtaDtaDep > 0 Then
          ParamByName('DTADEP').AsDateTime := arrLogChq[intIndex].dtaDtaDep;

        ParamByName('DOCDEP').AsString   := arrLogChq[intIndex].strDocDep;
        ParamByName('CODPOR').AsString   := arrLogChq[intIndex].strCodPor;
        ParamByName('CODCTA').AsString   := arrLogChq[intIndex].strCodCta;

        If arrLogChq[intIndex].dtaDtaDev > 0 Then
          ParamByName('DTADEV').AsDateTime := arrLogChq[intIndex].dtaDtaDev;

        ParamByName('MOTDEV').AsString   := arrLogChq[intIndex].strMotDev;

        If arrLogChq[intIndex].dtaDtaRdp > 0 Then
          ParamByName('DTARDP').AsDateTime := arrLogChq[intIndex].dtaDtaRdp;

        ParamByName('FORREP').AsString   := arrLogChq[intIndex].strForRep;
        ParamByName('OBSREP').AsString   := arrLogChq[intIndex].strObsRep;

        If arrLogChq[intIndex].dtaDtaRep > 0 Then
          ParamByName('DTAREP').AsDateTime := arrLogChq[intIndex].dtaDtaRep;

        ParamByName('RESCAI').AsInteger  := arrLogChq[intIndex].intResCai;
        ParamByName('CODEMP').AsString   := arrLogChq[intIndex].strCodEmp;
        ParamByName('AUTINC').AsString   := fRetAutoIncrem('LOGCHQ', arrLogChq[intIndex].strCodEmp);
        ParamByName('NUMNOT').AsString   := arrLogChq[intIndex].strNumNot;

        If arrLogChq[intIndex].dtaDtaCus > 0 Then
          ParamByName('DTACUS').AsDateTime := arrLogChq[intIndex].dtaDtaCus;

        ParamByName('PORCUS').AsString   := arrLogChq[intIndex].strPorCus;
        ParamByName('DOCUME').AsString   := arrLogChq[intIndex].strDocume;
        ParamByName('INCCTR').AsString   := arrLogChq[intIndex].strIncCtr;
        ParamByName('HISTOR').AsString   := arrLogChq[intIndex].strHistor;
        ParamByName('DOCCUS').AsString   := arrLogChq[intIndex].strDocCus;
        ParamByName('LOTCUS').AsString   := arrLogChq[intIndex].strLotCus;
        ParamByName('PORDEB').AsString   := arrLogChq[intIndex].strPorDeb;
        ParamByName('CTADEB').AsString   := arrLogChq[intIndex].strCtaDeb;
        ParamByName('MOTDV2').AsString   := arrLogChq[intIndex].strMotDv2;

        If arrLogChq[intIndex].dtaDtaDp2 > 0 Then
          ParamByName('DTADP2').AsDateTime := arrLogChq[intIndex].dtaDtaDp2;

        If arrLogChq[intIndex].dtaDtaDv2 > 0 Then
          ParamByName('DTADV2').AsDateTime := arrLogChq[intIndex].dtaDtaDv2;

        ParamByName('SEQCOM').AsString   := arrLogChq[intIndex].strSeqCom;

        If arrLogChq[intIndex].dtaDtaTra > 0 Then
          ParamByName('DTATRA').AsDateTime := arrLogChq[intIndex].dtaDtaTra;

        ParamByName('SEQCON').AsInteger  := arrLogChq[intIndex].intSeqCon;
        ParamByName('EMPRCX').AsString   := arrLogChq[intIndex].strEmpRcx;
        ParamByName('DEVDEF').AsInteger  := arrLogChq[intIndex].intDevDef;
        ParamByName('CODVEN').AsString   := arrLogChq[intIndex].strCodVen;
        ParamByName('SEQTRF').AsInteger  := arrLogChq[intIndex].intSeqTrf;
        ParamByName('DUPDEV').AsString   := arrLogChq[intIndex].strDupDev;
        ParamByName('DUPDEP').AsString   := arrLogChq[intIndex].strDupDep;
        ParamByName('CTDPSV').AsString   := arrLogChq[intIndex].strCtdPsv;
        ParamByName('CTDBSV').AsString   := arrLogChq[intIndex].strCtdBsv;
        ParamByName('PRDBSV').AsString   := arrLogChq[intIndex].strPrdBsv;
        ParamByName('CDCTSV').AsString   := arrLogChq[intIndex].strCdcTsv;
        ParamByName('CDPRSV').AsString   := arrLogChq[intIndex].strCdpRsv;
        ParamByName('TELCHE').AsString   := arrLogChq[intIndex].strTelChe;
        ParamByName('TELNUM').AsString   := arrLogChq[intIndex].strTelNum;
        ParamByName('SEQDEP').AsString   := arrLogChq[intIndex].strSeqDep;
        ParamByName('CODOPE').AsString   := arrLogChq[intIndex].strCodOpe;
        ParamByName('CODCMC').AsString   := arrLogChq[intIndex].strCodCmc;
        ParamByName('DTALOG').AsDateTime := VS_Date;
        ParamByName('HORLOG').AsTime     := Time;
        ParamByName('OPELOG').AsString   := strLoginUsuarioLogado;
        ParamByName('HISLOG').AsString   := arrLogChq[intIndex].strHisLog;
        ParamByName('NOMTAB').AsString   := arrLogChq[intIndex].strNomTab;
        ExecSQL;
        Close;

        Result := True;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fGravaLogChq]');
        Break;
      End;
    End;
  End;

  FreeAndNil(qryGenChq);

end;

function fInsereLogChqArr(Var arrLogChq : TRegistroLogChq;
                          strCodBco : String;
                          strNumAge : String;
                          strConCor : String;
                          strNumChq : String;
                          strCodCli : String;
                          strNomEmi : String;
                          strEndere : String;
                          strTelEmi : String;
                          strCGCCPF : String;
                          strC_G_C_ : String;
                          dtaDtaCad : TDateTime;
                          dtaDtaVen : TDateTime;
                          fltValChq : Double;
                          strHist01 : String;
                          strHist02 : String;
                          strCtaDep : String;
                          dtaDtaDep : TDateTime;
                          strDocDep : String;
                          strCodPor : String;
                          strCodCta : String;
                          dtaDtaDev : TDateTime;
                          strMotDev : String;
                          dtaDtaRdp : TDateTime;
                          strForRep : String;
                          strObsRep : String;
                          dtaDtaRep : TDateTime;
                          intResCai : Integer;
                          strCodEmp : String;
                          strNumNot : String;
                          dtaDtaCus : TDateTime;
                          strPorCus : String;
                          strDocume : String;
                          strIncCtr : String;
                          strHistor : String;
                          strDocCus : String;
                          strLotCus : String;
                          strPorDeb : String;
                          strCtaDeb : String;
                          strMotDv2 : String;
                          dtaDtaDp2 : TDateTime;
                          dtaDtaDv2 : TDateTime;
                          strSeqCom : String;
                          dtaDtaTra : TDateTime;
                          intSeqCon : Integer;
                          strEmpRcx : String;
                          strHisLog : String;
                          strNomTab : String = 'CADCHQ';
                          intDevDef : Integer = 0;
                          strCodVen : String = '';
                          intSeqTrf : Integer = 0;
                          strDupDev : String = '';
                          strDupDep : String = '';
                          strCtdPsv : String = '';
                          strCtdBsv : String = '';
                          strPrdBsv : String = '';
                          strCdcTsv : String = '';
                          strCdpRsv : String = '';
                          strTelChe : String = '';
                          strTelNum : String = '';
                          strSeqDep : String = '';
                          strCodOpe : String = '';
                          strCodCmc : String = ''): Boolean;
begin

  Try
    Result := True;
    SetLength(arrLogChq, Length(arrLogChq)+1);

    arrLogChq[Length(arrLogChq)-1].strCodBco := strCodBco;
    arrLogChq[Length(arrLogChq)-1].strNumAge := strNumAge;
    arrLogChq[Length(arrLogChq)-1].strConCor := strConCor;
    arrLogChq[Length(arrLogChq)-1].strNumChq := strNumChq;
    arrLogChq[Length(arrLogChq)-1].strCodCli := strCodCli;
    arrLogChq[Length(arrLogChq)-1].strNomEmi := strNomEmi;
    arrLogChq[Length(arrLogChq)-1].strEndere := strEndere;
    arrLogChq[Length(arrLogChq)-1].strTelEmi := strTelEmi;
    arrLogChq[Length(arrLogChq)-1].strCGCCPF := strCGCCPF;
    arrLogChq[Length(arrLogChq)-1].strC_G_C_ := strC_G_C_;
    arrLogChq[Length(arrLogChq)-1].dtaDtaCad := dtaDtaCad;
    arrLogChq[Length(arrLogChq)-1].dtaDtaVen := dtaDtaVen;
    arrLogChq[Length(arrLogChq)-1].fltValChq := fltValChq;
    arrLogChq[Length(arrLogChq)-1].strHist01 := strHist01;
    arrLogChq[Length(arrLogChq)-1].strHist02 := strHist02;
    arrLogChq[Length(arrLogChq)-1].strCtaDep := strCtaDep;
    arrLogChq[Length(arrLogChq)-1].dtaDtaDep := dtaDtaDep;
    arrLogChq[Length(arrLogChq)-1].strDocDep := strDocDep;
    arrLogChq[Length(arrLogChq)-1].strCodPor := strCodPor;
    arrLogChq[Length(arrLogChq)-1].strCodCta := strCodCta;
    arrLogChq[Length(arrLogChq)-1].dtaDtaDev := dtaDtaDev;
    arrLogChq[Length(arrLogChq)-1].strMotDev := strMotDev;
    arrLogChq[Length(arrLogChq)-1].dtaDtaRdp := dtaDtaRdp;
    arrLogChq[Length(arrLogChq)-1].strForRep := strForRep;
    arrLogChq[Length(arrLogChq)-1].strObsRep := strObsRep;
    arrLogChq[Length(arrLogChq)-1].dtaDtaRep := dtaDtaRep;
    arrLogChq[Length(arrLogChq)-1].intResCai := intResCai;
    arrLogChq[Length(arrLogChq)-1].strCodEmp := strCodEmp;
    arrLogChq[Length(arrLogChq)-1].strNumNot := strNumNot;
    arrLogChq[Length(arrLogChq)-1].dtaDtaCus := dtaDtaCus;
    arrLogChq[Length(arrLogChq)-1].strPorCus := strPorCus;
    arrLogChq[Length(arrLogChq)-1].strDocume := strDocume;
    arrLogChq[Length(arrLogChq)-1].strIncCtr := strIncCtr;
    arrLogChq[Length(arrLogChq)-1].strHistor := strHistor;
    arrLogChq[Length(arrLogChq)-1].strDocCus := strDocCus;
    arrLogChq[Length(arrLogChq)-1].strLotCus := strLotCus;
    arrLogChq[Length(arrLogChq)-1].strPorDeb := strPorDeb;
    arrLogChq[Length(arrLogChq)-1].strCtaDeb := strCtaDeb;
    arrLogChq[Length(arrLogChq)-1].strMotDv2 := strMotDv2;
    arrLogChq[Length(arrLogChq)-1].dtaDtaDp2 := dtaDtaDp2;
    arrLogChq[Length(arrLogChq)-1].dtaDtaDv2 := dtaDtaDv2;
    arrLogChq[Length(arrLogChq)-1].strSeqCom := strSeqCom;
    arrLogChq[Length(arrLogChq)-1].dtaDtaTra := dtaDtaTra;
    arrLogChq[Length(arrLogChq)-1].intSeqCon := intSeqCon;
    arrLogChq[Length(arrLogChq)-1].strEmpRcx := strEmpRcx;
    arrLogChq[Length(arrLogChq)-1].intDevDef := intDevDef;
    arrLogChq[Length(arrLogChq)-1].strCodVen := strCodVen;
    arrLogChq[Length(arrLogChq)-1].intSeqTrf := intSeqTrf;
    arrLogChq[Length(arrLogChq)-1].strDupDev := strDupDev;
    arrLogChq[Length(arrLogChq)-1].strDupDep := strDupDep;
    arrLogChq[Length(arrLogChq)-1].strCtdPsv := strCtdPsv;
    arrLogChq[Length(arrLogChq)-1].strCtdBsv := strCtdBsv;
    arrLogChq[Length(arrLogChq)-1].strPrdBsv := strPrdBsv;
    arrLogChq[Length(arrLogChq)-1].strCdcTsv := strCdcTsv;
    arrLogChq[Length(arrLogChq)-1].strCdpRsv := strCdpRsv;
    arrLogChq[Length(arrLogChq)-1].strTelChe := strTelChe;
    arrLogChq[Length(arrLogChq)-1].strTelNum := strTelNum;
    arrLogChq[Length(arrLogChq)-1].strSeqDep := strSeqDep;
    arrLogChq[Length(arrLogChq)-1].strCodOpe := strCodOpe;
    arrLogChq[Length(arrLogChq)-1].strCodCmc := strCodCmc;
    arrLogChq[Length(arrLogChq)-1].strHisLog := strHisLog;
    arrLogChq[Length(arrLogChq)-1].strNomTab := strNomTab;
  Except
    Result := False;
  End;

end;


end.
