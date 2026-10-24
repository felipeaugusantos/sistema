
unit untModuloCadPgi;

interface

uses
  SysUtils, Classes, DB,   Uni, MemDS, DBAccess, frxclass;

type
  TfrmModuloCadPgi = class(TDataModule)
    qryCadPgi: TUniQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure pGravaCadPagGer(strNumDup,
                              strParcel,
                              strCodEmp,
                              strCodFor,
                              strCodBco,
                              strSerie_,
                              strCodBar,
                              strLinDig: String;
                              intSeqBai: Integer;
                              strFormaPagto: String;
                              strBcoFor: String;
                              ACarteiraBancoEnvio : String);

    procedure pGravaCadPgiGer(strNumDup,
                              strParcel,
                              strCodEmp,
                              strCodFor,
                              strCodBco,
                              strCodCta,
                              strCodBar,
                              strLinDig,
                              strProTes,
                              strSerie_,
                              strAutInc: String;
                              dtaDtaCad,
                              dtaDtaVen,
                              dtaDtaPag,
                              dtaDtaEnv: TDateTime;
                              fltValDup,
                              fltValJur,
                              fltValDes,
                              fltValPag: Double;
                              intSeqBai: Integer;
                              intQtdDia: Integer;
                              strForPgto: String;
                              strCodTED: String;
                              strQ_Guia: String;
                              strCodRec: String;
                              strCompet: String;
                              strBcoFor: String;
                              strTipoPagamento: String;
                              fltOutEnt: Double;
                              ASequencialSalario: String;
                              blnPGG: Boolean;
                              ACarteiraBancoEnvio : String);
 end;

var
  frmModuloCadPgi: TfrmModuloCadPgi;

implementation

uses untfuncoesSimples;

{$R *.dfm}

{***********************************}
{* APÓS A SELEÇÃO DE DUPLICATAS    *}
{* GRAVA OS DADOS NA TABELA CADREC *}
{********************************AF*}
procedure TfrmModuloCadPgi.DataModuleCreate(Sender: TObject);
  var
    intContador:integer;
begin
  {****************************************************}
  {*  DESABILITA OS BOTÕES SAVE, LOAD e EDIT DO FAST  *}
  {*11/05/2015**************************************RB*}

  For intContador := 0 To Self.ComponentCount -1 Do
  Begin

    If (Self.Components[intContador] Is TfrxReport) Then
    Begin
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons :=
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons - [pbSave, pbLoad, pbEdit];
    End;
  End;

end;

procedure TfrmModuloCadPgi.pGravaCadPagGer(strNumDup,
                                           strParcel,
                                           strCodEmp,
                                           strCodFor,
                                           strCodBco,
                                           strSerie_,
                                           strCodBar,
                                           strLinDig: String;
                                           intSeqBai: Integer;
                                           strFormaPagto: String;
                                           strBcoFor: String;
                                           ACarteiraBancoEnvio : String);
  Var
    strSQL: String;
    qryCadPagGer: TUniQuery;
Begin

  Try

    qryCadPagGer := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'UPDATE CADPAG ';
    strSQL := strSQL + ' SET   ';
    strSQL := strSQL + '  CTP_BCOENV = :CODBCO,     ';
    strSQL := strSQL + '  CTP_DTAENV = ' + fCurrentDate + ', ';
    strSQL := strSQL + '  CTP_DEPOSI = :DEPOSI ';

    if not fEmptyStr(ACarteiraBancoEnvio) then
      strSQL := strSQL + ', CTP_CARTEI = :CARTEIRA ';

    if not fEmptyStr(strBcoFor) then
    Begin
      strSQL := strSQL + ', CTP_BCOFOR = :BCOFOR ';
      strSQL := strSQL + ', CTP_FORPIX = NULL    ';
    End;

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND  ';
    strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND  ';
    strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND  ';
    strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND  ';
    strSQL := strSQL + '  CTP_SEQBAI = :SEQBAI AND  ';
    strSQL := strSQL + '  CTP_SERIE_ = :SERIE_ ';

    If Not fEmptyStr(strCodBar) then
      strSQL := strSQL + ' AND CTP_CODBAR = :CODBAR ';

    If Not fEmptyStr(strLinDig) Then
      strSQL := strSQL + ' AND CTP_LINDIG = :LINDIG ';

    With qryCadPagGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBCO').AsString  := strCodBco;
      ParamByName('NUMDUP').AsString  := strNumDup;
      ParamByName('PARCEL').AsString  := strParcel;
      ParamByName('CODEMP').AsString  := strCodEmp;
      ParamByName('CODFOR').AsString  := strCodFor;
      ParamByName('SEQBAI').AsInteger := intSeqBai;
      ParamByName('SERIE_').AsString  := strSerie_;

      If Not fEmptyStr(strCodBar) then
        ParamByName('CODBAR').AsString  := strCodBar;

      If strFormaPagto = 'DEP' Then
        ParamByName('DEPOSI').AsString  := 'S'
      Else
        ParamByName('DEPOSI').AsString  := 'N';

      if not fEmptyStr(strBcoFor) then
        ParamByName('BCOFOR').AsString := strBcoFor;

      If Not fEmptyStr(strLinDig) Then
        ParamByName('LINDIG').AsString  := strLinDig;

      if not fEmptyStr(ACarteiraBancoEnvio) then
        ParamByName('CARTEIRA').AsString  := ACarteiraBancoEnvio;

      ExecSQL;
      Close;
    End;

  Finally
    FreeAndNil(qryCadPagGer);
  End;

