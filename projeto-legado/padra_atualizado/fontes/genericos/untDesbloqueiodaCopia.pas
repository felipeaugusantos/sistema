unit untDesbloqueiodaCopia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Mask,
  MaskEditFocus, StrUtils, DateUtils, Uni, AppEvnts, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmDesbloqueiodaCopia = class(TfrmPai)
    Panel2: TPanel;
    edtSenDes: TEditFocus;
    Label4: TLabel;
    btnConfirma: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    blnConfirma : Boolean;

  end;


implementation

uses untfuncoesSimples;

{$R *.dfm}

procedure TfrmDesbloqueiodaCopia.FormCreate(Sender: TObject);
begin
  inherited;

  blnConfirma    := False;

end;

procedure TfrmDesbloqueiodaCopia.btnConfirmaClick(Sender: TObject);
  Var
    intSenLib   : Integer;
    intContador : Integer;
    strSenDig   : String;
    strSenDec   : String;
    strSQL      : String;
    strDtaVal   : String;
    wrdAno      : Word;
    wrdMes      : Word;
    wrdDia      : Word;
    qryGenEmp   : TUniQuery;

Const
    intFatMul = 7;

begin
  inherited;

  qryGenEmp := fCriaQuery(Self);

  //*****************************************************//
  // FORMULA PARA DECODIFICACAO DO NUMERO DE DESBLOQUEIO //
  // EX.:                                                //
  // SENHA PARA DECODIFICAR = '000336010'                //
  // DATA ATUAL DO SISTEMA  = '26/03/2007'               //
  // FATOR DE MULTIPLICACAO = '7'                        //
  //                                                     //
  // DIA_ATUAL := ( DIA DE DATE ) =   26                 //
  // MES_ATUAL := ( MES DE DATE ) =    3                 //
  // ANO_ATUAL := ( ANO DE DATE ) = 2007                 //
  //**************************************************ED*//
  strSenDig := Trim(edtSenDes.Text);

  DecodeDate(VS_Date, wrdAno, wrdMes, wrdDia);

  //*****************************************************//
  // SOMA O DIA + O MES E ATRIBUI A VARIAVEL 'SENLIB'    //
  // EX.: SENLIB := 26 + 3 = 29                          //
  //**************************************************ED*//
  intSenLib := wrdDia + wrdMes;

  //*****************************************************//
  // EXECUTA UM FOR SOMADO OS DIGITOS DO ANO             //
  // EX.:  2007 = 2+0+0+7 = 9                            //
  //**************************************************ED*//
  For intContador := 1 To Length(IntToStr(wrdAno)) Do
  Begin
    //*****************************************************//
    // SOMA A VARIAVEL O VALOR DO FOR                      //
    // SENLIB = 29                                         //
    // SENLIB = 29 + (FOR 2+0+0+7 = 9) = 29 + 9 = 38       //
    //**************************************************ED*//
    intSenLib := intSenLib + StrToInt(Copy(IntToStr(wrdAno), intContador, 1));
  End;

  //*****************************************************//
  // SOMA A VARIAVEL OS 3 ULTIMOS CARACTERES DA SEN. DIG //
  // SENLIB := 38 + 010                                  //
  //**************************************************ED*//
  intSenLib := intSenLib + StrToInt(RightStr(strSenDig, 3));

  //*****************************************************//
  // MULTIPLICA A VARIAVEL PELO FATOR DE MULTIPLICACAO   //
  // SENLIB := 48 * 7 = 336                              //
  //**************************************************ED*//
  intSenLib := intSenLib * intFatMul;


  //*****************************************************//
  // CONCATENA EM UMA VARIAVEL OS SEGUINTE VALORES       //
  // SENLIB := STRZERO( SENLIB, TAMANHO(SENHA DIG)-3)    //
  //**************************************************ED*//
  strSenDec := fStrZero(intSenLib, (Length(strSenDig)-3));


  //*****************************************************//
  // SENLIB := 000336                                    //
  // CONCATENA O VALOR DA SEN. CALCULDA + OS 3 ULTIMOS   //
  // DA SENHA DIGITADA = ( 010 )                         //
  // EX.:                                                //
  // SENLIB := SENLIB + 010                              //
  //**************************************************ED*//
  strSenDec := strSenDec + RightStr(strSenDig, 3);

  //*****************************************************//
  // ENTAO A SENHA CALCULADA E IGUAL A                   //
  //                                                     //
  // 000336010, QUE E IGUAL A SENHA DIGITADA             //
  //                                                     //
  //**************************************************ED*//

  //********************************************************//
  // VERIFICA SE A SENHA CALCULADA E IGUAL A SENHA DIGITADA //
  //*****************************************************ED*//
  If strSenDec = strSenDig Then
  Begin

    //*****************************************************//
    // INCREMENTA NA VARIAVEL A QUANTIDADE DE DIAS QUE     //
    // SE DEVE LIBERAR O SISTEMA                           //
    //**************************************************ED*//
    strDtaVal := DateToStr(IncDay(Vs_Date, StrToInt(RightStr(strSenDig, 3))));


    //*****************************************************//
    // FAZ A GRAVACAO NO CADEMP DA NOVA DATA DE VALIDADE   //
    //**************************************************ED*//
    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  EMP_DTAVAL = :DTAVAL ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryGenEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := Trim(VS_strCodEmp);
      ParamByName('DTAVAL').AsString := fCrypt(strDtaVal);
      ExecSQL;
    End;

    //*****************************************************//
    // APAGA O ARQUIVO DA TRAVA                            //
    //**************************************************ED*//
    pCriaApagaTrava(1);

    blnConfirma := True;

  End
  Else
  Begin
    fMensagem('ATENÇÃO','A senha para liberação que foi digitada não é válida!',['&Ok']);
  End;

  btnSair.Click;

  FreeAndNil(qryGenEmp);

end;

end.

