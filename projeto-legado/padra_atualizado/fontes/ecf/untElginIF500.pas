{**************************************************}
{* UNIT COM AS FUNCOES DO ECF (IMPRESSORA FISCAL) *}
{*                                                *}
{* MODELO....: ELGIN ECF IF 500 1E                *}
{* DATA......: 27/02/2007                         *}
{* AUTOR.....: MARLON ANDREI DE CARVALHO "O MITO" *}
{*                                                *}
{***********************************************MA*}
unit untElginIF500;

interface

Uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StrUtils;

type
  TUntElgin = class(TObject)

  constructor Create;

  private

  public

    procedure pSetPatDll( strPatDll: String );
    function  fGetPatDll: String;
    function  fInicia: Integer;
    function  fFinaliza: Integer;

    function  fLeituraX( chaRelGer: Char ): Integer;
    function  fReducaoZ( chaRelGer: Char ): Integer;
    function  fAbreCupom( CNPJ_CPF: String='' ): Integer;
//    function  fVendeItem( strCodIte, strDescri: String; strAlqTri: String; strTipQtd: String; fltQuanti: Double; intQtdDec: Integer; fltUnitar: Double; strTipDes: String; fltDesEsp: Double): Integer;
//    function  fIniciaFechamentoCupom( strAcrDes, strTipDes: String; fltDesEsp: Double ): Integer;
//    function  fEfetuaFormaPagamentoIndice( strCodMod: String; fltValFpg: Double ): Integer;
//    function  fEfetuaFormaPagamentoDescricao( strCodMod: String; fltValFpg: Double; strDesPar: String ): Integer;
//    function  fTerminaFechamentoCupom( strObserv: String ): Integer;
//    function  fRetornaAliquotas( Var strAliquotas: String ): Integer;
    function  fCancelaCupom: Integer;
    function  fImpressoraLigada: Integer;

  End;

Var
  Elgin : TUntElgin;

implementation

Var
  Handle : THandle;
  strDllElgin  : String;

  //'ECF32M.dll';
  OpenCif :function(): Integer; stdcall;
  CloseCif: procedure(); stdcall;

  { Funcoes da impressora }
//  ImprimeValidacao: function( leg: Pchar; LinhaOp: PChar): Integer; stdcall;
//  ModoChequeValidacao: function( tipo:Char ; load:Char): Integer; stdcall;
{  ImprimeCheque: function ( l1: Char; c1: Char;
                            l2: Char; c2: Char;
                            l3: Char; c3: Char;
                            l4: Char;
                            l5: Char; c5: Char;
                            l6: Char;
                            l7: Char;
                            c8: Char;
                            valor: PChar; favorecido: PChar;
                            local: PChar; setano: Char;
                            data: PChar;
                            coment1: PChar; coment2: PChar):Integer;
                            stdcall;}
//  CancelaChequeValidacao: function(): Integer; stdcall;

  { Funcoes de Operacoes Fiscais}
  AbreCupomFiscal: function(): Integer; stdcall;
{  VendaItemStr: function( fmt: PChar; qtd: PChar;
                          punit: PChar; trib: PChar;
                          TDesc: PChar; valor: PChar; unid: PChar;
                          cod: PChar;  ex: PChar;
                          descr: PChar; legendaOP: PChar):Integer;
                          stdcall;
 }
//  DescontoItem: function(toper:Char; valor: PChar; legop: PChar):Integer; stdcall;
//  DescontoItemPorcentagem: function( porcentagem: Pchar; legop: Pchar ):Integer; stdcall;
//  DescontoItemValor: function( valor: Pchar; legop: Pchar ):Integer; stdcall;
//  TotalizarCupom: function(oper: Char; toper: Char; valor: PChar; legendaOP: PChar):Integer; stdcall;

//  TotCupomSemDescAcres: function(): Integer; stdcall;
//  TotCupomAcresValor: function( valor: Pchar; legop: PChar ):Integer; stdcall;
//  TotCupomAcresPorcentagem: function( porcentagem: Pchar; legop: PChar ): Integer; stdcall;
//  TotCupomDescValor: function( valor: Pchar; legop: PChar ): Integer; stdcall;
//  TotCupomDescPorcentagem: function( porcentagem: Pchar; legop: PChar ): Integer; stdcall;

//  TotalizarCupomParcial: function(): Integer; stdcall;
//  Pagamento: function(reg: PChar; vpagto: PChar; subtr: Char):Integer; stdcall;
//  CancelamentoItem: function(numitem: PChar): Integer; stdcall;
//  FechaCupomFiscal: function(tam_msg: PChar; msg: PChar): Integer; stdcall;
  CancelaCupomFiscal: function(): Integer; stdcall;
  LeituraX: function(RelGer : Char): Integer; stdcall;