End;

{*************************************}
{* APÓS A SELEÇÃO DE DUPLICATAS      *}
{* GRAVA OS DADOS NA TABELA CADCBI   *}
{*************************************}
{* A TABELA QUE VAI SER GRAVADA DEVE *}
{* ESTAR ABERTA                      *}
{**********************************AF*}
procedure TfrmModuloCadPgi.pGravaCadPgiGer(strNumDup,
                                           strParcel,
                                           strCodEmp,
                                           strCodFor,
                                           strCodBco,
                                           strCodCta,
                                           strCodBar,
                                           strLinDig,
                                           strProTes,
                                           strSerie_,
                                           strAutInc: String;
                                           dtaDtaCad,
                                           dtaDtaVen,
                                           dtaDtaPag,
                                           dtaDtaEnv: TDateTime;
                                           fltValDup,
                                           fltValJur,
                                           fltValDes,
                                           fltValPag: Double;
                                           intSeqBai: Integer;
                                           intQtdDia: Integer;
                                           strForPgto: String;
                                           strCodTED: String;
                                           strQ_Guia: String;
                                           strCodRec: String;
                                           strCompet: String;
                                           strBcoFor: String;
                                           strTipoPagamento: String;
                                           fltOutEnt: Double;
                                           ASequencialSalario: String;
                                           blnPGG: Boolean;
                                           ACarteiraBancoEnvio : String);
Var
  strTipPag: String;
Begin
  With qryCadPgi Do
  Begin
    Insert;

    if (strTipoPagamento <> '2') And (strCodBco <> '341') then
    begin
      if Copy(strCodBar, 1, 1) = '8' then
         strTipPag := Copy(strCodBar, 2,1)
      else
         strTipPag := '';
    end
    else
      strTipPag := strTipoPagamento;

    FieldByName('PGI_NUMDUP').AsString   := strNumDup;
    FieldByName('PGI_PARCEL').AsString   := strParcel;
    FieldByName('PGI_CODEMP').AsString   := strCodEmp;
    FieldByName('PGI_CODFOR').AsString   := strCodFor;
    FieldByName('PGI_SEQBAI').AsInteger  := intSeqBai;
    FieldByName('PGI_SERIE_').AsString   := strSerie_;
    FieldByName('PGI_CODBCO').AsString   := strCodBco;

    // PAGAMENTOS DE GUIAS GNRE
    If blnPGG Then
      FieldByName('PGI_BCOPGG').AsString   := strCodBco;

    FieldByName('PGI_CODCTA').AsString   := strCodCta;
    FieldByName('PGI_VALDUP').AsFloat    := fltValDup;
    FieldByName('PGI_VALJUR').AsFloat    := fltValJur;
    FieldByName('PGI_VALDES').AsFloat    := fltValDes;
    FieldByName('PGI_OUTENT').AsFloat    := fltOutEnt;

    If (dtaDtaPag <> dtaDtaVen) And (dtaDtaPag >= VS_Date) Then
    Begin
      FieldByName('PGI_VALPAG').AsFloat    := fltValDup - fltValDes;
      FieldByName('PGI_DTAPAG').AsDateTime := dtaDtaPag;
    End
    Else
    Begin
      If intQtdDia > 0 Then
        FieldByName('PGI_VALPAG').AsFloat    := fltValDup
      Else
        FieldByName('PGI_VALPAG').AsFloat    := fltValDup - fltValDes;
      FieldByName('PGI_DTAPAG').AsDateTime := dtaDtaVen;
    End;

    FieldByName('PGI_DTACAD').AsDateTime := dtaDtaCad;
    FieldByName('PGI_DTAVEN').AsDateTime := dtaDtaVen;
    FieldByName('PGI_DTAENV').AsDateTime := dtaDtaEnv;
    FieldByName('PGI_CODBAR').AsString   := strCodBar;
    FieldByName('PGI_LINDIG').AsString   := strLinDig;
    FieldByName('PGI_PROTES').AsString   := strProTes;
    FieldByName('PGI_AUTOIN').AsString   := strAutInc;
    FieldByName('PGI_TIPPAG').AsString   := strTipPag;

    If Not fEmptyStr(strForPgto) then
      FieldByName('PGI_FORPGT').AsString := strForPgto;

    If Not fEmptyStr(strCodTED) Then
      FieldByName('PGI_CODTED').AsString := strCodTED;

    if not fEmptyStr(strBcoFor) then
      FieldByName('PGI_BCOFOR').AsString := strBcoFor;

    FieldByName('PGI_Q_GUIA').AsString   := strQ_Guia;
    FieldByName('PGI_CODREC').AsString   := strCodRec;
    FieldByName('PGI_COMPET').AsString   := strCompet;

    If Not ASequencialSalario.Trim.IsEmpty Then
      FieldByName('PGI_SEQSAL').AsString := ASequencialSalario;

    If not fEmptyStr(ACarteiraBancoEnvio) Then
      FieldByName('PGI_CARTEI').AsString := ACarteiraBancoEnvio;

    Post;
  End;

End;


end.
