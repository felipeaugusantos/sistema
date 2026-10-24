unit untFisLeituraMemoria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Mask,
  MaskEditFocus, ComCtrls, untFiscal, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmFisLeituraMemoria = class(TfrmPai)
    pgcDados: TPageControl;
    tbsData: TTabSheet;
    tbsReducao: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    edtRedIni: TEditFocus;
    edtRedFin: TEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    btnGravar: TBitBtnLocked;
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    ecfFiscal : TUntFiscal;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
    strModEcf : String;
    strCodErr : String;
    strPatIni : String;
    strPorta  : String;
    
  end;

var
  frmFisLeituraMemoria: TfrmFisLeituraMemoria;

implementation

uses  untfuncoesSimples, untWaitWindow;

{$R *.dfm}

procedure TfrmFisLeituraMemoria.btnGravarClick(Sender: TObject);
begin
  inherited;

  If fMensagem('AVISO', 'Imprimir Leitura da memória fiscal?', ['&Sim', '&Não']) = 2 Then
    Exit;

  ecfFiscal := TUntFiscal.Create;
  ecfFiscal.strCodVen := strLoginUsuarioLogado;
  ecfFiscal.strNomVen := fRetNomeOperador(strLoginUsuarioLogado);

  Try

    pCriarFormularios(TfrmWaitWindow, frmWaitWindow);
    frmWaitWindow.lblTexto.Caption := 'Aguarde, Imprimindo Leitura da Mem. Fiscal';
    frmWaitWindow.tmrWait.Enabled := False;

    frmFisLeituraMemoria.Enabled := False;


    Try

      If Not ecfFiscal.pSetModEcf( strModEcf ) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não foi possivel setar o Modelo da Impressora. Verifique o Modelo Configurado!', ['&Ok']);
        Exit;
      End;

      If Not ecfFiscal.fIniciaEcf( strCodErr, strPatIni, strPorta ) Then
      Begin
        fMensagem('ATENÇÃO!', ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
        Exit;
      End;

      If Not ecfFiscal.fRetImpLigada( strCodErr ) Then
      Begin
        fMensagem('ATENÇÃO!', ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
        Exit;
      End;

      //Tela de Espera

      frmFisLeituraMemoria.Refresh;
      AnimateWindow(frmWaitWindow.Handle, 200, AW_BLEND);
      frmWaitWindow.Show;
      frmWaitWindow.Refresh;

      Try

        //*************************************************//
        // VERIFICA QUAL TIPO DE LEITURA DEVE SER EFETURAD.//
        //**********************************************ED*//
        If pgcDados.ActivePageIndex = 0 Then
          ecfFiscal.fLeituraMemFiscal(strCodErr, mskDtaIni.Text, mskDtaFin.Text, 0 )
        Else

          ecfFiscal.fLeituraMemFiscal(strCodErr, edtRedIni.Text, edtRedFin.Text, 1 );


        ecfFiscal.fRetMensErro( strCodErr, True );

      Finally
        If Not ecfFiscal.fFinalizaEcf( strCodErr ) Then
        Begin
          fMensagem('ATENÇÃO!', ecfFiscal.fRetMensErro( strCodErr ), ['&Ok']);
        End;
      End;

    Except
      fMensagem('ATENÇÃO!', 'Não foi possivel emitir a Leitura da memória fiscal. Verifique as configurações do sistema!', ['&Ok']);
    End;

    frmFisLeituraMemoria.Enabled := True;
    ecfFiscal.Free;
    frmWaitWindow.Close;

  Except
    On E: Exception Do
    Begin
     pMensagensErro(E.Message, '[frmFisLeituraMemoria.btnGravarClick]');
    End;
  End;

  pFreeAndNil(frmWaitWindow);

  Close;

end;

function TfrmFisLeituraMemoria.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  //*************************************************//
  // VALIDA O CAMPO DATA INICIAL                     //
  //**********************************************ED*//
  If (Sender = mskDtaIni) And (pgcDados.ActivePageIndex = 0) Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A data inicial deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
  End

  {*****************************************}
  {* VALIDA A DATA FINAL                   *}
  {**************************************ED*}
  Else If (Sender = mskDtaFin) And (pgcDados.ActivePageIndex = 0) Then
  Begin
    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
    Begin
      If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
        Result := False;
      End;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
      Result := False;
    End;

  End

  //*************************************************//
  // VALIDA O CAMPO REDUCAO INICIAL                  //
  //**********************************************ED*//
  Else If (Sender = edtRedIni) And (pgcDados.ActivePageIndex = 1) Then
  Begin
    If fEmptyStr(edtRedIni.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A redução inicial deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
  End

  //*************************************************//
  // VALIDA O CAMPO REDUCAO FINAL                    //
  //**********************************************ED*//
  Else If (Sender = edtRedFin) And (pgcDados.ActivePageIndex = 1) Then
  Begin
    If fEmptyStr(edtRedFin.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A redução final deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If StrToInt(edtRedIni.Text) > StrToInt(edtRedFin.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A redução inicial não deve ser maior que a final!', ['&Ok']);
      Result := False;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;


end.


