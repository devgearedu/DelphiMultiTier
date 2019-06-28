using Embarcadero.Datasnap.WindowsPhone7;
using Microsoft.Phone.Controls;
using System.Windows;
using System.Threading;
using Microsoft.Xna.Framework.Audio;
using Microsoft.Xna.Framework;
using System.Collections.Generic;
using System.Collections.ObjectModel;


namespace CompanyTweetClient
{
    public class CTCallback : DBXCallback
    {
        private SynchronizationContext Context;
        public CTCallback(SynchronizationContext contxt)
            : base()
        {
            Context = contxt;
        }

        public override TJSONValue Execute(TJSONValue value, int JSONType)
        {
            TJSONObject obj = TJSONObject.Parse(value.ToString());
            Context.Send(new SendOrPostCallback(x =>
                {
                    PhoneApplicationFrame frame = Application.Current.RootVisual as PhoneApplicationFrame;
                    PhoneApplicationPage mp = frame.Content as PhoneApplicationPage;
                    if (mp is MainTweetPage)
                    {
                        ((MainTweetPage)mp).listBox1.Items.Add(obj.getString("username") + ": " + obj.getString("message"));
                        SoundEffect.MasterVolume = 1.0f;
                        SoundEffect sfx = SoundEffect.FromStream(TitleContainer.OpenStream("tweet.wav"));
                        SoundEffectInstance sfxInstance = sfx.CreateInstance();
                        sfxInstance.Play();
                    }
                }), null);
            return null;
        }
    }
}