//  LeituraXComRelGer: function(): Integer; stdcall;
  ReducaoZ: function(RelGer : Char): Integer; stdcall;
//  LeMemFiscalData: function(datai:PChar; dataf: PChar; res: Char):Integer; stdcall;
//  LeMemFiscalReducao: function(redi:PChar; redf: PChar;res: Char):Integer; stdcall;
  TransStatus: function(bittest: Integer; bufStat: PChar): Integer; stdcall;

  {*****************************************}
  {* CONSTRUTOR                            *}
  {**************************************MA*}
  constructor TUntElgin.Create;
  begin
    strDllElgin := '';
  end;

  {*****************************************}
  {* SETA PATH DA DLL                      *}
  {**************************************MA*}
  procedure TUntElgin.pSetPatDll( strPatDll: String );
  begin
    strDllElgin := strPatDll;
  end;

  {*****************************************}
  {* OBTEM PATH DA DLL                     *}
  {**************************************MA*}
  function TUntElgin.fGetPatDll: String;
  begin
    Result := strDllElgin;
  end;

  {*****************************************}
  {* INICIA BEMATECH                       *}
  {**************************************MA*}
  function TUntElgin.fInicia: Integer;
  Begin

    If FileExists( strDllElgin ) Then
    Begin

      Handle := LoadLibrary(PChar(strDllElgin));
      OpenCif := GetProcAddress(Handle, pChar('OpenCif'));
      Result := OpenCif();

    End
    Else
    Begin
      Result := -999;
    End;

  End;

  {*****************************************}
  {* FINALIZA BEMATECH                     *}
  {**************************************MA*}
  function TUntElgin.fFinaliza: Integer;
  Begin

    CloseCif := GetProcAddress(Handle, pChar('CloseCif'));
    CloseCif();

    FreeLibrary(Handle);
    Result := 0;
  End;

  {*****************************************}
  {* LEITURA X                             *}
  {**************************************MA*}
  function TUntElgin.fLeituraX( chaRelGer: Char ): Integer;
  begin
    LeituraX := GetProcAddress(Handle, pChar('LeituraX'));
    Result := LeituraX( chaRelGer );
  end;

  {*****************************************}
  {* REDUCAO Z                             *}
  {**************************************MA*}
  function TUntElgin.fReducaoZ( chaRelGer: Char ): Integer;
  begin
    ReducaoZ := GetProcAddress(Handle, pChar('ReducaoZ'));
    Result := ReducaoZ( chaRelGer );
  end;

  {*****************************************}
  {* ABRE CUPOM FISCAL                     *}
  {**************************************MA*}
  function TUntElgin.fAbreCupom( CNPJ_CPF: String='' ): Integer;
  Begin
    AbreCupomFiscal := GetProcAddress(Handle, pChar('AbreCupomFiscal'));
    Result := AbreCupomFiscal();
  End;

  {*****************************************}
  {* VENDE ITEM                            *}
  {**************************************MA*}
//  function TUntElgin.fVendeItem( strCodIte, strDescri: String; strAlqTri: String; strTipQtd: String; fltQuanti: Double; intQtdDec: Integer; fltUnitar: Double; strTipDes: String; fltDesEsp: Double): Integer;
//  Var //strAlqTri : String;
//      strQuanti : String;
//      strQtdDec : String;
//      strUnitar : String;
//      strDesEsp : String;
//  Begin

    //strDescri := fPadr( strDescri, 29 );
    //strAlqTri := FloatToStrF( fltAlqTri, ffNumber, 5, 2 );

    (*
    strQuanti := FloatToStrF( fltQuanti, ffNumber, 7, 3 );
    strQtdDec := RightStr( '00' + Trim( IntToStr( intQtdDec ) ), 2 );
    strUnitar := FloatToStrF( fltUnitar, ffNumber, 8, 2 );
    strDesEsp := FloatToStrF( fltDesEsp, ffNumber, 8, 2 );

    Elgin_FI_AumentaDescricaoItem := GetProcAddress(Handle, pChar('Elgin_FI_AumentaDescricaoItem'));
    Result := Elgin_FI_AumentaDescricaoItem( strDescri );

    Elgin_FI_VendeItem := GetProcAddress(Handle, pChar('Elgin_FI_VendeItem'));
    Result := Elgin_FI_VendeItem( strCodIte, fPadr( strDescri, 29 ), strAlqTri, strTipQtd, strQuanti, intQtdDec, strUnitar, strTipDes, strDesEsp );
    *)

//  End;

  {*****************************************}
  {* INICIA FECHAMENTO DO CUPOM            *}
  {**************************************MA*}
//  function TUntElgin.fIniciaFechamentoCupom( strAcrDes, strTipDes: String; fltDesEsp: Double ): Integer;
//    Var strDesEsp : String;
//  Begin

    (*
    strDesEsp := FloatToStrF( fltDesEsp, ffNumber, 14, 2 );
    strDesEsp := AnsiReplaceStr( strDesEsp, '.', '' );
    strDesEsp := AnsiReplaceStr( strDesEsp, ',', '' );

    Elgin_FI_IniciaFechamentoCupom := GetProcAddress(Handle, pChar('Elgin_FI_IniciaFechamentoCupom'));
    Result := Elgin_FI_IniciaFechamentoCupom( strAcrDes, strTipDes, strDesEsp );
    *)

//  End;

  {*****************************************}
  {* ATRIBUI OS VALORES DAS FORMAS DE      *}
  {* PAGAMENTO                             *}
  {**************************************MA*}
//  function  TUntElgin.fEfetuaFormaPagamentoIndice( strCodMod: String; fltValFpg: Double ): Integer;
//    Var strValFpg: String;
//  Begin

    (*
    strCodMod := RightStr( '00' + Trim( strCodMod ), 2 );
    strValFpg := FloatToStrF( fltValFpg, ffNumber, 12, 2 );

    Elgin_FI_EfetuaFormaPagamentoIndice := GetProcAddress(Handle, pChar('Elgin_FI_EfetuaFormaPagamentoIndice'));
    Result := Elgin_FI_EfetuaFormaPagamentoIndice( strCodMod, strValFpg );
    *)

//  End;

  {*****************************************}
  {* ATRIBUI OS VALORES DAS FORMAS DE      *}
  {* PAGAMENTO                             *}
  {**************************************MA*}
//  function  TUntElgin.fEfetuaFormaPagamentoDescricao( strCodMod: String; fltValFpg: Double; strDesPar: String ): Integer;
//    Var strValFpg: String;
//  Begin

    (*
    strCodMod := RightStr( '00' + Trim( strCodMod ), 2 );
    strValFpg := FloatToStrF( fltValFpg, ffNumber, 12, 2 );

    If Not fEmptyStr( strDesPar ) Then
      strDesPar := fPadr( strDesPar, 80 );

    Elgin_FI_EfetuaFormaPagamentoIndiceDescricaoForma := GetProcAddress(Handle, pChar('Elgin_FI_EfetuaFormaPagamentoIndiceDescricaoForma'));
    Result := Elgin_FI_EfetuaFormaPagamentoIndiceDescricaoForma( strCodMod, strValFpg, strDesPar );
    *)

//  End;

  {*****************************************}
  {* FINALIZA O CUPOM                      *}
  {**************************************MA*}
//  function TUntElgin.fTerminaFechamentoCupom( strObserv: String ): Integer;
//  Begin

    (*
    Elgin_FI_TerminaFechamentoCupom := GetProcAddress(Handle, pChar('Elgin_FI_TerminaFechamentoCupom'));
    Result := Elgin_FI_TerminaFechamentoCupom( strObserv );
    *)

//  End;

  {*****************************************}
  {* RETORNA AS ALIQUOTAS DE ICMS          *}
  {**************************************MA*}
//  function TUntElgin.fRetornaAliquotas( Var strAliquotas: String ): Integer;
//  Begin

    (*
    strAliquotas := fPadr( strAliquotas, 79 );

    Elgin_FI_RetornoAliquotas := GetProcAddress(Handle, pChar('Elgin_FI_RetornoAliquotas'));
    Result := Elgin_FI_RetornoAliquotas( strAliquotas );
    *)

//  End;

  {*****************************************}
  {* RETORNA AS ALIQUOTAS DE ICMS          *}
  {**************************************MA*}
  function TUntElgin.fCancelaCupom: Integer;
  Begin
    CancelaCupomFiscal := GetProcAddress(Handle, pChar('CancelaCupomFiscal'));
    Result := CancelaCupomFiscal();
  End;

  {*****************************************}
  {* RETORNA IMPRESSORA LIGADA             *}
  {**************************************MA*}
  function TUntElgin.fImpressoraLigada: Integer;
  Var
    BufStat: array[0..39] of Char;
  Begin
    TransStatus := GetProcAddress(Handle, pChar('TransStatus'));
    Result := TransStatus(0,BufStat);
  End;

End.
